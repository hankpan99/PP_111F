__kernel void convolution(int filterWidth, __constant float *filter, int imageHeight, int imageWidth,
                          __global float *inputImage, __global float *outputImage)
{
    int halffilterSize = filterWidth / 2;
    float sum = 0;

    // get thread index within index space
    const int ix = get_global_id(0), iy = get_global_id(1);

    for(int k = -halffilterSize; k <= halffilterSize; k++){
        for(int l = -halffilterSize; l <= halffilterSize; l++){
            if((iy + k >= 0) && (iy + k < imageHeight) && (ix + l >= 0) && (ix + l < imageWidth)){
                sum += (inputImage[(iy + k) * imageWidth + ix + l] * filter[(k + halffilterSize) * filterWidth + l + halffilterSize]);
            }
        }
    }

    outputImage[iy * imageWidth + ix] = sum;
}