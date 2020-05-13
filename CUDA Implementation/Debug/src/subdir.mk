################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../src/algorithm.cu 

CPP_SRCS += \
../src/main.cpp 

OBJS += \
./src/algorithm.o \
./src/main.o 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/opt/cuda/bin/nvcc -I/usr/local/include/opencv4 -I/opt/cuda/include --device-debug --debug -gencode arch=compute_30,code=sm_30 -gencode arch=compute_30,code=compute_30 -ccbin g++ -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/algorithm.o: /usr/include/stdc-predef.h /opt/cuda/include/cuda_runtime.h /opt/cuda/include/crt/host_config.h /usr/include/features.h /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h /usr/include/bits/long-double.h /usr/include/gnu/stubs.h /usr/include/gnu/stubs-64.h /opt/cuda/include/builtin_types.h /opt/cuda/include/device_types.h /opt/cuda/include/crt/host_defines.h /opt/cuda/include/driver_types.h /opt/cuda/include/vector_types.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include-fixed/limits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include-fixed/syslimits.h /usr/include/limits.h /usr/include/bits/libc-header-start.h /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h /usr/include/bits/xopen_lim.h /usr/include/bits/uio_lim.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stddef.h /opt/cuda/include/surface_types.h /opt/cuda/include/texture_types.h /opt/cuda/include/library_types.h /opt/cuda/include/channel_descriptor.h /opt/cuda/include/cuda_runtime_api.h /opt/cuda/include/cuda_device_runtime_api.h /opt/cuda/include/driver_functions.h /opt/cuda/include/vector_functions.h /opt/cuda/include/vector_functions.hpp /opt/cuda/include/crt/common_functions.h /usr/include/string.h /usr/include/bits/types/locale_t.h /usr/include/bits/types/__locale_t.h /usr/include/strings.h /usr/include/time.h /usr/include/bits/time.h /usr/include/bits/types.h /usr/include/bits/timesize.h /usr/include/bits/typesizes.h /usr/include/bits/time64.h /usr/include/bits/timex.h /usr/include/bits/types/struct_timeval.h /usr/include/bits/types/clock_t.h /usr/include/bits/types/time_t.h /usr/include/bits/types/struct_tm.h /usr/include/bits/types/struct_timespec.h /usr/include/bits/endian.h /usr/include/bits/endianness.h /usr/include/bits/types/clockid_t.h /usr/include/bits/types/timer_t.h /usr/include/bits/types/struct_itimerspec.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/new /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/c++config.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/os_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/cpu_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/exception /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception_ptr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/cxxabi_init_exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/typeinfo /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/hash_bytes.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/nested_exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/move.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/concept_check.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/type_traits /usr/include/stdio.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stdarg.h /usr/include/bits/types/__fpos_t.h /usr/include/bits/types/__mbstate_t.h /usr/include/bits/types/__fpos64_t.h /usr/include/bits/types/__FILE.h /usr/include/bits/types/FILE.h /usr/include/bits/types/struct_FILE.h /usr/include/bits/types/cookie_io_functions_t.h /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/stdlib.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstdlib /usr/include/stdlib.h /usr/include/bits/waitflags.h /usr/include/bits/waitstatus.h /usr/include/bits/floatn.h /usr/include/bits/floatn-common.h /usr/include/sys/types.h /usr/include/bits/stdint-intn.h /usr/include/endian.h /usr/include/bits/byteswap.h /usr/include/bits/uintn-identity.h /usr/include/sys/select.h /usr/include/bits/select.h /usr/include/bits/types/sigset_t.h /usr/include/bits/types/__sigset_t.h /usr/include/bits/pthreadtypes.h /usr/include/bits/thread-shared-types.h /usr/include/bits/pthreadtypes-arch.h /usr/include/bits/struct_mutex.h /usr/include/bits/struct_rwlock.h /usr/include/alloca.h /usr/include/bits/stdlib-float.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/std_abs.h /usr/include/assert.h /opt/cuda/include/crt/math_functions.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/math.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cmath /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/cpp_type_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/type_traits.h /usr/include/math.h /usr/include/bits/math-vector.h /usr/include/bits/libm-simd-decl-stubs.h /usr/include/bits/flt-eval-method.h /usr/include/bits/fp-logb.h /usr/include/bits/fp-fast.h /usr/include/bits/mathcalls-helper-functions.h /usr/include/bits/mathcalls.h /usr/include/bits/mathcalls-narrow.h /usr/include/bits/iscanonical.h /opt/cuda/include/crt/math_functions.hpp /opt/cuda/include/cuda_surface_types.h /opt/cuda/include/cuda_texture_types.h /opt/cuda/include/crt/device_functions.h /opt/cuda/include/crt/device_functions.hpp /opt/cuda/include/device_atomic_functions.h /opt/cuda/include/device_atomic_functions.hpp /opt/cuda/include/crt/device_double_functions.h /opt/cuda/include/crt/device_double_functions.hpp /opt/cuda/include/sm_20_atomic_functions.h /opt/cuda/include/sm_20_atomic_functions.hpp /opt/cuda/include/sm_32_atomic_functions.h /opt/cuda/include/sm_32_atomic_functions.hpp /opt/cuda/include/sm_35_atomic_functions.h /opt/cuda/include/sm_60_atomic_functions.h /opt/cuda/include/sm_60_atomic_functions.hpp /opt/cuda/include/sm_20_intrinsics.h /opt/cuda/include/sm_20_intrinsics.hpp /opt/cuda/include/sm_30_intrinsics.h /opt/cuda/include/sm_30_intrinsics.hpp /opt/cuda/include/sm_32_intrinsics.h /opt/cuda/include/sm_32_intrinsics.hpp /opt/cuda/include/sm_35_intrinsics.h /opt/cuda/include/sm_61_intrinsics.h /opt/cuda/include/sm_61_intrinsics.hpp /opt/cuda/include/crt/sm_70_rt.h /opt/cuda/include/crt/sm_70_rt.hpp /opt/cuda/include/surface_functions.h /opt/cuda/include/texture_fetch_functions.h /opt/cuda/include/texture_indirect_functions.h /opt/cuda/include/surface_indirect_functions.h /opt/cuda/include/device_launch_parameters.h /home/cristi/Documents/Scripts/eclipse-workspace/PhaseRetrieval/src/algorithm.h /opt/cuda/include/cuda.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stdint.h /usr/include/stdint.h /usr/include/bits/wchar.h /usr/include/bits/stdint-uintn.h /opt/cuda/include/cufft.h /opt/cuda/include/cuComplex.h

