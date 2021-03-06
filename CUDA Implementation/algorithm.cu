/*
 * algorithm.cu
 *
 *  Created on: 9 May 2020
 *      Author: Cristian Bourceanu
 */
#include "algorithm.h"


//*********** OpBlocks Definitions ***********//

OpBlocks::OpBlocks(int nx,int ny):nx(nx),ny(ny){
	if((error = cufftPlan2d(&planFFT,nx,ny, CUFFT_C2C))!=CUFFT_SUCCESS){
		printf("CUFFT error: Plan creation failed");
	}
	if((stat_cublas = cublasCreate(&handle_cublas))!=CUBLAS_STATUS_SUCCESS){
		printf("cuBLAS error: Handle creation failed");
	}
	if((stat_curand =curandCreateGenerator(&curand_gen, CURAND_RNG_PSEUDO_DEFAULT))!=CURAND_STATUS_SUCCESS){
		printf("cuRAND error: Generator creation failed");
	}
	CURAND_CALL(curandSetPseudoRandomGeneratorSeed(curand_gen, 1234ULL));
	CUDA_CALL(cudaMalloc((void**)&d_sum,sizeof(*d_sum)));
	CUDA_CALL(cudaMalloc((void**)&d_sumROI,sizeof(*d_sumROI)));
	CUDA_CALL(cudaMalloc((void**)&d_min,sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&d_max,sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&d_mutex,sizeof(int)));
	CUDA_CALL(cudaMemset(d_mutex,0,sizeof(int)));
}
OpBlocks::~OpBlocks(){
	CUDA_CALL(cudaFree(d_sum));
	CUDA_CALL(cudaFree(d_sumROI));
	CUDA_CALL(cudaFree(d_min));
	CUDA_CALL(cudaFree(d_max));
	CUDA_CALL(cudaFree(d_mutex));
	CUFFT_CALL(cufftDestroy(planFFT));
	CUBLAS_CALL(cublasDestroy(handle_cublas)); 
	printf("OpBlocks destructed successfully!\n");
}
cublasHandle_t& OpBlocks::GetCUBLAS(){
	return handle_cublas;
}
void OpBlocks::SLM_To_Obj(cuComplex *d_SLM,cuComplex *d_Obj){
	CUFFT_CALL(cufftExecC2C(planFFT,d_SLM,d_Obj,CUFFT_INVERSE));
	//scaleFourier_kernel<<<(nx*ny+1023)/1024,1024>>>(d_Obj,nx*ny);
	float scale = 1.0/(nx*ny);
	cudaDeviceSynchronize();
	CUBLAS_CALL(cublasCsscal(handle_cublas,nx*ny,&scale,d_Obj,1));

}
void OpBlocks::Obj_to_SLM(cuComplex *d_Obj,cuComplex *d_SLM){
	CUFFT_CALL(cufftExecC2C(planFFT,d_Obj,d_SLM,CUFFT_FORWARD));
}

