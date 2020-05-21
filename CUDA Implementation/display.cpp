/*
 * display.cpp
 *
 *  Created on: 10 May 2020
 *      Author: Cristian Bourceanu
 */
#include "display.h"

void space2underscore(char *str,int length){
    for(int i=0;i<length;i++)
        if(str[i]==' ')
            str[i]='_';
}

ImagePR::ImagePR(int width, int height,int coloring):color_display(coloring)
{
    SetDimensions(width,height);
    image=cv::Mat(height,width,CV_8UC3);
    gray_image=cv::Mat(height,width,cv::IMREAD_GRAYSCALE);
    printf("Dim=%d",height*width);
    gray_array=(float*)malloc(height*width*sizeof(float));
    printf("Memory allocated for blank image\n");
}

ImagePR::ImagePR(const char *path,int coloring):color_display(coloring){
    image = cv::imread( path, cv::IMREAD_COLOR);
    if( !image.data )
	{
	  printf( "No image data \n" );
	  exit(-1);
	}
    SetDimensions(image.cols,image.rows);

    cv::cvtColor(image,gray_image,cv::COLOR_BGR2GRAY);
    gray_array=(float*)malloc(height*width*sizeof(float));
    printf("Memory allocated for inserted image\n");
}

ImagePR::~ImagePR()
{
    if(gray_array)
        free(gray_array);
    printf("Image object destructed successfully!\n");
}

float* ImagePR::GetGray(){
     printf("Get %d\n",height*width);
    for(int i=0;i<height;i++)
        for(int j=0;j<width;j++){
            //cv::Vec3b color = image.at<cv::Vec3b>(cv::Point(j,i));
            //gray_array[i*width+j]=float(0.3*color[0]+0.3*color[1]+0.3*color[2]);
            unsigned char color = gray_image.at<unsigned char>(cv::Point(j,i));
            gray_array[i*width+j]=(float)color;
        }
    return gray_array;
}

void ImagePR::SetGray(float *array, int width_original, int height_original){
    int y_o,x_o;
    for(int y=0;y<height;y++)
        for(int x=0;x<width;x++){
            //image.at<cv::Vec3b>(x,y)[0] = 200;
            y_o=y+(height_original-height)/2;
            x_o=x+(width_original-width)/2;
            cv::Vec3b & color = image.at<cv::Vec3b>(cv::Point(x,y));
            unsigned char & colorG = gray_image.at<unsigned char>(cv::Point(x,y));
            colorG=color[2]=color[1]=color[0]=(unsigned char) array[y_o*width_original+x_o];
            gray_array[y*width+x]=array[y_o*width_original+x_o];
        }
}
void ImagePR::SetGray(float *array){
    for(int y=0;y<height;y++)
        for(int x=0;x<width;x++){
            //image.at<cv::Vec3b>(x,y)[0] = 200;
            cv::Vec3b & color = image.at<cv::Vec3b>(cv::Point(x,y));
            unsigned char & colorG = gray_image.at<unsigned char>(cv::Point(x,y));
            colorG=color[2]=color[1]=color[0]=(unsigned char) array[y*width+x];
            gray_array[y*width+x]=array[y*width+x];
        }
}

void ImagePR::MakeGaussian(float x_0,float y_0,float var_x, float var_y){
    float val=0;
    for(int y=0;y<height;y++)
        for(int x=0;x<width;x++){
            val=255*exp(-(pow(x-x_0,2)/(2*var_x)+pow(y-y_0,2)/(2*var_y)));
            cv::Vec3b & color = image.at<cv::Vec3b>(cv::Point(x,y));
            unsigned char & colorG = gray_image.at<unsigned char>(cv::Point(x,y));
            colorG=color[2]=color[1]=color[0]=(unsigned char) val;
            gray_array[y*width+x]=val;
        }
}
void ImagePR::SetPixel(int x, int y){
    cv::Vec3b & color = image.at<cv::Vec3b>(cv::Point(x,y));
    unsigned char & colorG = gray_image.at<unsigned char>(cv::Point(x,y));
    colorG=color[2]=color[1]=color[0]=255;
    gray_array[y*width+x]=255;
}

void ImagePR::show(const char *title){
    cv::namedWindow(title, cv::WINDOW_AUTOSIZE );
    cv::Mat im_color;
    cv::applyColorMap(gray_image,im_color,color_display);
    char buffer[100]="../Images/";    strcat(buffer,title);   strcat(buffer,".png");  space2underscore(buffer,100);
    printf("%s writing path is: %s\n",title,buffer);
    cv::imwrite(buffer,im_color);
    cv::imshow(title, im_color);
}