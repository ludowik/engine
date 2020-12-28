#define ALAPI AL_API
#define ALAPIENTRY AL_APIENTRY
#define ALCAPI ALC_API
#define ALCAPIENTRY ALC_APIENTRY
#define ALC_ALL_ATTRIBUTES 0x1003
#define ALC_ALL_DEVICES_SPECIFIER 0x1013
#define ALC_API extern
#define ALC_APIENTRY 
#define ALC_ATTRIBUTES_SIZE 0x1002
#define ALC_CAPTURE_DEFAULT_DEVICE_SPECIFIER 0x311
#define ALC_CAPTURE_DEVICE_SPECIFIER 0x310
#define ALC_CAPTURE_SAMPLES 0x312
#define ALC_DEFAULT_ALL_DEVICES_SPECIFIER 0x1012
#define ALC_DEFAULT_DEVICE_SPECIFIER 0x1004
#define ALC_DEVICE_SPECIFIER 0x1005
#define ALC_EXTENSIONS 0x1006
#define ALC_FALSE 0
#define ALC_FREQUENCY 0x1007
#define ALC_INVALID 0
#define ALC_INVALID_CONTEXT 0xA002
#define ALC_INVALID_DEVICE 0xA001
#define ALC_INVALID_ENUM 0xA003
#define ALC_INVALID_VALUE 0xA004
#define ALC_MAJOR_VERSION 0x1000
#define ALC_MINOR_VERSION 0x1001
#define ALC_MONO_SOURCES 0x1010
#define ALC_NO_ERROR ALC_FALSE
#define ALC_OUT_OF_MEMORY 0xA005
#define ALC_REFRESH 0x1008
#define ALC_STEREO_SOURCES 0x1011
#define ALC_SYNC 0x1009
#define ALC_TRUE 1
#define ALC_VERSION_0_1 1
#define AL_ALC_H 
#define AL_AL_H 
#define AL_API extern
#define AL_APIENTRY 
#define AL_BITS 0x2002
#define AL_BUFFER 0x1009
#define AL_BUFFERS_PROCESSED 0x1016
#define AL_BUFFERS_QUEUED 0x1015
#define AL_BYTE_OFFSET 0x1026
#define AL_CHANNELS 0x2003
#define AL_CONE_INNER_ANGLE 0x1001
#define AL_CONE_OUTER_ANGLE 0x1002
#define AL_CONE_OUTER_GAIN 0x1022
#define AL_DIRECTION 0x1005
#define AL_DISTANCE_MODEL 0xD000
#define AL_DOPPLER_FACTOR 0xC000
#define AL_DOPPLER_VELOCITY 0xC001
#define AL_EXPONENT_DISTANCE 0xD005
#define AL_EXPONENT_DISTANCE_CLAMPED 0xD006
#define AL_EXTENSIONS 0xB004
#define AL_FALSE 0
#define AL_FORMAT_MONO16 0x1101
#define AL_FORMAT_MONO8 0x1100
#define AL_FORMAT_STEREO16 0x1103
#define AL_FORMAT_STEREO8 0x1102
#define AL_FREQUENCY 0x2001
#define AL_GAIN 0x100A
#define AL_ILLEGAL_COMMAND AL_INVALID_OPERATION
#define AL_ILLEGAL_ENUM AL_INVALID_ENUM
#define AL_INITIAL 0x1011
#define AL_INVALID (-1)
#define AL_INVALID_ENUM 0xA002
#define AL_INVALID_NAME 0xA001
#define AL_INVALID_OPERATION 0xA004
#define AL_INVALID_VALUE 0xA003
#define AL_INVERSE_DISTANCE 0xD001
#define AL_INVERSE_DISTANCE_CLAMPED 0xD002
#define AL_LINEAR_DISTANCE 0xD003
#define AL_LINEAR_DISTANCE_CLAMPED 0xD004
#define AL_LOOPING 0x1007
#define AL_MAX_DISTANCE 0x1023
#define AL_MAX_GAIN 0x100E
#define AL_MIN_GAIN 0x100D
#define AL_NONE 0
#define AL_NO_ERROR AL_FALSE
#define AL_ORIENTATION 0x100F
#define AL_OUT_OF_MEMORY 0xA005
#define AL_PAUSED 0x1013
#define AL_PENDING 0x2011
#define AL_PITCH 0x1003
#define AL_PLAYING 0x1012
#define AL_POSITION 0x1004
#define AL_PROCESSED 0x2012
#define AL_REFERENCE_DISTANCE 0x1020
#define AL_RENDERER 0xB003
#define AL_ROLLOFF_FACTOR 0x1021
#define AL_SAMPLE_OFFSET 0x1025
#define AL_SEC_OFFSET 0x1024
#define AL_SIZE 0x2004
#define AL_SOURCE_RELATIVE 0x202
#define AL_SOURCE_STATE 0x1010
#define AL_SOURCE_TYPE 0x1027
#define AL_SPEED_OF_SOUND 0xC003
#define AL_STATIC 0x1028
#define AL_STOPPED 0x1014
#define AL_STREAMING 0x1029
#define AL_TRUE 1
#define AL_UNDETERMINED 0x1030
#define AL_UNUSED 0x2010
#define AL_VELOCITY 0x1006
#define AL_VENDOR 0xB001
#define AL_VERSION 0xB002
#define AL_VERSION_1_0 
#define AL_VERSION_1_1 
#define API_AVAILABLE(...) __API_AVAILABLE_GET_MACRO(__VA_ARGS__,__API_AVAILABLE7, __API_AVAILABLE6, __API_AVAILABLE5, __API_AVAILABLE4, __API_AVAILABLE3, __API_AVAILABLE2, __API_AVAILABLE1, 0)(__VA_ARGS__)
#define API_AVAILABLE_BEGIN(...) _Pragma("clang attribute push") __API_AVAILABLE_BEGIN_GET_MACRO(__VA_ARGS__,__API_AVAILABLE_BEGIN7,__API_AVAILABLE_BEGIN6, __API_AVAILABLE_BEGIN5, __API_AVAILABLE_BEGIN4, __API_AVAILABLE_BEGIN3, __API_AVAILABLE_BEGIN2, __API_AVAILABLE_BEGIN1, 0)(__VA_ARGS__)
#define API_AVAILABLE_END _Pragma("clang attribute pop")
#define API_DEPRECATED(...) __API_DEPRECATED_MSG_GET_MACRO(__VA_ARGS__,__API_DEPRECATED_MSG8,__API_DEPRECATED_MSG7, __API_DEPRECATED_MSG6,__API_DEPRECATED_MSG5,__API_DEPRECATED_MSG4,__API_DEPRECATED_MSG3,__API_DEPRECATED_MSG2,__API_DEPRECATED_MSG1, 0)(__VA_ARGS__)
#define API_DEPRECATED_BEGIN(...) _Pragma("clang attribute push") __API_DEPRECATED_BEGIN_MSG_GET_MACRO(__VA_ARGS__,__API_DEPRECATED_BEGIN_MSG8,__API_DEPRECATED_BEGIN_MSG7, __API_DEPRECATED_BEGIN_MSG6, __API_DEPRECATED_BEGIN_MSG5, __API_DEPRECATED_BEGIN_MSG4, __API_DEPRECATED_BEGIN_MSG3, __API_DEPRECATED_BEGIN_MSG2, __API_DEPRECATED_BEGIN_MSG1, 0)(__VA_ARGS__)
#define API_DEPRECATED_END _Pragma("clang attribute pop")
#define API_DEPRECATED_WITH_REPLACEMENT(...) __API_DEPRECATED_REP_GET_MACRO(__VA_ARGS__,__API_DEPRECATED_REP8,__API_DEPRECATED_REP7, __API_DEPRECATED_REP6,__API_DEPRECATED_REP5,__API_DEPRECATED_REP4,__API_DEPRECATED_REP3,__API_DEPRECATED_REP2,__API_DEPRECATED_REP1, 0)(__VA_ARGS__)
#define API_DEPRECATED_WITH_REPLACEMENT_BEGIN(...) _Pragma("clang attribute push") __API_DEPRECATED_BEGIN_REP_GET_MACRO(__VA_ARGS__,__API_DEPRECATED_BEGIN_REP8,__API_DEPRECATED_BEGIN_REP7, __API_DEPRECATED_BEGIN_REP6, __API_DEPRECATED_BEGIN_REP5, __API_DEPRECATED_BEGIN_REP4, __API_DEPRECATED_BEGIN_REP3, __API_DEPRECATED_BEGIN_REP2, __API_DEPRECATED_BEGIN_REP1, 0)(__VA_ARGS__)
#define API_DEPRECATED_WITH_REPLACEMENT_END _Pragma("clang attribute pop")
#define API_TO_BE_DEPRECATED 100000
#define API_UNAVAILABLE(...) __API_UNAVAILABLE_GET_MACRO(__VA_ARGS__,__API_UNAVAILABLE7,__API_UNAVAILABLE6, __API_UNAVAILABLE5, __API_UNAVAILABLE4,__API_UNAVAILABLE3,__API_UNAVAILABLE2,__API_UNAVAILABLE1, 0)(__VA_ARGS__)
#define API_UNAVAILABLE_BEGIN(...) _Pragma("clang attribute push") __API_UNAVAILABLE_BEGIN_GET_MACRO(__VA_ARGS__,__API_UNAVAILABLE_BEGIN7,__API_UNAVAILABLE_BEGIN6, __API_UNAVAILABLE_BEGIN5, __API_UNAVAILABLE_BEGIN4, __API_UNAVAILABLE_BEGIN3, __API_UNAVAILABLE_BEGIN2, __API_UNAVAILABLE_BEGIN1, 0)(__VA_ARGS__)
#define API_UNAVAILABLE_END _Pragma("clang attribute pop")
#define OBJC_NEW_PROPERTIES 1
#define OPENAL 
#define OPENAL_DEPRECATED API_DEPRECATED("OpenAL is deprecated in favor of AVAudioEngine", macos(10.4, 10.15), ios(2.0, 13.0))
#define SPI_AVAILABLE(...) 
#define SPI_DEPRECATED(...) 
#define SPI_DEPRECATED_WITH_REPLACEMENT(...) 
#define _LP64 1
#define __API_A(x) __attribute__((availability(__API_AVAILABLE_PLATFORM_##x)))
#define __API_APPLY_TO any(record, enum, enum_constant, function, objc_method, objc_category, objc_protocol, objc_interface, objc_property, type_alias, variable, field)
#define __API_AVAILABLE1(x) __API_A(x)
#define __API_AVAILABLE2(x,y) __API_A(x) __API_A(y)
#define __API_AVAILABLE3(x,y,z) __API_A(x) __API_A(y) __API_A(z)
#define __API_AVAILABLE4(x,y,z,t) __API_A(x) __API_A(y) __API_A(z) __API_A(t)
#define __API_AVAILABLE5(x,y,z,t,b) __API_A(x) __API_A(y) __API_A(z) __API_A(t) __API_A(b)
#define __API_AVAILABLE6(x,y,z,t,b,m) __API_A(x) __API_A(y) __API_A(z) __API_A(t) __API_A(b) __API_A(m)
#define __API_AVAILABLE7(x,y,z,t,b,m,d) __API_A(x) __API_A(y) __API_A(z) __API_A(t) __API_A(b) __API_A(m) __API_A(d)
#define __API_AVAILABLE_BEGIN1(a) __API_A_BEGIN(a)
#define __API_AVAILABLE_BEGIN2(a,b) __API_A_BEGIN(a) __API_A_BEGIN(b)
#define __API_AVAILABLE_BEGIN3(a,b,c) __API_A_BEGIN(a) __API_A_BEGIN(b) __API_A_BEGIN(c)
#define __API_AVAILABLE_BEGIN4(a,b,c,d) __API_A_BEGIN(a) __API_A_BEGIN(b) __API_A_BEGIN(c) __API_A_BEGIN(d)
#define __API_AVAILABLE_BEGIN5(a,b,c,d,e) __API_A_BEGIN(a) __API_A_BEGIN(b) __API_A_BEGIN(c) __API_A_BEGIN(d) __API_A_BEGIN(e)
#define __API_AVAILABLE_BEGIN6(a,b,c,d,e,f) __API_A_BEGIN(a) __API_A_BEGIN(b) __API_A_BEGIN(c) __API_A_BEGIN(d) __API_A_BEGIN(e) __API_A_BEGIN(f)
#define __API_AVAILABLE_BEGIN7(a,b,c,d,e,f,g) __API_A_BEGIN(a) __API_A_BEGIN(b) __API_A_BEGIN(c) __API_A_BEGIN(d) __API_A_BEGIN(e) __API_A_BEGIN(f) __API_A_BEGIN(g)
#define __API_AVAILABLE_BEGIN_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,NAME,...) NAME
#define __API_AVAILABLE_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,NAME,...) NAME
#define __API_AVAILABLE_PLATFORM_driverkit(x) driverkit,introduced=x
#define __API_AVAILABLE_PLATFORM_ios(x) ios,introduced=x
#define __API_AVAILABLE_PLATFORM_macCatalyst(x) macCatalyst,introduced=x
#define __API_AVAILABLE_PLATFORM_macos(x) macos,introduced=x
#define __API_AVAILABLE_PLATFORM_macosx(x) macosx,introduced=x
#define __API_AVAILABLE_PLATFORM_tvos(x) tvos,introduced=x
#define __API_AVAILABLE_PLATFORM_uikitformac(x) uikitformac,introduced=x
#define __API_AVAILABLE_PLATFORM_watchos(x) watchos,introduced=x
#define __API_A_BEGIN(x) _Pragma(__API_RANGE_STRINGIFY (clang attribute (__attribute__((availability(__API_AVAILABLE_PLATFORM_##x))), apply_to = __API_APPLY_TO)))
#define __API_D(msg,x) __attribute__((availability(__API_DEPRECATED_PLATFORM_##x,message=msg)))
#define __API_DEPRECATED_BEGIN_MSG2(msg,a) __API_D_BEGIN(msg,a)
#define __API_DEPRECATED_BEGIN_MSG3(msg,a,b) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b)
#define __API_DEPRECATED_BEGIN_MSG4(msg,a,b,c) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b) __API_D_BEGIN(msg,c)
#define __API_DEPRECATED_BEGIN_MSG5(msg,a,b,c,d) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b) __API_D_BEGIN(msg,c) __API_D_BEGIN(msg,d)
#define __API_DEPRECATED_BEGIN_MSG6(msg,a,b,c,d,e) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b) __API_D_BEGIN(msg,c) __API_D_BEGIN(msg,d) __API_D_BEGIN(msg,e)
#define __API_DEPRECATED_BEGIN_MSG7(msg,a,b,c,d,e,f) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b) __API_D_BEGIN(msg,c) __API_D_BEGIN(msg,d) __API_D_BEGIN(msg,e) __API_D_BEGIN(msg,f)
#define __API_DEPRECATED_BEGIN_MSG8(msg,a,b,c,d,e,f,g) __API_D_BEGIN(msg,a) __API_D_BEGIN(msg,b) __API_D_BEGIN(msg,c) __API_D_BEGIN(msg,d) __API_D_BEGIN(msg,e) __API_D_BEGIN(msg,f) __API_D_BEGIN(msg,g)
#define __API_DEPRECATED_BEGIN_MSG_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,_8,NAME,...) NAME
#define __API_DEPRECATED_BEGIN_REP2(rep,a) __API_R_BEGIN(rep,a)
#define __API_DEPRECATED_BEGIN_REP3(rep,a,b) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b)
#define __API_DEPRECATED_BEGIN_REP4(rep,a,b,c) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b) __API_R_BEGIN(rep,c)
#define __API_DEPRECATED_BEGIN_REP5(rep,a,b,c,d) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b) __API_R_BEGIN(rep,c) __API_R_BEGIN(rep,d)
#define __API_DEPRECATED_BEGIN_REP6(rep,a,b,c,d,e) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b) __API_R_BEGIN(rep,c) __API_R_BEGIN(rep,d) __API_R_BEGIN(rep,e)
#define __API_DEPRECATED_BEGIN_REP7(rep,a,b,c,d,e,f) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b) __API_R_BEGIN(rep,c) __API_R_BEGIN(rep,d) __API_R_BEGIN(rep,e) __API_R_BEGIN(rep,f)
#define __API_DEPRECATED_BEGIN_REP8(rep,a,b,c,d,e,f,g) __API_R_BEGIN(rep,a) __API_R_BEGIN(rep,b) __API_R_BEGIN(rep,c) __API_R_BEGIN(rep,d) __API_R_BEGIN(rep,e) __API_R_BEGIN(rep,f) __API_R_BEGIN(rep,g)
#define __API_DEPRECATED_BEGIN_REP_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,_8,NAME,...) NAME
#define __API_DEPRECATED_MSG2(msg,x) __API_D(msg,x)
#define __API_DEPRECATED_MSG3(msg,x,y) __API_D(msg,x) __API_D(msg,y)
#define __API_DEPRECATED_MSG4(msg,x,y,z) __API_DEPRECATED_MSG3(msg,x,y) __API_D(msg,z)
#define __API_DEPRECATED_MSG5(msg,x,y,z,t) __API_DEPRECATED_MSG4(msg,x,y,z) __API_D(msg,t)
#define __API_DEPRECATED_MSG6(msg,x,y,z,t,b) __API_DEPRECATED_MSG5(msg,x,y,z,t) __API_D(msg,b)
#define __API_DEPRECATED_MSG7(msg,x,y,z,t,b,m) __API_DEPRECATED_MSG6(msg,x,y,z,t,b) __API_D(msg,m)
#define __API_DEPRECATED_MSG8(msg,x,y,z,t,b,m,d) __API_DEPRECATED_MSG7(msg,x,y,z,t,b,m) __API_D(msg,d)
#define __API_DEPRECATED_MSG_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,_8,NAME,...) NAME
#define __API_DEPRECATED_PLATFORM_driverkit(x,y) driverkit,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_ios(x,y) ios,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_macCatalyst(x,y) macCatalyst,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_macos(x,y) macos,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_macosx(x,y) macosx,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_tvos(x,y) tvos,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_uikitformac(x) uikitformac,introduced=x,deprecated=y
#define __API_DEPRECATED_PLATFORM_watchos(x,y) watchos,introduced=x,deprecated=y
#define __API_DEPRECATED_REP2(rep,x) __API_R(rep,x)
#define __API_DEPRECATED_REP3(rep,x,y) __API_R(rep,x) __API_R(rep,y)
#define __API_DEPRECATED_REP4(rep,x,y,z) __API_DEPRECATED_REP3(rep,x,y) __API_R(rep,z)
#define __API_DEPRECATED_REP5(rep,x,y,z,t) __API_DEPRECATED_REP4(rep,x,y,z) __API_R(rep,t)
#define __API_DEPRECATED_REP6(rep,x,y,z,t,b) __API_DEPRECATED_REP5(rep,x,y,z,t) __API_R(rep,b)
#define __API_DEPRECATED_REP7(rep,x,y,z,t,b,m) __API_DEPRECATED_REP6(rep,x,y,z,t,b) __API_R(rep,m)
#define __API_DEPRECATED_REP8(rep,x,y,z,t,b,m,d) __API_DEPRECATED_REP7(rep,x,y,z,t,b,m) __API_R(rep,d)
#define __API_DEPRECATED_REP_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,_8,NAME,...) NAME
#define __API_D_BEGIN(msg,x) _Pragma(__API_RANGE_STRINGIFY (clang attribute (__attribute__((availability(__API_DEPRECATED_PLATFORM_##x,message=msg))), apply_to = __API_APPLY_TO)))
#define __API_R(rep,x) __attribute__((availability(__API_DEPRECATED_PLATFORM_##x,replacement=rep)))
#define __API_RANGE_STRINGIFY(x) __API_RANGE_STRINGIFY2(x)
#define __API_RANGE_STRINGIFY2(x) #x
#define __API_R_BEGIN(rep,x) _Pragma(__API_RANGE_STRINGIFY (clang attribute (__attribute__((availability(__API_DEPRECATED_PLATFORM_##x,replacement=rep))), apply_to = __API_APPLY_TO)))
#define __API_U(x) __attribute__((availability(__API_UNAVAILABLE_PLATFORM_##x)))
#define __API_UNAVAILABLE1(x) __API_U(x)
#define __API_UNAVAILABLE2(x,y) __API_U(x) __API_U(y)
#define __API_UNAVAILABLE3(x,y,z) __API_UNAVAILABLE2(x,y) __API_U(z)
#define __API_UNAVAILABLE4(x,y,z,t) __API_UNAVAILABLE3(x,y,z) __API_U(t)
#define __API_UNAVAILABLE5(x,y,z,t,b) __API_UNAVAILABLE4(x,y,z,t) __API_U(b)
#define __API_UNAVAILABLE6(x,y,z,t,b,m) __API_UNAVAILABLE5(x,y,z,t,b) __API_U(m)
#define __API_UNAVAILABLE7(x,y,z,t,b,m,d) __API_UNAVAILABLE6(x,y,z,t,b,m) __API_U(d)
#define __API_UNAVAILABLE_BEGIN1(a) __API_U_BEGIN(a)
#define __API_UNAVAILABLE_BEGIN2(a,b) __API_U_BEGIN(a) __API_U_BEGIN(b)
#define __API_UNAVAILABLE_BEGIN3(a,b,c) __API_U_BEGIN(a) __API_U_BEGIN(b) __API_U_BEGIN(c)
#define __API_UNAVAILABLE_BEGIN4(a,b,c,d) __API_U_BEGIN(a) __API_U_BEGIN(b) __API_U_BEGIN(c) __API_U_BEGIN(d)
#define __API_UNAVAILABLE_BEGIN5(a,b,c,d,e) __API_U_BEGIN(a) __API_U_BEGIN(b) __API_U_BEGIN(c) __API_U_BEGIN(d) __API_U_BEGIN(e)
#define __API_UNAVAILABLE_BEGIN6(a,b,c,d,e,f) __API_U_BEGIN(a) __API_U_BEGIN(b) __API_U_BEGIN(c) __API_U_BEGIN(d) __API_U_BEGIN(e) __API_U_BEGIN(f)
#define __API_UNAVAILABLE_BEGIN7(a,b,c,d,e,f) __API_U_BEGIN(a) __API_U_BEGIN(b) __API_U_BEGIN(c) __API_U_BEGIN(d) __API_U_BEGIN(e) __API_U_BEGIN(f) __API_U_BEGIN(g)
#define __API_UNAVAILABLE_BEGIN_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,NAME,...) NAME
#define __API_UNAVAILABLE_GET_MACRO(_1,_2,_3,_4,_5,_6,_7,NAME,...) NAME
#define __API_UNAVAILABLE_PLATFORM_driverkit driverkit,unavailable
#define __API_UNAVAILABLE_PLATFORM_ios ios,unavailable
#define __API_UNAVAILABLE_PLATFORM_macCatalyst macCatalyst,unavailable
#define __API_UNAVAILABLE_PLATFORM_macos macos,unavailable
#define __API_UNAVAILABLE_PLATFORM_macosx macosx,unavailable
#define __API_UNAVAILABLE_PLATFORM_tvos tvos,unavailable
#define __API_UNAVAILABLE_PLATFORM_uikitformac(x) uikitformac,unavailable
#define __API_UNAVAILABLE_PLATFORM_watchos watchos,unavailable
#define __API_U_BEGIN(x) _Pragma(__API_RANGE_STRINGIFY (clang attribute (__attribute__((availability(__API_UNAVAILABLE_PLATFORM_##x))), apply_to = __API_APPLY_TO)))
#define __APPLE_CC__ 6000
#define __APPLE__ 1
#define __ATOMIC_ACQUIRE 2
#define __ATOMIC_ACQ_REL 4
#define __ATOMIC_CONSUME 1
#define __ATOMIC_RELAXED 0
#define __ATOMIC_RELEASE 3
#define __ATOMIC_SEQ_CST 5
#define __AVAILABILITY_INTERNAL_DEPRECATED __attribute__((deprecated))
#define __AVAILABILITY_INTERNAL_DEPRECATED_MSG(_msg) __attribute__((deprecated(_msg)))
#define __AVAILABILITY_INTERNAL_REGULAR 
#define __AVAILABILITY_INTERNAL_UNAVAILABLE __attribute__((unavailable))
#define __AVAILABILITY_INTERNAL_WEAK_IMPORT __attribute__((weak_import))
#define __AVAILABILITY_INTERNAL__ 
#define __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION_DEP__IPHONE_COMPAT_VERSION __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_COMPAT_VERSION_DEP__IPHONE_COMPAT_VERSION_MSG(_msg) __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_NA __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_NA_DEP__IPHONE_NA __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_NA_DEP__IPHONE_NA_MSG(_msg) __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__IPHONE_NA__IPHONE_NA __attribute__((availability(ios,unavailable)))
#define __AVAILABILITY_INTERNAL__MAC_10_0 __attribute__((availability(macosx,introduced=10.0)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_0 __attribute__((availability(macosx,introduced=10.0,deprecated=10.0)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_0_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.0,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.0,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.0,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.0,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.0,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.0,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.0,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.0,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_13_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.13,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_2 __attribute__((availability(macosx,introduced=10.0,deprecated=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_3 __attribute__((availability(macosx,introduced=10.0,deprecated=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_4 __attribute__((availability(macosx,introduced=10.0,deprecated=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.0,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.0,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.0,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.0,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.0,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.0,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.0)))
#define __AVAILABILITY_INTERNAL__MAC_10_0_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.0)))
#define __AVAILABILITY_INTERNAL__MAC_10_1 __attribute__((availability(macosx,introduced=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_10 __attribute__((availability(macosx,introduced=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_2_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_3_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.10,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.10,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.10,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.10,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.10,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.10,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.10,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_13_4 __attribute__((availability(macosx,introduced=10.10,deprecated=10.13.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_10_13_MSG(_msg) __attribute__((availability(macosx,introduced=10.10,deprecated=10.13,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_10_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_11 __attribute__((availability(macosx,introduced=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_2_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_3_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_4_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.11,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.11,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.11,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.11,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_11_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_12 __attribute__((availability(macosx,introduced=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.1,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_1_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.12.2,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.2,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.12.2,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.2,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_2_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_4_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.12.4,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_4_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.4,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_4_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_4_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.12,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.12,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.12,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.12,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_13_4 __attribute__((availability(macosx,introduced=10.12,deprecated=10.13.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_13_MSG(_msg) __attribute__((availability(macosx,introduced=10.12,deprecated=10.13,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_10_14 __attribute__((availability(macosx,introduced=10.12,deprecated=10.14)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_12_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_13 __attribute__((availability(macosx,introduced=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_13_4 __attribute__((availability(macosx,introduced=10.13.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_14 __attribute__((availability(macosx,introduced=10.14)))
#define __AVAILABILITY_INTERNAL__MAC_10_14_DEP__MAC_10_14 __attribute__((availability(macosx,introduced=10.14,deprecated=10.14)))
#define __AVAILABILITY_INTERNAL__MAC_10_15 __attribute__((availability(macosx,introduced=10.15)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.1,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.1,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.1,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.1,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.1,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.1,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_2 __attribute__((availability(macosx,introduced=10.1,deprecated=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_3 __attribute__((availability(macosx,introduced=10.1,deprecated=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_4 __attribute__((availability(macosx,introduced=10.1,deprecated=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.1,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.1,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.1,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.1,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.1,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.1,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_1_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_2 __attribute__((availability(macosx,introduced=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.2,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.2,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.2,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.2,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.2,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.2,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.2,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_2 __attribute__((availability(macosx,introduced=10.2,deprecated=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_3 __attribute__((availability(macosx,introduced=10.2,deprecated=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_4 __attribute__((availability(macosx,introduced=10.2,deprecated=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.2,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.2,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.2,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.2,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.2,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.2,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_2_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_3 __attribute__((availability(macosx,introduced=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.3,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.3,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.3,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.3,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.3,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.3,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.3,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_3 __attribute__((availability(macosx,introduced=10.3,deprecated=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_4 __attribute__((availability(macosx,introduced=10.3,deprecated=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.3,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.3,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.3,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.3,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.3,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.3,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_3_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_4 __attribute__((availability(macosx,introduced=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.4,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.4,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.4,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.4,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.4,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.4,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.4,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_4 __attribute__((availability(macosx,introduced=10.4,deprecated=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.4,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.4,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.4,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.4,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.4,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.4,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_4_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_5 __attribute__((availability(macosx,introduced=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEPRECATED__MAC_10_7 __attribute__((availability(macosx,introduced=10.5.DEPRECATED..MAC.10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.5,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.5,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.5,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.5,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.5,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.5,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_5 __attribute__((availability(macosx,introduced=10.5,deprecated=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_5_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.5,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.5,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.5,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.5,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.5,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.5,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_5_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.5)))
#define __AVAILABILITY_INTERNAL__MAC_10_6 __attribute__((availability(macosx,introduced=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.6,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.6,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.6,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.6,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.6,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.6,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.6,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_6 __attribute__((availability(macosx,introduced=10.6,deprecated=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_6_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.6,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.6,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.6,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.6,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.6,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_6_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.6)))
#define __AVAILABILITY_INTERNAL__MAC_10_7 __attribute__((availability(macosx,introduced=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.7,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.7,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.7,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.7,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.7,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.7,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_13_2 __attribute__((availability(macosx,introduced=10.7,deprecated=10.13.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_7 __attribute__((availability(macosx,introduced=10.7,deprecated=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_7_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.7,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.7,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.7,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.7,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_7_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.7)))
#define __AVAILABILITY_INTERNAL__MAC_10_8 __attribute__((availability(macosx,introduced=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.8,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.8,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.8,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.8,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.8,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.8,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.8,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_8 __attribute__((availability(macosx,introduced=10.8,deprecated=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_8_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.8,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.8,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.8,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_8_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.8)))
#define __AVAILABILITY_INTERNAL__MAC_10_9 __attribute__((availability(macosx,introduced=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_1 __attribute__((availability(macosx,introduced=10.9,deprecated=10.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10 __attribute__((availability(macosx,introduced=10.9,deprecated=10.10)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10_2 __attribute__((availability(macosx,introduced=10.9,deprecated=10.10.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.10.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10_3 __attribute__((availability(macosx,introduced=10.9,deprecated=10.10.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.10.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_10_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.10,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11 __attribute__((availability(macosx,introduced=10.9,deprecated=10.11)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_2 __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_3 __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.3)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_3_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.3,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_4 __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.11.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_11_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.11,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12 __attribute__((availability(macosx,introduced=10.9,deprecated=10.12)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_1 __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.1)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_1_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.1,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_2 __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.2)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_2_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.2,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_4 __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.4)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_4_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.12.4,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_12_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.12,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_13 __attribute__((availability(macosx,introduced=10.9,deprecated=10.13)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_14 __attribute__((availability(macosx,introduced=10.9,deprecated=10.14)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_9 __attribute__((availability(macosx,introduced=10.9,deprecated=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_10_9_MSG(_msg) __attribute__((availability(macosx,introduced=10.9,deprecated=10.9,message=_msg)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_NA __attribute__((availability(macosx,introduced=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_10_9_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,introduced=10.9)))
#define __AVAILABILITY_INTERNAL__MAC_NA __attribute__((availability(macosx,unavailable)))
#define __AVAILABILITY_INTERNAL__MAC_NA_DEP__MAC_NA __attribute__((availability(macosx,unavailable)))
#define __AVAILABILITY_INTERNAL__MAC_NA_DEP__MAC_NA_MSG(_msg) __attribute__((availability(macosx,unavailable)))
#define __BIGGEST_ALIGNMENT__ 16
#define __BLOCKS__ 1
#define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#define __CHAR16_TYPE__ unsigned short
#define __CHAR32_TYPE__ unsigned int
#define __CHAR_BIT__ 8
#define __CLANG_ATOMIC_BOOL_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __CLANG_ATOMIC_CHAR_LOCK_FREE 2
#define __CLANG_ATOMIC_INT_LOCK_FREE 2
#define __CLANG_ATOMIC_LLONG_LOCK_FREE 2
#define __CLANG_ATOMIC_LONG_LOCK_FREE 2
#define __CLANG_ATOMIC_POINTER_LOCK_FREE 2
#define __CLANG_ATOMIC_SHORT_LOCK_FREE 2
#define __CLANG_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __CONSTANT_CFSTRINGS__ 1
#define __DBL_DECIMAL_DIG__ 17
#define __DBL_DENORM_MIN__ 4.9406564584124654e-324
#define __DBL_DIG__ 15
#define __DBL_EPSILON__ 2.2204460492503131e-16
#define __DBL_HAS_DENORM__ 1
#define __DBL_HAS_INFINITY__ 1
#define __DBL_HAS_QUIET_NAN__ 1
#define __DBL_MANT_DIG__ 53
#define __DBL_MAX_10_EXP__ 308
#define __DBL_MAX_EXP__ 1024
#define __DBL_MAX__ 1.7976931348623157e+308
#define __DBL_MIN_10_EXP__ (-307)
#define __DBL_MIN_EXP__ (-1021)
#define __DBL_MIN__ 2.2250738585072014e-308
#define __DECIMAL_DIG__ __LDBL_DECIMAL_DIG__
#define __DYNAMIC__ 1
#define __ENABLE_LEGACY_MAC_AVAILABILITY 1
#define __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__ 101500
#define __FINITE_MATH_ONLY__ 0
#define __FLT16_DECIMAL_DIG__ 5
#define __FLT16_DENORM_MIN__ 5.9604644775390625e-8F16
#define __FLT16_DIG__ 3
#define __FLT16_EPSILON__ 9.765625e-4F16
#define __FLT16_HAS_DENORM__ 1
#define __FLT16_HAS_INFINITY__ 1
#define __FLT16_HAS_QUIET_NAN__ 1
#define __FLT16_MANT_DIG__ 11
#define __FLT16_MAX_10_EXP__ 4
#define __FLT16_MAX_EXP__ 16
#define __FLT16_MAX__ 6.5504e+4F16
#define __FLT16_MIN_10_EXP__ (-4)
#define __FLT16_MIN_EXP__ (-13)
#define __FLT16_MIN__ 6.103515625e-5F16
#define __FLT_DECIMAL_DIG__ 9
#define __FLT_DENORM_MIN__ 1.40129846e-45F
#define __FLT_DIG__ 6
#define __FLT_EPSILON__ 1.19209290e-7F
#define __FLT_EVAL_METHOD__ 0
#define __FLT_HAS_DENORM__ 1
#define __FLT_HAS_INFINITY__ 1
#define __FLT_HAS_QUIET_NAN__ 1
#define __FLT_MANT_DIG__ 24
#define __FLT_MAX_10_EXP__ 38
#define __FLT_MAX_EXP__ 128
#define __FLT_MAX__ 3.40282347e+38F
#define __FLT_MIN_10_EXP__ (-37)
#define __FLT_MIN_EXP__ (-125)
#define __FLT_MIN__ 1.17549435e-38F
#define __FLT_RADIX__ 2
#define __FXSR__ 1
#define __GCC_ASM_FLAG_OUTPUTS__ 1
#define __GCC_ATOMIC_BOOL_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR16_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR32_T_LOCK_FREE 2
#define __GCC_ATOMIC_CHAR_LOCK_FREE 2
#define __GCC_ATOMIC_INT_LOCK_FREE 2
#define __GCC_ATOMIC_LLONG_LOCK_FREE 2
#define __GCC_ATOMIC_LONG_LOCK_FREE 2
#define __GCC_ATOMIC_POINTER_LOCK_FREE 2
#define __GCC_ATOMIC_SHORT_LOCK_FREE 2
#define __GCC_ATOMIC_TEST_AND_SET_TRUEVAL 1
#define __GCC_ATOMIC_WCHAR_T_LOCK_FREE 2
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 1
#define __GNUC_MINOR__ 2
#define __GNUC_PATCHLEVEL__ 1
#define __GNUC_STDC_INLINE__ 1
#define __GNUC__ 4
#define __GXX_ABI_VERSION 1002
#define __INT16_C_SUFFIX__ 
#define __INT16_FMTd__ "hd"
#define __INT16_FMTi__ "hi"
#define __INT16_MAX__ 32767
#define __INT16_TYPE__ short
#define __INT32_C_SUFFIX__ 
#define __INT32_FMTd__ "d"
#define __INT32_FMTi__ "i"
#define __INT32_MAX__ 2147483647
#define __INT32_TYPE__ int
#define __INT64_C_SUFFIX__ LL
#define __INT64_FMTd__ "lld"
#define __INT64_FMTi__ "lli"
#define __INT64_MAX__ 9223372036854775807LL
#define __INT64_TYPE__ long long int
#define __INT8_C_SUFFIX__ 
#define __INT8_FMTd__ "hhd"
#define __INT8_FMTi__ "hhi"
#define __INT8_MAX__ 127
#define __INT8_TYPE__ signed char
#define __INTMAX_C_SUFFIX__ L
#define __INTMAX_FMTd__ "ld"
#define __INTMAX_FMTi__ "li"
#define __INTMAX_MAX__ 9223372036854775807L
#define __INTMAX_TYPE__ long int
#define __INTMAX_WIDTH__ 64
#define __INTPTR_FMTd__ "ld"
#define __INTPTR_FMTi__ "li"
#define __INTPTR_MAX__ 9223372036854775807L
#define __INTPTR_TYPE__ long int
#define __INTPTR_WIDTH__ 64
#define __INT_FAST16_FMTd__ "hd"
#define __INT_FAST16_FMTi__ "hi"
#define __INT_FAST16_MAX__ 32767
#define __INT_FAST16_TYPE__ short
#define __INT_FAST32_FMTd__ "d"
#define __INT_FAST32_FMTi__ "i"
#define __INT_FAST32_MAX__ 2147483647
#define __INT_FAST32_TYPE__ int
#define __INT_FAST64_FMTd__ "lld"
#define __INT_FAST64_FMTi__ "lli"
#define __INT_FAST64_MAX__ 9223372036854775807LL
#define __INT_FAST64_TYPE__ long long int
#define __INT_FAST8_FMTd__ "hhd"
#define __INT_FAST8_FMTi__ "hhi"
#define __INT_FAST8_MAX__ 127
#define __INT_FAST8_TYPE__ signed char
#define __INT_LEAST16_FMTd__ "hd"
#define __INT_LEAST16_FMTi__ "hi"
#define __INT_LEAST16_MAX__ 32767
#define __INT_LEAST16_TYPE__ short
#define __INT_LEAST32_FMTd__ "d"
#define __INT_LEAST32_FMTi__ "i"
#define __INT_LEAST32_MAX__ 2147483647
#define __INT_LEAST32_TYPE__ int
#define __INT_LEAST64_FMTd__ "lld"
#define __INT_LEAST64_FMTi__ "lli"
#define __INT_LEAST64_MAX__ 9223372036854775807LL
#define __INT_LEAST64_TYPE__ long long int
#define __INT_LEAST8_FMTd__ "hhd"
#define __INT_LEAST8_FMTi__ "hhi"
#define __INT_LEAST8_MAX__ 127
#define __INT_LEAST8_TYPE__ signed char
#define __INT_MAX__ 2147483647
#define __LDBL_DECIMAL_DIG__ 21
#define __LDBL_DENORM_MIN__ 3.64519953188247460253e-4951L
#define __LDBL_DIG__ 18
#define __LDBL_EPSILON__ 1.08420217248550443401e-19L
#define __LDBL_HAS_DENORM__ 1
#define __LDBL_HAS_INFINITY__ 1
#define __LDBL_HAS_QUIET_NAN__ 1
#define __LDBL_MANT_DIG__ 64
#define __LDBL_MAX_10_EXP__ 4932
#define __LDBL_MAX_EXP__ 16384
#define __LDBL_MAX__ 1.18973149535723176502e+4932L
#define __LDBL_MIN_10_EXP__ (-4931)
#define __LDBL_MIN_EXP__ (-16381)
#define __LDBL_MIN__ 3.36210314311209350626e-4932L
#define __LITTLE_ENDIAN__ 1
#define __LONG_LONG_MAX__ 9223372036854775807LL
#define __LONG_MAX__ 9223372036854775807L
#define __LP64__ 1
#define __MACH__ 1
#define __MAC_OS_X_VERSION_MAX_ALLOWED __MAC_10_15
#define __MAC_OS_X_VERSION_MIN_REQUIRED __ENVIRONMENT_MAC_OS_X_VERSION_MIN_REQUIRED__
#define __MMX__ 1
#define __NO_INLINE__ 1
#define __NO_MATH_INLINES 1
#define __OBJC_BOOL_IS_BOOL 0
#define __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES 3
#define __OPENCL_MEMORY_SCOPE_DEVICE 2
#define __OPENCL_MEMORY_SCOPE_SUB_GROUP 4
#define __OPENCL_MEMORY_SCOPE_WORK_GROUP 1
#define __OPENCL_MEMORY_SCOPE_WORK_ITEM 0
#define __ORDER_BIG_ENDIAN__ 4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#define __ORDER_PDP_ENDIAN__ 3412
#define __OS_AVAILABILITY__ 
#define __PIC__ 2
#define __POINTER_WIDTH__ 64
#define __PRAGMA_REDEFINE_EXTNAME 1
#define __PTRDIFF_FMTd__ "ld"
#define __PTRDIFF_FMTi__ "li"
#define __PTRDIFF_MAX__ 9223372036854775807L
#define __PTRDIFF_TYPE__ long int
#define __PTRDIFF_WIDTH__ 64
#define __REGISTER_PREFIX__ 
#define __SCHAR_MAX__ 127
#define __SHRT_MAX__ 32767
#define __SIG_ATOMIC_MAX__ 2147483647
#define __SIG_ATOMIC_WIDTH__ 32
#define __SIZEOF_DOUBLE__ 8
#define __SIZEOF_FLOAT__ 4
#define __SIZEOF_INT128__ 16
#define __SIZEOF_INT__ 4
#define __SIZEOF_LONG_DOUBLE__ 16
#define __SIZEOF_LONG_LONG__ 8
#define __SIZEOF_LONG__ 8
#define __SIZEOF_POINTER__ 8
#define __SIZEOF_PTRDIFF_T__ 8
#define __SIZEOF_SHORT__ 2
#define __SIZEOF_SIZE_T__ 8
#define __SIZEOF_WCHAR_T__ 4
#define __SIZEOF_WINT_T__ 4
#define __SIZE_FMTX__ "lX"
#define __SIZE_FMTo__ "lo"
#define __SIZE_FMTu__ "lu"
#define __SIZE_FMTx__ "lx"
#define __SIZE_MAX__ 18446744073709551615UL
#define __SIZE_TYPE__ long unsigned int
#define __SIZE_WIDTH__ 64
#define __SPI_AVAILABLE(...) 
#define __SSE2_MATH__ 1
#define __SSE2__ 1
#define __SSE3__ 1
#define __SSE4_1__ 1
#define __SSE_MATH__ 1
#define __SSE__ 1
#define __SSP__ 1
#define __SSSE3__ 1
#define __STDC_HOSTED__ 1
#define __STDC_NO_THREADS__ 1
#define __STDC_UTF_16__ 1
#define __STDC_UTF_32__ 1
#define __STDC_VERSION__ 201112L
#define __STDC__ 1
#define __UINT16_C_SUFFIX__ 
#define __UINT16_FMTX__ "hX"
#define __UINT16_FMTo__ "ho"
#define __UINT16_FMTu__ "hu"
#define __UINT16_FMTx__ "hx"
#define __UINT16_MAX__ 65535
#define __UINT16_TYPE__ unsigned short
#define __UINT32_C_SUFFIX__ U
#define __UINT32_FMTX__ "X"
#define __UINT32_FMTo__ "o"
#define __UINT32_FMTu__ "u"
#define __UINT32_FMTx__ "x"
#define __UINT32_MAX__ 4294967295U
#define __UINT32_TYPE__ unsigned int
#define __UINT64_C_SUFFIX__ ULL
#define __UINT64_FMTX__ "llX"
#define __UINT64_FMTo__ "llo"
#define __UINT64_FMTu__ "llu"
#define __UINT64_FMTx__ "llx"
#define __UINT64_MAX__ 18446744073709551615ULL
#define __UINT64_TYPE__ long long unsigned int
#define __UINT8_C_SUFFIX__ 
#define __UINT8_FMTX__ "hhX"
#define __UINT8_FMTo__ "hho"
#define __UINT8_FMTu__ "hhu"
#define __UINT8_FMTx__ "hhx"
#define __UINT8_MAX__ 255
#define __UINT8_TYPE__ unsigned char
#define __UINTMAX_C_SUFFIX__ UL
#define __UINTMAX_FMTX__ "lX"
#define __UINTMAX_FMTo__ "lo"
#define __UINTMAX_FMTu__ "lu"
#define __UINTMAX_FMTx__ "lx"
#define __UINTMAX_MAX__ 18446744073709551615UL
#define __UINTMAX_TYPE__ long unsigned int
#define __UINTMAX_WIDTH__ 64
#define __UINTPTR_FMTX__ "lX"
#define __UINTPTR_FMTo__ "lo"
#define __UINTPTR_FMTu__ "lu"
#define __UINTPTR_FMTx__ "lx"
#define __UINTPTR_MAX__ 18446744073709551615UL
#define __UINTPTR_TYPE__ long unsigned int
#define __UINTPTR_WIDTH__ 64
#define __UINT_FAST16_FMTX__ "hX"
#define __UINT_FAST16_FMTo__ "ho"
#define __UINT_FAST16_FMTu__ "hu"
#define __UINT_FAST16_FMTx__ "hx"
#define __UINT_FAST16_MAX__ 65535
#define __UINT_FAST16_TYPE__ unsigned short
#define __UINT_FAST32_FMTX__ "X"
#define __UINT_FAST32_FMTo__ "o"
#define __UINT_FAST32_FMTu__ "u"
#define __UINT_FAST32_FMTx__ "x"
#define __UINT_FAST32_MAX__ 4294967295U
#define __UINT_FAST32_TYPE__ unsigned int
#define __UINT_FAST64_FMTX__ "llX"
#define __UINT_FAST64_FMTo__ "llo"
#define __UINT_FAST64_FMTu__ "llu"
#define __UINT_FAST64_FMTx__ "llx"
#define __UINT_FAST64_MAX__ 18446744073709551615ULL
#define __UINT_FAST64_TYPE__ long long unsigned int
#define __UINT_FAST8_FMTX__ "hhX"
#define __UINT_FAST8_FMTo__ "hho"
#define __UINT_FAST8_FMTu__ "hhu"
#define __UINT_FAST8_FMTx__ "hhx"
#define __UINT_FAST8_MAX__ 255
#define __UINT_FAST8_TYPE__ unsigned char
#define __UINT_LEAST16_FMTX__ "hX"
#define __UINT_LEAST16_FMTo__ "ho"
#define __UINT_LEAST16_FMTu__ "hu"
#define __UINT_LEAST16_FMTx__ "hx"
#define __UINT_LEAST16_MAX__ 65535
#define __UINT_LEAST16_TYPE__ unsigned short
#define __UINT_LEAST32_FMTX__ "X"
#define __UINT_LEAST32_FMTo__ "o"
#define __UINT_LEAST32_FMTu__ "u"
#define __UINT_LEAST32_FMTx__ "x"
#define __UINT_LEAST32_MAX__ 4294967295U
#define __UINT_LEAST32_TYPE__ unsigned int
#define __UINT_LEAST64_FMTX__ "llX"
#define __UINT_LEAST64_FMTo__ "llo"
#define __UINT_LEAST64_FMTu__ "llu"
#define __UINT_LEAST64_FMTx__ "llx"
#define __UINT_LEAST64_MAX__ 18446744073709551615ULL
#define __UINT_LEAST64_TYPE__ long long unsigned int
#define __UINT_LEAST8_FMTX__ "hhX"
#define __UINT_LEAST8_FMTo__ "hho"
#define __UINT_LEAST8_FMTu__ "hhu"
#define __UINT_LEAST8_FMTx__ "hhx"
#define __UINT_LEAST8_MAX__ 255
#define __UINT_LEAST8_TYPE__ unsigned char
#define __USER_LABEL_PREFIX__ _
#define __VERSION__ "4.2.1 Compatible Apple LLVM 11.0.3 (clang-1103.0.32.62)"
#define __WCHAR_MAX__ 2147483647
#define __WCHAR_TYPE__ int
#define __WCHAR_WIDTH__ 32
#define __WINT_MAX__ 2147483647
#define __WINT_TYPE__ int
#define __WINT_WIDTH__ 32
#define __amd64 1
#define __amd64__ 1
#define __apple_build_version__ 11030032
#define __block __attribute__((__blocks__(byref)))
#define __clang__ 1
#define __clang_major__ 11
#define __clang_minor__ 0
#define __clang_patchlevel__ 3
#define __clang_version__ "11.0.3 (clang-1103.0.32.62)"
#define __code_model_small_ 1
#define __core2 1
#define __core2__ 1
#define __llvm__ 1
#define __nonnull _Nonnull
#define __null_unspecified _Null_unspecified
#define __nullable _Nullable
#define __pic__ 2
#define __strong 
#define __swift_compiler_version_at_least(...) 1
#define __tune_core2__ 1
#define __unsafe_unretained 
#define __weak __attribute__((objc_gc(weak)))
#define __x86_64 1
#define __x86_64__ 1