void OpBlocks::Compose(cuComplex *d_signal,float *d_amp,float *d_phase){
	Comp_kernel<<<(nx*ny+1023)/1024,1024>>>(d_signal,d_amp,d_phase,nx*ny);
}
void OpBlocks::Decompose(cuComplex *d_signal,float *d_amp,float *d_phase){
	Decomp_kernel<<<(nx*ny+1023)/1024,1024>>>(d_signal,d_amp,d_phase,nx*ny);
}
void OpBlocks::Sum(float *d_adto,float *d_increment){
	const float one=1.0f;
	CUBLAS_CALL(cublasSaxpy(handle_cublas,nx*ny,&one,d_increment,1,d_adto,1));
}
void OpBlocks::Scale(float *d_signal,float scaling){
	CUBLAS_CALL(cublasSscal(handle_cublas,nx*ny,&scaling,d_signal,1));
}
void OpBlocks::RandomArray(float* d_array,float min, float max){
	curandGenerateNormal(curand_gen,d_array,nx*ny,min,max);
}
void OpBlocks::ZeroArray(float* d_array,size_t n_bytes){
	CUDA_CALL(cudaMemset(d_array,0,n_bytes*sizeof(float)));
}
void OpBlocks::MapUnity(float *d_quantity, char verbose){
	float h_min,h_max;
	minmax_kernel<<<32,1024>>>(d_quantity,d_min,d_max,d_mutex,nx*ny);
	cudaDeviceSynchronize();
	cudaMemcpy(&h_max,d_max,sizeof(float),cudaMemcpyDeviceToHost);
	cudaMemcpy(&h_min,d_min,sizeof(float),cudaMemcpyDeviceToHost);
	VERB_EXEC(printf("OpBlocks.MapUnity: (Min, Max)=(%f, %f)",h_min,h_max),verbose);
	if(h_min!=h_max){
	Scale(d_quantity,1/(h_max-h_min));
	addFloatArray_kernel<<<(nx*ny+1023)/1024,1024>>>(d_quantity,nx*ny,-h_min/(h_max-h_min));		//Couldn't find cublas to add scalar to an array
	VERB_EXEC(printf(" - Mapped \n"),verbose);
	}
	else VERB_EXEC(printf(" - Null vector \n"),verbose);
}
void OpBlocks::Normalize(float *d_quantity, char verbose){
	float h_norm;
	 CUBLAS_CALL(cublasSnrm2(handle_cublas,nx*ny,d_quantity,1, &h_norm));
	// norm2_kernel<<<(nx*ny+1023)/10241024>>>(d_quantity,d_min,d_mutex,nx*ny);
	// CUDA_CALL(cudaMemcpy(&h_norm,d_min,sizeof(float),cudaMemcpyDeviceToHost));
	VERB_EXEC(printf("Norm=%f\n",h_norm),verbose);
	if(h_norm){
		h_norm=1/h_norm;
		CUBLAS_CALL(cublasSscal(handle_cublas,nx*ny,&h_norm,d_quantity,1));
	}
}
void OpBlocks::Intensity(float *d_amp,float *d_intensity){
	amplitudeToIntensity_kernel<<<(nx*ny+1023)/1024,1024>>>(d_amp,d_intensity,nx*ny);
}
void OpBlocks::NormalizedIntensity(float *d_amp,float *d_intensity){
	amplitudeToIntensity_kernel<<<(nx*ny+1023)/1024,1024>>>(d_amp,d_intensity,nx*ny);
	Normalize(d_intensity);
}
/**
 * @brief Uniformity within the region of interest
 * 
 * @param d_signal Signal whose host.uniformity is assesed
 * @param d_ROI 	Array of indexes of the elements in the ROI
 * @param n_ROI 	Length of d_ROI
 */
float OpBlocks::Uniformity(float *d_signal,unsigned int *d_ROI,unsigned int n_ROI, char verbose){
	cudaDeviceSynchronize();
	minmaxROI_kernel<<<32,1024>>>(d_signal,d_min,d_max,d_mutex,d_ROI,n_ROI);
	float h_min,h_max;
	CUDA_CALL(cudaMemcpy(&h_max,d_max,sizeof(float),cudaMemcpyDeviceToHost));
	CUDA_CALL(cudaMemcpy(&h_min,d_min,sizeof(float),cudaMemcpyDeviceToHost));
	if(verbose) printf("Unif=%f\n",1-(h_max-h_min)/(h_max+h_min));
	return 1-(h_max-h_min)/(h_max+h_min);
}
float OpBlocks::Efficiency(float *d_signal,unsigned int *d_ROI,unsigned int n_ROI,unsigned int length){
	cudaDeviceSynchronize();
	efficiency_kernel<<<32,1024>>>(d_signal,d_sumROI,d_sum,d_mutex,d_ROI,n_ROI,length);
	cudaDeviceSynchronize();
	float h_sumSR,h_sum;
	CUDA_CALL(cudaMemcpy(&h_sumSR,d_sumROI,sizeof(float),cudaMemcpyDeviceToHost));
	CUDA_CALL(cudaMemcpy(&h_sum,d_sum,sizeof(float),cudaMemcpyDeviceToHost));
	VERB_EXEC(printf("Efficiency: %f\n",h_sumSR/h_sum),0);
	return h_sumSR/h_sum;
}
float OpBlocks::Accuracy(float *d_Out,float *d_In,unsigned int *d_ROI,unsigned int n_ROI){
	float h_sumerr2;
	cudaDeviceSynchronize();
	accuracy_kernel<<<32,256>>>(d_Out,d_In,d_sumROI,d_mutex,d_ROI,n_ROI);
	CUDA_CALL(cudaMemcpy(&h_sumerr2,d_sumROI,sizeof(float),cudaMemcpyDeviceToHost));
	VERB_EXEC(printf("OpBlocks.Accuracy(): ErrSquared=%f, N_ROI=%d, Acc=%f\n",h_sumerr2,n_ROI,sqrt(h_sumerr2/n_ROI)),0);
	return sqrt(h_sumerr2/n_ROI);
}
void OpBlocks::PerformanceMetrics(DeviceMemory &device,HostMemory &host){
	NormalizedIntensity(device.ampOut,device.intensity);
	host.uniformity.push_back(Uniformity(device.intensity,device.SR,host.n_SR));
	host.efficiency.push_back(Efficiency(device.intensity,device.SR,host.n_SR,host.nx*host.ny));
	host.accuracy.push_back(Accuracy(device.intensity,device.dint,device.SR,host.n_SR));
}



