CXX=g++

CUDA_INSTALL_PATH=/opt/cuda
CFLAGS= -I. -I$(CUDA_INSTALL_PATH)/include `pkg-config --cflags opencv`
LDFLAGS= -L$(CUDA_INSTALL_PATH)/lib64 -lcublas -lcudart -lcufft -lcurand `pkg-config --libs opencv`

all:
	nvcc $(CFLAGS) -c  ../algorithm.cu -o algorithm.o
	nvcc $(CFLAGS) -c  ../kernels.cu -o kernels.o
	$(CXX) $(CFLAGS) -c ../display.cpp -o display.o
	$(CXX) $(CFLAGS) -c ../main.cpp -o main.o
	$(CXX) $(LDFLAGS) main.o algorithm.o kernels.o display.o -o showGS

clean:
	rm -f Debug/*.o Debug/showFFT