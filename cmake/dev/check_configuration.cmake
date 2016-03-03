macro(check_stdcxx)
    # Check C++11
    include(CheckCXXCompilerFlag)
    if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_CLANG OR
        CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        check_cxx_compiler_flag(--std=c++11 SUPPORTS_CXX11)
        if(SUPPORTS_CXX11)
            add_compile_options(--std=c++11)
            set(HAVE_CXX11 1)
            set(HAVE_CXX0X 1)
        else()
            set(HAVE_CXX11 0)
            check_cxx_compiler_flag(--std=c++0x SUPPORTS_CXX0X)
            if(SUPPORTS_CXX0X)
                add_compile_options(--std=c++0x)
                set(HAVE_CXX0X 1)
            else()
                set(HAVE_CXX0X 0)
            endif()
        endif()
    elseif(MSVC OR MSVC_IDE)
        set(HAVE_CXX11 1)
        set(HAVE_CXX0X 1)
    else()
        set(HAVE_CXX11 0)
        set(HAVE_CXX0X 0)
    endif()
endmacro()

macro(check_compile_feature)
    # Check constexpr
    list(FIND CMAKE_CXX_COMPILE_FEATURES "cxx_constexpr" CXX_CONSTEXPR_SUPPORTED)
    if(${CXX_CONSTEXPR_SUPPORTED} GREATER -1)
        set(HAVE_CXX_CONSTEXPR 1)
    else()
        set(HAVE_CXX_CONSTEXPR 0)
    endif()
endmacro()

macro(check_endianness)
    # Test endianness
    include(TestBigEndian)
    test_big_endian(BIG_ENDIAN)
    set(__BIG_ENDIAN__ ${BIG_ENDIAN})
endmacro()

macro(check_msvc_arch)
    if(MSVC10)
        if(CMAKE_CL_64)
            set(MSVC_ARCH "x64Win64VS2010")
        else()
            set(MSVC_ARCH "i86Win32VS2010")
        endif()
    elseif(MSVC11)
        if(CMAKE_CL_64)
            set(MSVC_ARCH "x64Win64VS2012")
        else()
            set(MSVC_ARCH "i86Win32VS2012")
        endif()
    elseif(MSVC12)
        if(CMAKE_CL_64)
            set(MSVC_ARCH "x64Win64VS2013")
        else()
            set(MSVC_ARCH "i86Win32VS2013")
        endif()
    elseif(MSVC14)
        if(CMAKE_CL_64)
            set(MSVC_ARCH "x64Win64VS2015")
        else()
            set(MSVC_ARCH "i86Win32VS2015")
        endif()
    endif()
endmacro()