//*********** PhaseRetrieve ***********//

PhaseRetrieve::PhaseRetrieve(float *gray_img,unsigned int nx,unsigned int ny, PR_Type type):
nx(nx),ny(ny){
	InitGPU(0);

	//Host memory allocation
	host.complex=(cuComplex*)malloc(nx*ny*sizeof(cuComplex));
	host.illum=(float*)malloc(nx*ny*sizeof(float));
	host.dint=(float*)malloc(nx*ny*sizeof(float));
	host.damp=(float*)malloc(nx*ny*sizeof(float));
	host.amp=(float*)malloc(nx*ny*sizeof(float));
	host.ampOut=(float*)malloc(nx*ny*sizeof(float));
	host.phSLM=(float*)malloc(nx*ny*sizeof(float));
	host.phImg=(float*)malloc(nx*ny*sizeof(float));
	host.intensity=(float*)malloc(nx*ny*sizeof(float));
	h_out_img=(float*)malloc(nx*ny*sizeof(float));
	h_out_phase=(float*)malloc(nx*ny*sizeof(float));

	//Device memory allocation
	CUDA_CALL(cudaMalloc((void**)&device.complex,nx*ny*sizeof(cuComplex)));
	CUDA_CALL(cudaMalloc((void**)&device.illum,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.dint,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.damp,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.amp,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.ampOut,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.phSLM,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.phImg,nx*ny*sizeof(float)));
	CUDA_CALL(cudaMalloc((void**)&device.intensity,nx*ny*sizeof(float)));

	host.nx=nx;	host.ny=ny;

	operation=new OpBlocks(nx,ny);
	SetIllumination();
	SetImage(gray_img);
	SetAlgorithm(type);
}