src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/opt/cuda/bin/nvcc -I/usr/local/include/opencv4 -I/opt/cuda/include --device-debug --debug -gencode arch=compute_30,code=sm_30 -gencode arch=compute_30,code=compute_30 -ccbin g++ -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/main.o: /usr/include/stdc-predef.h /usr/include/stdio.h /usr/include/bits/libc-header-start.h /usr/include/features.h /usr/include/sys/cdefs.h /usr/include/bits/wordsize.h /usr/include/bits/long-double.h /usr/include/gnu/stubs.h /usr/include/gnu/stubs-64.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stddef.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stdarg.h /usr/include/bits/types.h /usr/include/bits/timesize.h /usr/include/bits/typesizes.h /usr/include/bits/time64.h /usr/include/bits/types/__fpos_t.h /usr/include/bits/types/__mbstate_t.h /usr/include/bits/types/__fpos64_t.h /usr/include/bits/types/__FILE.h /usr/include/bits/types/FILE.h /usr/include/bits/types/struct_FILE.h /usr/include/bits/types/cookie_io_functions_t.h /usr/include/bits/stdio_lim.h /usr/include/bits/sys_errlist.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/stdlib.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstdlib /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/c++config.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/os_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/cpu_defines.h /usr/include/stdlib.h /usr/include/bits/waitflags.h /usr/include/bits/waitstatus.h /usr/include/bits/floatn.h /usr/include/bits/floatn-common.h /usr/include/bits/types/locale_t.h /usr/include/bits/types/__locale_t.h /usr/include/sys/types.h /usr/include/bits/types/clock_t.h /usr/include/bits/types/clockid_t.h /usr/include/bits/types/time_t.h /usr/include/bits/types/timer_t.h /usr/include/bits/stdint-intn.h /usr/include/endian.h /usr/include/bits/endian.h /usr/include/bits/endianness.h /usr/include/bits/byteswap.h /usr/include/bits/uintn-identity.h /usr/include/sys/select.h /usr/include/bits/select.h /usr/include/bits/types/sigset_t.h /usr/include/bits/types/__sigset_t.h /usr/include/bits/types/struct_timeval.h /usr/include/bits/types/struct_timespec.h /usr/include/bits/pthreadtypes.h /usr/include/bits/thread-shared-types.h /usr/include/bits/pthreadtypes-arch.h /usr/include/bits/struct_mutex.h /usr/include/bits/struct_rwlock.h /usr/include/alloca.h /usr/include/bits/stdlib-float.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/std_abs.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/math.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cmath /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/cpp_type_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/type_traits.h /usr/include/math.h /usr/include/bits/math-vector.h /usr/include/bits/libm-simd-decl-stubs.h /usr/include/bits/flt-eval-method.h /usr/include/bits/fp-logb.h /usr/include/bits/fp-fast.h /usr/include/bits/mathcalls-helper-functions.h /usr/include/bits/mathcalls.h /usr/include/bits/mathcalls-narrow.h /usr/include/bits/iscanonical.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/chrono /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ratio /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/type_traits /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstdint /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/stdint.h /usr/include/stdint.h /usr/include/bits/wchar.h /usr/include/bits/stdint-uintn.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/limits /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ctime /usr/include/time.h /usr/include/bits/time.h /usr/include/bits/timex.h /usr/include/bits/types/struct_tm.h /usr/include/bits/types/struct_itimerspec.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/parse_numbers.h /usr/local/include/opencv4/opencv2/opencv.hpp /usr/local/include/opencv4/opencv2/opencv_modules.hpp /usr/local/include/opencv4/opencv2/core.hpp /usr/local/include/opencv4/opencv2/core/cvdef.h /usr/local/include/opencv4/opencv2/core/hal/interface.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstddef /usr/local/include/opencv4/opencv2/core/cv_cpu_dispatch.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/emmintrin.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/xmmintrin.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/mmintrin.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/mm_malloc.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/array /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/utility /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_relops.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_pair.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/move.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/concept_check.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/initializer_list /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/stdexcept /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/exception /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception_ptr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/exception_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/cxxabi_init_exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/typeinfo /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/hash_bytes.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/new /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/nested_exception.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/string /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stringfwd.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/memoryfwd.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/char_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_algobase.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/functexcept.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/numeric_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_iterator_base_types.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_iterator_base_funcs.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/debug/assertions.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_iterator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/ptr_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/debug/debug.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/predefined_ops.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/postypes.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cwchar /usr/include/wchar.h /usr/include/bits/types/wint_t.h /usr/include/bits/types/mbstate_t.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/allocator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/c++allocator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/new_allocator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/localefwd.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/c++locale.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/clocale /usr/include/locale.h /usr/include/bits/locale.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/iosfwd /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cctype /usr/include/ctype.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/ostream_insert.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/cxxabi_forced.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_function.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/backward/binders.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/range_access.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/basic_string.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/atomicity.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/gthr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/gthr-default.h /usr/include/pthread.h /usr/include/sched.h /usr/include/bits/sched.h /usr/include/bits/types/struct_sched_param.h /usr/include/bits/cpu-set.h /usr/include/bits/setjmp.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/atomic_word.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/alloc_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/alloc_traits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/string_conversions.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstdio /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cerrno /usr/include/errno.h /usr/include/bits/errno.h /usr/include/linux/errno.h /usr/include/asm/errno.h /usr/include/asm-generic/errno.h /usr/include/asm-generic/errno-base.h /usr/include/bits/types/error_t.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/functional_hash.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/basic_string.tcc /usr/local/include/opencv4/opencv2/core/version.hpp /usr/local/include/opencv4/opencv2/core/base.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/climits /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include-fixed/limits.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include-fixed/syslimits.h /usr/include/limits.h /usr/include/bits/posix1_lim.h /usr/include/bits/local_lim.h /usr/include/linux/limits.h /usr/include/bits/posix2_lim.h /usr/include/bits/xopen_lim.h /usr/include/bits/uio_lim.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/algorithm /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_algo.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/algorithmfwd.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_heap.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_tempbuf.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_construct.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/uniform_int_dist.h /usr/local/include/opencv4/opencv2/core/cvstd.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cstring /usr/include/string.h /usr/include/strings.h /usr/local/include/opencv4/opencv2/core/cvstd_wrapper.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/memory /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_uninitialized.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_raw_storage_iter.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/concurrence.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/uses_allocator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/unique_ptr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/tuple /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/invoke.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/shared_ptr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/shared_ptr_base.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/allocated_ptr.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/refwrap.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ext/aligned_buffer.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/shared_ptr_atomic.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/atomic_base.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/atomic_lockfree_defines.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/backward/auto_ptr.h /usr/local/include/opencv4/opencv2/core/neon_utils.hpp /usr/local/include/opencv4/opencv2/core/vsx_utils.hpp /usr/include/assert.h /usr/local/include/opencv4/opencv2/core/check.hpp /usr/local/include/opencv4/opencv2/core/traits.hpp /usr/local/include/opencv4/opencv2/core/matx.hpp /usr/local/include/opencv4/opencv2/core/saturate.hpp /usr/local/include/opencv4/opencv2/core/fast_math.hpp /usr/local/include/opencv4/opencv2/core/types.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cfloat /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/float.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/vector /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_vector.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_bvector.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/vector.tcc /usr/local/include/opencv4/opencv2/core/mat.hpp /usr/local/include/opencv4/opencv2/core/bufferpool.hpp /usr/local/include/opencv4/opencv2/core/mat.inl.hpp /usr/local/include/opencv4/opencv2/core/persistence.hpp /usr/local/include/opencv4/opencv2/core/operations.hpp /usr/local/include/opencv4/opencv2/core/cvstd.inl.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/complex /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/sstream /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/istream /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ios /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/ios_base.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_classes.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_classes.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/system_error /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/error_constants.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/streambuf /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/streambuf.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/basic_ios.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_facets.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cwctype /usr/include/wctype.h /usr/include/bits/wctype-wchar.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/ctype_base.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/streambuf_iterator.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/ctype_inline.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_facets.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/basic_ios.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/ostream /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/ostream.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/istream.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/sstream.tcc /usr/local/include/opencv4/opencv2/core/utility.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/functional /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/std_function.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/mutex /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/std_mutex.h /usr/local/include/opencv4/opencv2/core/optim.hpp /usr/local/include/opencv4/opencv2/core/ovx.hpp /usr/local/include/opencv4/opencv2/calib3d.hpp /usr/local/include/opencv4/opencv2/features2d.hpp /usr/local/include/opencv4/opencv2/flann/miniflann.hpp /usr/local/include/opencv4/opencv2/flann/defines.h /usr/local/include/opencv4/opencv2/flann/config.h /usr/local/include/opencv4/opencv2/core/affine.hpp /usr/local/include/opencv4/opencv2/dnn.hpp /usr/local/include/opencv4/opencv2/dnn/dnn.hpp /usr/local/include/opencv4/opencv2/core/async.hpp /usr/local/include/opencv4/opencv2/dnn/version.hpp /usr/local/include/opencv4/opencv2/dnn/dict.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/map /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_tree.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_map.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_multimap.h /usr/local/include/opencv4/opencv2/dnn/layer.hpp /usr/local/include/opencv4/opencv2/dnn/dnn.inl.hpp /usr/local/include/opencv4/opencv2/dnn/utils/inference_engine.hpp /usr/local/include/opencv4/opencv2/dnn/dnn.hpp /usr/local/include/opencv4/opencv2/flann.hpp /usr/local/include/opencv4/opencv2/flann/flann_base.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/cassert /usr/local/include/opencv4/opencv2/flann/general.h /usr/local/include/opencv4/opencv2/flann/matrix.h /usr/local/include/opencv4/opencv2/flann/params.h /usr/local/include/opencv4/opencv2/flann/any.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/iostream /usr/local/include/opencv4/opencv2/flann/saving.h /usr/local/include/opencv4/opencv2/flann/nn_index.h /usr/local/include/opencv4/opencv2/flann/result_set.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/set /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_set.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_multiset.h /usr/local/include/opencv4/opencv2/flann/all_indices.h /usr/local/include/opencv4/opencv2/flann/kdtree_index.h /usr/local/include/opencv4/opencv2/flann/dynamic_bitset.h /usr/local/include/opencv4/opencv2/flann/dist.h /usr/local/include/opencv4/opencv2/flann/heap.h /usr/local/include/opencv4/opencv2/flann/allocator.h /usr/local/include/opencv4/opencv2/flann/random.h /usr/local/include/opencv4/opencv2/flann/kdtree_single_index.h /usr/local/include/opencv4/opencv2/flann/kmeans_index.h /usr/local/include/opencv4/opencv2/flann/logger.h /usr/local/include/opencv4/opencv2/flann/composite_index.h /usr/local/include/opencv4/opencv2/flann/linear_index.h /usr/local/include/opencv4/opencv2/flann/hierarchical_clustering_index.h /usr/local/include/opencv4/opencv2/flann/lsh_index.h /usr/local/include/opencv4/opencv2/flann/lsh_table.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/iomanip /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/locale /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_facets_nonio.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/time_members.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/x86_64-pc-linux-gnu/bits/messages_members.h /usr/include/libintl.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/codecvt.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_facets_nonio.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/locale_conv.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/quoted_string.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/unordered_map /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/hashtable.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/hashtable_policy.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/unordered_map.h /usr/local/include/opencv4/opencv2/flann/autotuned_index.h /usr/local/include/opencv4/opencv2/flann/ground_truth.h /usr/local/include/opencv4/opencv2/flann/index_testing.h /usr/local/include/opencv4/opencv2/flann/timer.h /usr/local/include/opencv4/opencv2/flann/sampling.h /usr/local/include/opencv4/opencv2/highgui.hpp /usr/local/include/opencv4/opencv2/imgcodecs.hpp /usr/local/include/opencv4/opencv2/videoio.hpp /usr/local/include/opencv4/opencv2/imgproc.hpp /usr/local/include/opencv4/opencv2/ml.hpp /usr/local/include/opencv4/opencv2/ml/ml.inl.hpp /usr/local/include/opencv4/opencv2/objdetect.hpp /usr/local/include/opencv4/opencv2/objdetect/detection_based_tracker.hpp /usr/local/include/opencv4/opencv2/photo.hpp /usr/local/include/opencv4/opencv2/stitching.hpp /usr/local/include/opencv4/opencv2/stitching/warpers.hpp /usr/local/include/opencv4/opencv2/stitching/detail/warpers.hpp /usr/local/include/opencv4/opencv2/core/cuda.hpp /usr/local/include/opencv4/opencv2/core/cuda_types.hpp /usr/local/include/opencv4/opencv2/core/cuda.inl.hpp /usr/local/include/opencv4/opencv2/stitching/detail/warpers_inl.hpp /usr/local/include/opencv4/opencv2/stitching/detail/matchers.hpp /usr/local/include/opencv4/opencv2/stitching/detail/motion_estimators.hpp /usr/local/include/opencv4/opencv2/stitching/detail/util.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/list /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_list.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/list.tcc /usr/local/include/opencv4/opencv2/stitching/detail/util_inl.hpp /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/queue /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/deque /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_deque.h /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/deque.tcc /usr/lib/gcc/x86_64-pc-linux-gnu/8.4.0/include/c++/bits/stl_queue.h /usr/local/include/opencv4/opencv2/stitching/detail/camera.hpp /usr/local/include/opencv4/opencv2/stitching/detail/exposure_compensate.hpp /usr/local/include/opencv4/opencv2/stitching/detail/seam_finders.hpp /usr/local/include/opencv4/opencv2/stitching/detail/blenders.hpp /usr/local/include/opencv4/opencv2/video.hpp /usr/local/include/opencv4/opencv2/video/tracking.hpp /usr/local/include/opencv4/opencv2/video/background_segm.hpp /home/cristi/Documents/Scripts/eclipse-workspace/PhaseRetrieval/src/algorithm.h /opt/cuda/include/cuda.h /opt/cuda/include/cuda_runtime.h /opt/cuda/include/crt/host_config.h /opt/cuda/include/builtin_types.h /opt/cuda/include/device_types.h /opt/cuda/include/crt/host_defines.h /opt/cuda/include/driver_types.h /opt/cuda/include/vector_types.h /opt/cuda/include/surface_types.h /opt/cuda/include/texture_types.h /opt/cuda/include/library_types.h /opt/cuda/include/channel_descriptor.h /opt/cuda/include/cuda_runtime_api.h /opt/cuda/include/cuda_device_runtime_api.h /opt/cuda/include/driver_functions.h /opt/cuda/include/vector_functions.h /opt/cuda/include/vector_functions.hpp /opt/cuda/include/cufft.h /opt/cuda/include/cuComplex.h

