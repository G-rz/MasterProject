# MasterProject
Installation
CUDA toolkit
To install CUDA toolkit please use this link.

Compile and execute
Execute "nvcc -O3 --shared -Xcompiler -fPIC -o Skeleton.so cuPC-S.cu" to compile .cu files
A test example exists in use_cuPC.R
Data_generator.R create gaussian-distributed data
cuPC-S.cu is optimized version
cuPC-S-old.cu is original version
Skeleton.so is generated based on the optimized version, not sure if it can be used directly on other devices. If there is a problem running, you can try to delete this file and regenerate.
Skeleton.so is generated based on the original version