PhaseRetrieve::~PhaseRetrieve(){
	free(host.complex);	free(host.damp);		free(host.dint);		free(host.amp);		free(host.phSLM);
	free(host.intensity);		free(h_out_img);	free(h_out_phase);	free(host.illum);
	free(host.ampOut);		free(host.phImg);
	cudaFree(device.complex);	cudaFree(device.damp);		cudaFree(device.dint);
	cudaFree(device.amp);		cudaFree(device.phSLM);	
	cudaFree(device.intensity);		cudaFree(device.illum);
	cudaFree(device.ampOut);	cudaFree(device.phImg);
	if(host.ROI){	free(host.ROI);	cudaFree(device.ROI);}	
	if(host.SR){	free(host.SR);	cudaFree(device.SR);}
	delete algorithm;
	delete operation;
	printf("PhaseRetrieve destructed successfully!\n");
}
void PhaseRetrieve::InitGPU(int device_id){
	int devCount;
    cudaGetDeviceCount(&devCount);	//number of GPUs available
	if(device_id<devCount)		//check if there are enogh GPUs
        cudaSetDevice(device_id);
    else exit(1);
}
void PhaseRetrieve::SetAlgorithm(PR_Type type){
	unsigned int idx=0;
	if(algorithm){
		idx=algorithm->GetIndex();
		delete algorithm;
	}
	algorithm=AlgorithmCreator().FactoryMethod(operation,device,host,type);
	algorithm->SetIndex(idx);
}
void PhaseRetrieve::SetImage(float *gray_img){
	int indx=1080000;
	for(int i=0;i<nx*host.ny;i++)
		host.dint[i]=gray_img[i];
	
		printf("%f ",host.dint[indx]);
	
	CUDA_CALL(cudaMemcpy(device.dint, host.dint, host.nx*host.ny*sizeof(float), cudaMemcpyHostToDevice));

	sqrt_kernel<<<(nx*ny+1023)/1024,1024>>>(device.dint,device.damp,nx*ny);

	operation->Normalize(device.dint);

	operation->Normalize(device.damp);

	CUDA_CALL(cudaMemcpy(host.dint,device.dint,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));
	CUDA_CALL(cudaMemcpy(host.damp,device.damp,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));
	printf("%f %f ",host.dint[indx],host.damp[indx]);
}
void PhaseRetrieve::SetIllumination(float *illum_img){
	for(int i=0;i<ny;i++)
		for(int j=0;j<nx;j++)
			host.illum[index(i,j)]=sqrt(illum_img[index(i,j)]);
	CUDA_CALL(cudaMemcpy(device.illum,host.illum,nx*ny*sizeof(float),cudaMemcpyHostToDevice));
}
void PhaseRetrieve::SetIllumination(){
	for(int i=0;i<ny;i++)
		for(int j=0;j<nx;j++)
			host.illum[index(i,j)]=sqrt(255);
	CUDA_CALL(cudaMemcpy(device.illum,host.illum,nx*ny*sizeof(float),cudaMemcpyHostToDevice));
}
void PhaseRetrieve::FindSR(float threshold){
	if(host.n_SR==0){
		host.SR=(unsigned int*)malloc(host.nx*host.ny*sizeof(unsigned int));
		for(unsigned int i=0;i<host.nx*host.ny;i++)
			if(host.intensity[i]>threshold){
				host.SR[host.n_SR++]=i;
			}
		CUDA_CALL(cudaMalloc((void**)&device.SR,host.n_SR*sizeof(unsigned int)));
		CUDA_CALL(cudaMemcpy(device.SR,host.SR,host.n_SR*sizeof(unsigned int),cudaMemcpyHostToDevice));
	}
}
void PhaseRetrieve::FindROI(float threshold){
	if(host.n_ROI==0){
		host.ROI=(unsigned int*)malloc(host.nx*host.ny*sizeof(unsigned int));
		printf("FindROI: Domain length=%d\n",host.nx*host.ny);
		for(unsigned int i=0;i<host.nx*host.ny;i++)
			if(host.intensity[i]>=threshold){
				host.ROI[host.n_ROI++]=i;
			}
		CUDA_CALL(cudaMalloc((void**)&device.ROI,host.n_ROI*sizeof(unsigned int)));
		CUDA_CALL(cudaMemcpy(device.ROI,host.ROI,host.n_ROI*sizeof(unsigned int),cudaMemcpyHostToDevice));
	}
}
float* PhaseRetrieve::GetROIMask(){
	if(ROI_Mask==NULL){
		ROI_Mask=(float*)malloc(host.nx*host.ny*sizeof(float));
		for(int i=0;i<host.nx*host.ny;i++)
			ROI_Mask[i]=0.0;
		for(int i=0;i<host.n_ROI;i++)
			ROI_Mask[host.ROI[i]]=255.0;
	}
	return ROI_Mask;
}
void PhaseRetrieve::SetROI(float x, float y, float r){
	if(host.n_ROI>0){
		cudaFree(device.ROI);
		host.n_ROI=0;
	}
	else
		host.ROI=(unsigned int*)malloc(host.nx*host.ny*sizeof(unsigned int));

	char *not_checked;
	not_checked=new char[host.nx*host.ny];
	for(int i=0;i<host.nx*host.ny;i++)
		not_checked[i]=1;
	std::queue<int> queuex;
	std::queue<int> queuey;
	int x_pix=floor(x); int y_pix=floor(y);
	if(pow(x_pix-x,2)+pow(y_pix-y,2)<=r*r){
		not_checked[index(x_pix,y_pix)]=0;
		queuex.push(x_pix);
		queuey.push(y_pix);
	}
	int posx[]={-1,0,1,-1,1,-1,0,1};
	int posy[]={-1,-1,-1,0,0,1,1,1};
	while(!queuex.empty()&&!queuey.empty()){
		x_pix=queuex.front(); 
		y_pix=queuey.front(); 
		queuex.pop();
		queuey.pop();
		host.ROI[host.n_ROI++]=index(x_pix,y_pix);
		for(int i=0;i<8;i++)
			if(pow(x_pix+posx[i]-x,2)+pow(y_pix+posy[i]-y,2)<=r*r && not_checked[index(x_pix+posx[i],y_pix+posy[i])]){
				not_checked[index(x_pix+posx[i],y_pix+posy[i])]=0;
				queuex.push(x_pix+posx[i]);
				queuey.push(y_pix+posy[i]);
			}
				
	}
	printf("FindROI: nROI=%d\n",host.n_ROI);
	delete[] not_checked;
	CUDA_CALL(cudaMalloc((void**)&device.ROI,host.n_ROI*sizeof(unsigned int)));
	CUDA_CALL(cudaMemcpy(device.ROI,host.ROI,host.n_ROI*sizeof(unsigned int),cudaMemcpyHostToDevice));
}
unsigned int PhaseRetrieve::index(unsigned int i, unsigned int j){
	return nx*i+j;
}

