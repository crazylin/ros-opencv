# Compile OpenCV against ROS
FROM ros:galactic

# URL
ARG OPENCV_TAR_GZ=https://github.com/opencv/opencv/archive/refs/tags/4.5.2.tar.gz

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Build opencv
RUN wget -O opencv.tar.gz ${OPENCV_TAR_GZ} \
  && mkdir opencv-src opencv-bld \
  && tar -xzf opencv.tar.gz --strip-components=1 --directory=opencv-src \
  && cmake \
    -D CMAKE_BUILD_TYPE:STRING=Release \
    -D CMAKE_INSTALL_PREFIX:STRING=/opt/OpenCV \
    -D BUILD_LIST:STRING=core,imgproc,calib3d \
    -D BUILD_TESTS:BOOL=OFF \
    -D BUILD_PERF_TESTS:BOOL=OFF \
    -D BUILD_EXAMPLES:BOOL=OFF \
    -D BUILD_opencv_apps=OFF \
    -D WITH_1394:BOOL=OFF \
    -D WITH_ADE:BOOL=OFF \
    -D WITH_ARAVIS:BOOL=OFF \
    -D WITH_CLP:BOOL=OFF \
    -D WITH_CUDA:BOOL=OFF \
    -D WITH_EIGEN:BOOL=OFF \
    -D WITH_FFMPEG:BOOL=OFF \
    -D WITH_FREETYPE:BOOL=OFF \
    -D WITH_GDAL:BOOL=OFF \
    -D WITH_GDCM:BOOL=OFF \
    -D WITH_GPHOTO2:BOOL=OFF \
    -D WITH_GSTREAMER:BOOL=OFF \
    -D WITH_GTK:BOOL=OFF \
    -D WITH_GTK_2_X:BOOL=OFF \
    -D WITH_HALIDE:BOOL=OFF \
    -D WITH_HPX:BOOL=OFF \
    -D WITH_IMGCODEC_HDR:BOOL=OFF \
    -D WITH_IMGCODEC_PFM:BOOL=OFF \
    -D WITH_IMGCODEC_PXM:BOOL=OFF \
    -D WITH_IMGCODEC_SUNRASTER:BOOL=OFF \
    -D WITH_INF_ENGINE:BOOL=OFF \
    -D WITH_IPP:BOOL=OFF \
    -D WITH_ITT:BOOL=OFF \
    -D WITH_JASPER:BOOL=OFF \
    -D WITH_JPEG:BOOL=OFF \
    -D WITH_LAPACK:BOOL=OFF \
    -D WITH_LIBREALSENSE:BOOL=OFF \
    -D WITH_MFX:BOOL=OFF \
    -D WITH_NGRAPH:BOOL=OFF \
    -D WITH_ONNX:BOOL=OFF \
    -D WITH_OPENCL:BOOL=OFF \
    -D WITH_OPENCLAMDBLAS:BOOL=OFF \
    -D WITH_OPENCLAMDFFT:BOOL=OFF \
    -D WITH_OPENCL_SVM:BOOL=OFF \
    -D WITH_OPENEXR:BOOL=OFF \
    -D WITH_OPENGL:BOOL=OFF \
    -D WITH_OPENJPEG:BOOL=OFF \
    -D WITH_OPENMP:BOOL=OFF \
    -D WITH_OPENNI:BOOL=OFF \
    -D WITH_OPENNI2:BOOL=OFF \
    -D WITH_OPENVX:BOOL=OFF \
    -D WITH_PLAIDML:BOOL=OFF \
    -D WITH_PNG:BOOL=OFF \
    -D WITH_PROTOBUF:BOOL=OFF \
    -D WITH_PTHREADS_PF:BOOL=OFF \
    -D WITH_PVAPI:BOOL=OFF \
    -D WITH_QT:BOOL=OFF \
    -D WITH_QUIRC:BOOL=OFF \
    -D WITH_TBB:BOOL=OFF \
    -D WITH_TIFF:BOOL=OFF \
    -D WITH_UEYE:BOOL=OFF \
    -D WITH_V4L:BOOL=OFF \
    -D WITH_VA:BOOL=OFF \
    -D WITH_VA_INTEL:BOOL=OFF \
    -D WITH_VTK:BOOL=OFF \
    -D WITH_VULKAN:BOOL=OFF \
    -D WITH_WEBP:BOOL=OFF \
    -D WITH_XIMEA:BOOL=OFF \
    -D WITH_XINE:BOOL=OFF \
    -S opencv-src/ \
    -B opencv-bld/ \
  && cmake --build opencv-bld/ --target install \
  && rm -r opencv.tar.gz opencv-src opencv-bld

# Update ldconfig
RUN echo "/opt/OpenCV/lib" >> /etc/ld.so.conf.d/OpenCV.conf \
  && ldconfig