void PhaseRetrieve::InitCompute(){
	operation->MapUnity(device.damp);
	operation->Intensity(device.damp,device.intensity);
	
	CUDA_CALL(cudaMemcpy(host.intensity,device.intensity,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));

	FindSR(0.5);
	if(!host.n_ROI){
		FindROI(0.5);
		strcpy(type,"_SR");
	}
	else
		strcpy(type,"_ROI");
	stage=1;
}
void PhaseRetrieve::Compute(int niter){
	if(stage<1)	InitCompute();
	
	algorithm->Initialize();
	
	for(int i=0;i<niter;i++){
		algorithm->OneIteration();
		operation->PerformanceMetrics(device, host);
	}
}
void PhaseRetrieve::PrepareResults(){
	operation->Intensity(device.ampOut,device.intensity);
	operation->MapUnity(device.intensity);

	CUDA_CALL(cudaMemcpy(host.intensity,device.intensity,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));

	operation->MapUnity(device.ampOut);
	CUDA_CALL(cudaMemcpy(host.ampOut,device.ampOut,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));

	operation->MapUnity(device.phSLM);
	CUDA_CALL(cudaMemcpy(h_out_phase,device.phSLM,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));

	operation->MapUnity(device.damp);
	CUDA_CALL(cudaMemcpy(host.damp,device.damp,nx*ny*sizeof(float),cudaMemcpyDeviceToHost));

	float err=0;
	for(int i=0;i<ny;i++)
		for(int j=0;j<nx;j++){
			err+=pow((host.damp[index(i,j)]-host.ampOut[index(i,j)]),2);
			h_out_img[index(i,j)]=255*host.intensity[index(i,j)];
			h_out_phase[index(i,j)]=255*h_out_phase[index(i,j)];
		}

	printf("Error squared: %f\n",err);
	stage=2;
}

float* PhaseRetrieve::GetImage(){
	if(stage<2)	PrepareResults();
	return h_out_img;
}

float* PhaseRetrieve::GetPhaseMask(){
	if(stage<2)	PrepareResults();
	return h_out_phase;
}

std::vector<std::vector<float>>& PhaseRetrieve::GetMetrics(){
	metrics.push_back(host.uniformity);
	metrics.push_back(host.accuracy);
	metrics.push_back(host.efficiency);
	return metrics;
}


/********** Algorithms Implementation ***************/

void GS_ALG::Initialize(){
	if(index_iter==0)
		operation->RandomArray(device.phImg,-M_PI,M_PI);
}
void GS_ALG::OneIteration(){
	IncrementIndex();
	operation->Compose(device.complex,device.damp,device.phImg);
	operation->Obj_to_SLM(device.complex,device.complex);
	operation->Decompose(device.complex,device.amp,device.phSLM);
	operation->Compose(device.complex,device.illum,device.phSLM);
	operation->SLM_To_Obj(device.complex,device.complex);
	operation->Decompose(device.complex,device.ampOut,device.phImg);
}

void MRAF_ALG::Initialize(){
	if(index_iter==0){
		operation->ZeroArray(device.ampOut,host.nx * host.ny);
		operation->MapUnity(device.damp);
		operation->RandomArray(device.phImg,-M_PI,M_PI);
		operation->RandomArray(device.phSLM,-M_PI,M_PI);
	}
}
void MRAF_ALG::Initialize(float param){
	m=param;
	if(index_iter==0){
		operation->ZeroArray(device.ampOut,host.nx * host.ny);
		operation->MapUnity(device.damp);
		operation->RandomArray(device.phImg,-M_PI,M_PI);
		operation->RandomArray(device.phSLM,-M_PI,M_PI);
	}
}
void MRAF_ALG::OneIteration(){
	//MRAF Scaling the desired amplitude for correction
	IncrementIndex();
	operation->MapUnity(device.ampOut);
	//addROI_kernel<<<(host.n_SR+1024)/1024,1024>>>(device.damp,1,device.ampOut,(m-1),device.SR,host.n_SR);
	addROI_kernel<<<(host.n_ROI+1024)/1024,1024>>>(device.damp,1,device.ampOut,(m-1),device.ROI,host.n_ROI);

	operation->Compose(device.complex,device.ampOut,device.phImg);
	operation->Obj_to_SLM(device.complex,device.complex);
	operation->Decompose(device.complex,device.amp,device.phSLM);
	operation->Compose(device.complex,device.illum,device.phSLM);
	operation->SLM_To_Obj(device.complex,device.complex);
	operation->Decompose(device.complex,device.ampOut,device.phImg);
	
	//operation->Intensity(device.ampOut,device.intensity);
}

void UCMRAF_ALG::Initialize(){
	if(index_iter==0){
		operation->ZeroArray(device.ampOut,host.nx * host.ny);
		operation->MapUnity(device.damp);
		operation->RandomArray(device.phImg,-M_PI,M_PI);
		operation->RandomArray(device.phSLM,-M_PI,M_PI);
	}
}
void UCMRAF_ALG::OneIteration(){
	//UCMRAF Scaling the desired amplitude for correction
	float u=0;
	IncrementIndex();
	if(host.uniformity.size())
		u=host.uniformity.back();
	operation->MapUnity(device.ampOut);
	
	//addROI_kernel<<<(host.n_SR+1024)/1024,1024>>>(device.damp,1,device.ampOut,(u-1),device.SR,host.n_SR);
	addROI_kernel<<<(host.n_ROI+1024)/1024,1024>>>(device.damp,1,device.ampOut,(u-1),device.ROI,host.n_ROI);
	
	operation->Compose(device.complex,device.ampOut,device.phImg);
	operation->Obj_to_SLM(device.complex,device.complex);
	operation->Decompose(device.complex,device.amp,device.phSLM);
	operation->Compose(device.complex,device.illum,device.phSLM);
	operation->SLM_To_Obj(device.complex,device.complex);
	operation->Decompose(device.complex,device.ampOut,device.phImg);
	
}
void WGS_ALG::Initialize(){
	// operation->ZeroArray(device.weight,host.nx*host.ny);
	// CUDA_CALL(cudaMemcpy(device.ampOutBefore,device.damp,host.nx*host.ny*sizeof(float),cudaMemcpyDeviceToDevice));
	
	if(index_iter==0){
	operation->RandomArray(device.phImg,-M_PI,M_PI);
	operation->RandomArray(device.phSLM,-M_PI,M_PI);
	}

	CUDA_CALL(cudaMemcpy(device.weight,device.damp,host.nx*host.ny*sizeof(float),cudaMemcpyDeviceToDevice));
}
void WGS_ALG::OneIteration(){

	if(index_iter<2)
	CUDA_CALL(cudaMemcpy(device.weight,device.damp,host.nx*host.ny*sizeof(float),cudaMemcpyDeviceToDevice));

	IncrementIndex();
	operation->Compose(device.complex,device.weight,device.phImg);
	operation->Obj_to_SLM(device.complex,device.complex);
	operation->Decompose(device.complex,device.amp,device.phSLM);
	operation->Compose(device.complex,device.illum,device.phSLM);
	operation->SLM_To_Obj(device.complex,device.complex);
	operation->Decompose(device.complex,device.ampOut,device.phImg);

	operation->Intensity(device.ampOut,device.intensity);
	updatedInt();
	operation->MapUnity(device.intensity);
	weight_kernel<<<(host.nx*host.ny+1023)/1024,1024>>>(device.weight,device.weight,device.intensity,device.dint,device.SR,host.n_SR);
	operation->MapUnity(device.weight);


	// IncrementIndex();
	// operation->Compose(device.complex,device.illum,device.phSLM);
	// operation->SLM_To_Obj(device.complex,device.complex);
	// operation->Decompose(device.complex,device.ampOut,device.phImg);

	// operation->Intensity(device.ampOut,device.intensity);
	// updatedInt();
	// operation->MapUnity(device.intensity);

	// weight_kernel<<<(host.nx*host.ny+1023)/1024,1024>>>(device.weight,device.ampOutBefore,device.intensity,device.dint,device.SR,host.n_SR);

	// operation->Compose(device.complex,device.weight,device.phImg);
	// operation->Obj_to_SLM(device.complex,device.complex);
	// operation->Decompose(device.complex,device.amp,device.phSLM);
	// CUDA_CALL(cudaMemcpy(device.ampOutBefore,device.weight,host.nx*host.ny*sizeof(float),cudaMemcpyDeviceToDevice));
}