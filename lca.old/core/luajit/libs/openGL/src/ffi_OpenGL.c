






typedef __signed char int8_t;
typedef short int16_t;
typedef int int32_t;
typedef long long int64_t;

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;


typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;
typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;



typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;
typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;





typedef signed char __int8_t;



typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;

typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
typedef int __darwin_ct_rune_t;





typedef union {
 char __mbstate8[128];
 long long _mbstateL;
} __mbstate_t;

typedef __mbstate_t __darwin_mbstate_t;


typedef long int __darwin_ptrdiff_t;







typedef long unsigned int __darwin_size_t;





typedef __builtin_va_list __darwin_va_list;





typedef int __darwin_wchar_t;




typedef __darwin_wchar_t __darwin_rune_t;


typedef int __darwin_wint_t;




typedef unsigned long __darwin_clock_t;
typedef __uint32_t __darwin_socklen_t;
typedef long __darwin_ssize_t;
typedef long __darwin_time_t;
typedef __int64_t __darwin_blkcnt_t;
typedef __int32_t __darwin_blksize_t;
typedef __int32_t __darwin_dev_t;
typedef unsigned int __darwin_fsblkcnt_t;
typedef unsigned int __darwin_fsfilcnt_t;
typedef __uint32_t __darwin_gid_t;
typedef __uint32_t __darwin_id_t;
typedef __uint64_t __darwin_ino64_t;

typedef __darwin_ino64_t __darwin_ino_t;



typedef __darwin_natural_t __darwin_mach_port_name_t;
typedef __darwin_mach_port_name_t __darwin_mach_port_t;
typedef __uint16_t __darwin_mode_t;
typedef __int64_t __darwin_off_t;
typedef __int32_t __darwin_pid_t;
typedef __uint32_t __darwin_sigset_t;
typedef __int32_t __darwin_suseconds_t;
typedef __uint32_t __darwin_uid_t;
typedef __uint32_t __darwin_useconds_t;
typedef unsigned char __darwin_uuid_t[16];
typedef char __darwin_uuid_string_t[37];


struct __darwin_pthread_handler_rec {
 void (*__routine)(void *);
 void *__arg;
 struct __darwin_pthread_handler_rec *__next;
};

struct _opaque_pthread_attr_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_cond_t {
 long __sig;
 char __opaque[40];
};

struct _opaque_pthread_condattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_mutex_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_mutexattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_once_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_rwlock_t {
 long __sig;
 char __opaque[192];
};

struct _opaque_pthread_rwlockattr_t {
 long __sig;
 char __opaque[16];
};

struct _opaque_pthread_t {
 long __sig;
 struct __darwin_pthread_handler_rec *__cleanup_stack;
 char __opaque[8176];
};

typedef struct _opaque_pthread_attr_t __darwin_pthread_attr_t;
typedef struct _opaque_pthread_cond_t __darwin_pthread_cond_t;
typedef struct _opaque_pthread_condattr_t __darwin_pthread_condattr_t;
typedef unsigned long __darwin_pthread_key_t;
typedef struct _opaque_pthread_mutex_t __darwin_pthread_mutex_t;
typedef struct _opaque_pthread_mutexattr_t __darwin_pthread_mutexattr_t;
typedef struct _opaque_pthread_once_t __darwin_pthread_once_t;
typedef struct _opaque_pthread_rwlock_t __darwin_pthread_rwlock_t;
typedef struct _opaque_pthread_rwlockattr_t __darwin_pthread_rwlockattr_t;
typedef struct _opaque_pthread_t *__darwin_pthread_t;
typedef unsigned char u_int8_t;
typedef unsigned short u_int16_t;
typedef unsigned int u_int32_t;
typedef unsigned long long u_int64_t;


typedef int64_t register_t;





typedef unsigned long uintptr_t;



typedef u_int64_t user_addr_t;
typedef u_int64_t user_size_t;
typedef int64_t user_ssize_t;
typedef int64_t user_long_t;
typedef u_int64_t user_ulong_t;
typedef int64_t user_time_t;
typedef int64_t user_off_t;







typedef u_int64_t syscall_arg_t;

typedef __darwin_intptr_t intptr_t;




typedef long int intmax_t;
typedef long unsigned int uintmax_t;

typedef uint32_t GLbitfield;
typedef uint8_t GLboolean;
typedef int8_t GLbyte;
typedef float GLclampf;
typedef uint32_t GLenum;
typedef float GLfloat;
typedef int32_t GLint;
typedef int16_t GLshort;
typedef int32_t GLsizei;
typedef uint8_t GLubyte;
typedef uint32_t GLuint;
typedef uint16_t GLushort;
typedef void GLvoid;


typedef char GLchar;


typedef char GLcharARB;
typedef void *GLhandleARB;

typedef double GLdouble;
typedef double GLclampd;

typedef int32_t GLfixed;


typedef uint16_t GLhalf;


typedef uint16_t GLhalfARB;


typedef int64_t GLint64;
typedef struct __GLsync *GLsync;
typedef uint64_t GLuint64;


typedef int64_t GLint64EXT;
typedef uint64_t GLuint64EXT;


typedef intptr_t GLintptr;
typedef intptr_t GLsizeiptr;


typedef intptr_t GLintptrARB;
typedef intptr_t GLsizeiptrARB;



extern void glCullFace (GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFrontFace (GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glHint (GLenum target, GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glLineWidth (GLfloat width) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPointSize (GLfloat size) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPolygonMode (GLenum face, GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glScissor (GLint x, GLint y, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameterf (GLenum target, GLenum pname, GLfloat param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameterfv (GLenum target, GLenum pname, const GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameteri (GLenum target, GLenum pname, GLint param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameteriv (GLenum target, GLenum pname, const GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexImage1D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexImage2D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawBuffer (GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClear (GLbitfield mask) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearStencil (GLint s) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearDepth (GLclampd depth) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilMask (GLuint mask) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glColorMask (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthMask (GLboolean flag) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDisable (GLenum cap) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEnable (GLenum cap) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFinish (void) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFlush (void) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendFunc (GLenum sfactor, GLenum dfactor) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glLogicOp (GLenum opcode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilFunc (GLenum func, GLint ref, GLuint mask) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilOp (GLenum fail, GLenum zfail, GLenum zpass) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthFunc (GLenum func) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPixelStoref (GLenum pname, GLfloat param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPixelStorei (GLenum pname, GLint param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glReadBuffer (GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glReadPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBooleanv (GLenum pname, GLboolean *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetDoublev (GLenum pname, GLdouble *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLenum glGetError (void) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetFloatv (GLenum pname, GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetIntegerv (GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern const GLubyte * glGetString (GLenum name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexParameterfv (GLenum target, GLenum pname, GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexParameteriv (GLenum target, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexLevelParameterfv (GLenum target, GLint level, GLenum pname, GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexLevelParameteriv (GLenum target, GLint level, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsEnabled (GLenum cap) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthRange (GLclampd near, GLclampd far) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glViewport (GLint x, GLint y, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLCULLFACEPROC) (GLenum mode);
typedef void ( * PFNGLFRONTFACEPROC) (GLenum mode);
typedef void ( * PFNGLHINTPROC) (GLenum target, GLenum mode);
typedef void ( * PFNGLLINEWIDTHPROC) (GLfloat width);
typedef void ( * PFNGLPOINTSIZEPROC) (GLfloat size);
typedef void ( * PFNGLPOLYGONMODEPROC) (GLenum face, GLenum mode);
typedef void ( * PFNGLSCISSORPROC) (GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXPARAMETERFPROC) (GLenum target, GLenum pname, GLfloat param);
typedef void ( * PFNGLTEXPARAMETERFVPROC) (GLenum target, GLenum pname, const GLfloat *params);
typedef void ( * PFNGLTEXPARAMETERIPROC) (GLenum target, GLenum pname, GLint param);
typedef void ( * PFNGLTEXPARAMETERIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXIMAGE1DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLTEXIMAGE2DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLDRAWBUFFERPROC) (GLenum mode);
typedef void ( * PFNGLCLEARPROC) (GLbitfield mask);
typedef void ( * PFNGLCLEARCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void ( * PFNGLCLEARSTENCILPROC) (GLint s);
typedef void ( * PFNGLCLEARDEPTHPROC) (GLclampd depth);
typedef void ( * PFNGLSTENCILMASKPROC) (GLuint mask);
typedef void ( * PFNGLCOLORMASKPROC) (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
typedef void ( * PFNGLDEPTHMASKPROC) (GLboolean flag);
typedef void ( * PFNGLDISABLEPROC) (GLenum cap);
typedef void ( * PFNGLENABLEPROC) (GLenum cap);
typedef void ( * PFNGLFINISHPROC) (void);
typedef void ( * PFNGLFLUSHPROC) (void);
typedef void ( * PFNGLBLENDFUNCPROC) (GLenum sfactor, GLenum dfactor);
typedef void ( * PFNGLLOGICOPPROC) (GLenum opcode);
typedef void ( * PFNGLSTENCILFUNCPROC) (GLenum func, GLint ref, GLuint mask);
typedef void ( * PFNGLSTENCILOPPROC) (GLenum fail, GLenum zfail, GLenum zpass);
typedef void ( * PFNGLDEPTHFUNCPROC) (GLenum func);
typedef void ( * PFNGLPIXELSTOREFPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPIXELSTOREIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLREADBUFFERPROC) (GLenum mode);
typedef void ( * PFNGLREADPIXELSPROC) (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels);
typedef void ( * PFNGLGETBOOLEANVPROC) (GLenum pname, GLboolean *params);
typedef void ( * PFNGLGETDOUBLEVPROC) (GLenum pname, GLdouble *params);
typedef GLenum ( * PFNGLGETERRORPROC) (void);
typedef void ( * PFNGLGETFLOATVPROC) (GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETINTEGERVPROC) (GLenum pname, GLint *params);
typedef const GLubyte * ( * PFNGLGETSTRINGPROC) (GLenum name);
typedef void ( * PFNGLGETTEXIMAGEPROC) (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels);
typedef void ( * PFNGLGETTEXPARAMETERFVPROC) (GLenum target, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXLEVELPARAMETERFVPROC) (GLenum target, GLint level, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETTEXLEVELPARAMETERIVPROC) (GLenum target, GLint level, GLenum pname, GLint *params);
typedef GLboolean ( * PFNGLISENABLEDPROC) (GLenum cap);
typedef void ( * PFNGLDEPTHRANGEPROC) (GLclampd near, GLclampd far);
typedef void ( * PFNGLVIEWPORTPROC) (GLint x, GLint y, GLsizei width, GLsizei height);





extern void glDrawArrays (GLenum mode, GLint first, GLsizei count) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPolygonOffset (GLfloat factor, GLfloat units) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCopyTexImage1D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCopyTexImage2D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCopyTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCopyTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindTexture (GLenum target, GLuint texture) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteTextures (GLsizei n, const GLuint *textures) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenTextures (GLsizei n, GLuint *textures) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsTexture (GLuint texture) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLDRAWARRAYSPROC) (GLenum mode, GLint first, GLsizei count);
typedef void ( * PFNGLDRAWELEMENTSPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);
typedef void ( * PFNGLPOLYGONOFFSETPROC) (GLfloat factor, GLfloat units);
typedef void ( * PFNGLCOPYTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border);
typedef void ( * PFNGLCOPYTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);
typedef void ( * PFNGLCOPYTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);
typedef void ( * PFNGLCOPYTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);
typedef void ( * PFNGLTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLBINDTEXTUREPROC) (GLenum target, GLuint texture);
typedef void ( * PFNGLDELETETEXTURESPROC) (GLsizei n, const GLuint *textures);
typedef void ( * PFNGLGENTEXTURESPROC) (GLsizei n, GLuint *textures);
typedef GLboolean ( * PFNGLISTEXTUREPROC) (GLuint texture);





extern void glBlendColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendEquation (GLenum mode) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawRangeElements (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexImage3D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCopyTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void ( * PFNGLBLENDEQUATIONPROC) (GLenum mode);
typedef void ( * PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void ( * PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);





extern void glActiveTexture (GLenum texture) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSampleCoverage (GLclampf value, GLboolean invert) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexImage3D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexImage2D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexImage1D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompressedTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetCompressedTexImage (GLenum target, GLint level, GLvoid *img) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void ( * PFNGLSAMPLECOVERAGEPROC) (GLclampf value, GLboolean invert);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, GLvoid *img);





extern void glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glMultiDrawArrays (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glMultiDrawElements (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPointParameterf (GLenum pname, GLfloat param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPointParameterfv (GLenum pname, const GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPointParameteri (GLenum pname, GLint param) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPointParameteriv (GLenum pname, const GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void ( * PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void ( * PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount);
typedef void ( * PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);





extern void glGenQueries (GLsizei n, GLuint *ids) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteQueries (GLsizei n, const GLuint *ids) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsQuery (GLuint id) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBeginQuery (GLenum target, GLuint id) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEndQuery (GLenum target) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryiv (GLenum target, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryObjectiv (GLuint id, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryObjectuiv (GLuint id, GLenum pname, GLuint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindBuffer (GLenum target, GLuint buffer) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteBuffers (GLsizei n, const GLuint *buffers) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenBuffers (GLsizei n, GLuint *buffers) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsBuffer (GLuint buffer) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBufferData (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, GLvoid *data) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLvoid* glMapBuffer (GLenum target, GLenum access) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glUnmapBuffer (GLenum target) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBufferParameteriv (GLenum target, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBufferPointerv (GLenum target, GLenum pname, GLvoid* *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLGENQUERIESPROC) (GLsizei n, GLuint *ids);
typedef void ( * PFNGLDELETEQUERIESPROC) (GLsizei n, const GLuint *ids);
typedef GLboolean ( * PFNGLISQUERYPROC) (GLuint id);
typedef void ( * PFNGLBEGINQUERYPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLENDQUERYPROC) (GLenum target);
typedef void ( * PFNGLGETQUERYIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTIVPROC) (GLuint id, GLenum pname, GLint *params);
typedef void ( * PFNGLGETQUERYOBJECTUIVPROC) (GLuint id, GLenum pname, GLuint *params);
typedef void ( * PFNGLBINDBUFFERPROC) (GLenum target, GLuint buffer);
typedef void ( * PFNGLDELETEBUFFERSPROC) (GLsizei n, const GLuint *buffers);
typedef void ( * PFNGLGENBUFFERSPROC) (GLsizei n, GLuint *buffers);
typedef GLboolean ( * PFNGLISBUFFERPROC) (GLuint buffer);
typedef void ( * PFNGLBUFFERDATAPROC) (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
typedef void ( * PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);
typedef void ( * PFNGLGETBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, GLvoid *data);
typedef GLvoid* ( * PFNGLMAPBUFFERPROC) (GLenum target, GLenum access);
typedef GLboolean ( * PFNGLUNMAPBUFFERPROC) (GLenum target);
typedef void ( * PFNGLGETBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETBUFFERPOINTERVPROC) (GLenum target, GLenum pname, GLvoid* *params);





extern void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawBuffers (GLsizei n, const GLenum *bufs) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glStencilMaskSeparate (GLenum face, GLuint mask) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glAttachShader (GLuint program, GLuint shader) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindAttribLocation (GLuint program, GLuint index, const GLchar *name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glCompileShader (GLuint shader) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLuint glCreateProgram (void) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLuint glCreateShader (GLenum type) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteProgram (GLuint program) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteShader (GLuint shader) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDetachShader (GLuint program, GLuint shader) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDisableVertexAttribArray (GLuint index) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEnableVertexAttribArray (GLuint index) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLint glGetAttribLocation (GLuint program, const GLchar *name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetProgramiv (GLuint program, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetShaderiv (GLuint shader, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLint glGetUniformLocation (GLuint program, const GLchar *name) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetUniformfv (GLuint program, GLint location, GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetUniformiv (GLuint program, GLint location, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribPointerv (GLuint index, GLenum pname, GLvoid* *pointer) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsProgram (GLuint program) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsShader (GLuint shader) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glLinkProgram (GLuint program) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glShaderSource (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUseProgram (GLuint program) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1f (GLint location, GLfloat v0) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2f (GLint location, GLfloat v0, GLfloat v1) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1i (GLint location, GLint v0) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2i (GLint location, GLint v0, GLint v1) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3i (GLint location, GLint v0, GLint v1, GLint v2) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1fv (GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2fv (GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3fv (GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4fv (GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1iv (GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2iv (GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3iv (GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4iv (GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glValidateProgram (GLuint program) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1d (GLuint index, GLdouble x) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1f (GLuint index, GLfloat x) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1fv (GLuint index, const GLfloat *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1s (GLuint index, GLshort x) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib1sv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2fv (GLuint index, const GLfloat *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2s (GLuint index, GLshort x, GLshort y) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib2sv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3fv (GLuint index, const GLfloat *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib3sv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nbv (GLuint index, const GLbyte *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Niv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nsv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nubv (GLuint index, const GLubyte *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nuiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4Nusv (GLuint index, const GLushort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4bv (GLuint index, const GLbyte *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4fv (GLuint index, const GLfloat *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4iv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4sv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4ubv (GLuint index, const GLubyte *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4uiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttrib4usv (GLuint index, const GLushort *v) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBLENDEQUATIONSEPARATEPROC) (GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLDRAWBUFFERSPROC) (GLsizei n, const GLenum *bufs);
typedef void ( * PFNGLSTENCILOPSEPARATEPROC) (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass);
typedef void ( * PFNGLSTENCILFUNCSEPARATEPROC) (GLenum face, GLenum func, GLint ref, GLuint mask);
typedef void ( * PFNGLSTENCILMASKSEPARATEPROC) (GLenum face, GLuint mask);
typedef void ( * PFNGLATTACHSHADERPROC) (GLuint program, GLuint shader);
typedef void ( * PFNGLBINDATTRIBLOCATIONPROC) (GLuint program, GLuint index, const GLchar *name);
typedef void ( * PFNGLCOMPILESHADERPROC) (GLuint shader);
typedef GLuint ( * PFNGLCREATEPROGRAMPROC) (void);
typedef GLuint ( * PFNGLCREATESHADERPROC) (GLenum type);
typedef void ( * PFNGLDELETEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLDELETESHADERPROC) (GLuint shader);
typedef void ( * PFNGLDETACHSHADERPROC) (GLuint program, GLuint shader);
typedef void ( * PFNGLDISABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void ( * PFNGLENABLEVERTEXATTRIBARRAYPROC) (GLuint index);
typedef void ( * PFNGLGETACTIVEATTRIBPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLGETACTIVEUNIFORMPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLGETATTACHEDSHADERSPROC) (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders);
typedef GLint ( * PFNGLGETATTRIBLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGETPROGRAMIVPROC) (GLuint program, GLenum pname, GLint *params);
typedef void ( * PFNGLGETPROGRAMINFOLOGPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void ( * PFNGLGETSHADERIVPROC) (GLuint shader, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSHADERINFOLOGPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void ( * PFNGLGETSHADERSOURCEPROC) (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source);
typedef GLint ( * PFNGLGETUNIFORMLOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLGETUNIFORMFVPROC) (GLuint program, GLint location, GLfloat *params);
typedef void ( * PFNGLGETUNIFORMIVPROC) (GLuint program, GLint location, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBDVPROC) (GLuint index, GLenum pname, GLdouble *params);
typedef void ( * PFNGLGETVERTEXATTRIBFVPROC) (GLuint index, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETVERTEXATTRIBIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBPOINTERVPROC) (GLuint index, GLenum pname, GLvoid* *pointer);
typedef GLboolean ( * PFNGLISPROGRAMPROC) (GLuint program);
typedef GLboolean ( * PFNGLISSHADERPROC) (GLuint shader);
typedef void ( * PFNGLLINKPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLSHADERSOURCEPROC) (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length);
typedef void ( * PFNGLUSEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLUNIFORM1FPROC) (GLint location, GLfloat v0);
typedef void ( * PFNGLUNIFORM2FPROC) (GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLUNIFORM3FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLUNIFORM4FPROC) (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLUNIFORM1IPROC) (GLint location, GLint v0);
typedef void ( * PFNGLUNIFORM2IPROC) (GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLUNIFORM3IPROC) (GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLUNIFORM4IPROC) (GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLUNIFORM1FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM2FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM3FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM4FVPROC) (GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLUNIFORM1IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM2IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM3IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORM4IVPROC) (GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLUNIFORMMATRIX2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLVALIDATEPROGRAMPROC) (GLuint program);
typedef void ( * PFNGLVERTEXATTRIB1DPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIB1DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB1FPROC) (GLuint index, GLfloat x);
typedef void ( * PFNGLVERTEXATTRIB1FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB1SPROC) (GLuint index, GLshort x);
typedef void ( * PFNGLVERTEXATTRIB1SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIB2DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB2FPROC) (GLuint index, GLfloat x, GLfloat y);
typedef void ( * PFNGLVERTEXATTRIB2FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB2SPROC) (GLuint index, GLshort x, GLshort y);
typedef void ( * PFNGLVERTEXATTRIB2SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIB3DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB3FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z);
typedef void ( * PFNGLVERTEXATTRIB3FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB3SPROC) (GLuint index, GLshort x, GLshort y, GLshort z);
typedef void ( * PFNGLVERTEXATTRIB3SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NBVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NIVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4NSVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4NUBPROC) (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w);
typedef void ( * PFNGLVERTEXATTRIB4NUBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4NUIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4NUSVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIB4BVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIB4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIB4DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIB4FPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w);
typedef void ( * PFNGLVERTEXATTRIB4FVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLVERTEXATTRIB4IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIB4SPROC) (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w);
typedef void ( * PFNGLVERTEXATTRIB4SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIB4UBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIB4UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIB4USVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLVERTEXATTRIBPOINTERPROC) (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);





extern void glUniformMatrix2x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix2x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
extern void glColorMaski (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBooleani_v (GLenum target, GLuint index, GLboolean *data) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetIntegeri_v (GLenum target, GLuint index, GLint *data) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEnablei (GLenum target, GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDisablei (GLenum target, GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsEnabledi (GLenum target, GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBeginTransformFeedback (GLenum primitiveMode) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEndTransformFeedback (void) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindBufferRange (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindBufferBase (GLenum target, GLuint index, GLuint buffer) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTransformFeedbackVaryings (GLuint program, GLsizei count, const GLchar* const *varyings, GLenum bufferMode) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTransformFeedbackVarying (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClampColor (GLenum target, GLenum clamp) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBeginConditionalRender (GLuint id, GLenum mode) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEndConditionalRender (void) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribIPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribIiv (GLuint index, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribIuiv (GLuint index, GLenum pname, GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI1i (GLuint index, GLint x) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI2i (GLuint index, GLint x, GLint y) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI3i (GLuint index, GLint x, GLint y, GLint z) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4i (GLuint index, GLint x, GLint y, GLint z, GLint w) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI1ui (GLuint index, GLuint x) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI2ui (GLuint index, GLuint x, GLuint y) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI3ui (GLuint index, GLuint x, GLuint y, GLuint z) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4ui (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI1iv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI2iv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI3iv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4iv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI1uiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI2uiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI3uiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4uiv (GLuint index, const GLuint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4bv (GLuint index, const GLbyte *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4sv (GLuint index, const GLshort *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4ubv (GLuint index, const GLubyte *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribI4usv (GLuint index, const GLushort *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetUniformuiv (GLuint program, GLint location, GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindFragDataLocation (GLuint program, GLuint color, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLint glGetFragDataLocation (GLuint program, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1ui (GLint location, GLuint v0) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2ui (GLint location, GLuint v0, GLuint v1) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3ui (GLint location, GLuint v0, GLuint v1, GLuint v2) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4ui (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1uiv (GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2uiv (GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3uiv (GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4uiv (GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameterIiv (GLenum target, GLenum pname, const GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexParameterIuiv (GLenum target, GLenum pname, const GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexParameterIiv (GLenum target, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetTexParameterIuiv (GLenum target, GLenum pname, GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearBufferiv (GLenum buffer, GLint drawbuffer, const GLint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearBufferuiv (GLenum buffer, GLint drawbuffer, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearBufferfv (GLenum buffer, GLint drawbuffer, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearBufferfi (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern const GLubyte * glGetStringi (GLenum name, GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLCOLORMASKIPROC) (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a);
typedef void ( * PFNGLGETBOOLEANI_VPROC) (GLenum target, GLuint index, GLboolean *data);
typedef void ( * PFNGLGETINTEGERI_VPROC) (GLenum target, GLuint index, GLint *data);
typedef void ( * PFNGLENABLEIPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLDISABLEIPROC) (GLenum target, GLuint index);
typedef GLboolean ( * PFNGLISENABLEDIPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLBEGINTRANSFORMFEEDBACKPROC) (GLenum primitiveMode);
typedef void ( * PFNGLENDTRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLBINDBUFFERRANGEPROC) (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size);
typedef void ( * PFNGLBINDBUFFERBASEPROC) (GLenum target, GLuint index, GLuint buffer);
typedef void ( * PFNGLTRANSFORMFEEDBACKVARYINGSPROC) (GLuint program, GLsizei count, const GLchar* const *varyings, GLenum bufferMode);
typedef void ( * PFNGLGETTRANSFORMFEEDBACKVARYINGPROC) (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name);
typedef void ( * PFNGLCLAMPCOLORPROC) (GLenum target, GLenum clamp);
typedef void ( * PFNGLBEGINCONDITIONALRENDERPROC) (GLuint id, GLenum mode);
typedef void ( * PFNGLENDCONDITIONALRENDERPROC) (void);
typedef void ( * PFNGLVERTEXATTRIBIPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBIIVPROC) (GLuint index, GLenum pname, GLint *params);
typedef void ( * PFNGLGETVERTEXATTRIBIUIVPROC) (GLuint index, GLenum pname, GLuint *params);
typedef void ( * PFNGLVERTEXATTRIBI1IPROC) (GLuint index, GLint x);
typedef void ( * PFNGLVERTEXATTRIBI2IPROC) (GLuint index, GLint x, GLint y);
typedef void ( * PFNGLVERTEXATTRIBI3IPROC) (GLuint index, GLint x, GLint y, GLint z);
typedef void ( * PFNGLVERTEXATTRIBI4IPROC) (GLuint index, GLint x, GLint y, GLint z, GLint w);
typedef void ( * PFNGLVERTEXATTRIBI1UIPROC) (GLuint index, GLuint x);
typedef void ( * PFNGLVERTEXATTRIBI2UIPROC) (GLuint index, GLuint x, GLuint y);
typedef void ( * PFNGLVERTEXATTRIBI3UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z);
typedef void ( * PFNGLVERTEXATTRIBI4UIPROC) (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w);
typedef void ( * PFNGLVERTEXATTRIBI1IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI2IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI3IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI4IVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLVERTEXATTRIBI1UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI2UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI3UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4UIVPROC) (GLuint index, const GLuint *v);
typedef void ( * PFNGLVERTEXATTRIBI4BVPROC) (GLuint index, const GLbyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4SVPROC) (GLuint index, const GLshort *v);
typedef void ( * PFNGLVERTEXATTRIBI4UBVPROC) (GLuint index, const GLubyte *v);
typedef void ( * PFNGLVERTEXATTRIBI4USVPROC) (GLuint index, const GLushort *v);
typedef void ( * PFNGLGETUNIFORMUIVPROC) (GLuint program, GLint location, GLuint *params);
typedef void ( * PFNGLBINDFRAGDATALOCATIONPROC) (GLuint program, GLuint color, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATALOCATIONPROC) (GLuint program, const GLchar *name);
typedef void ( * PFNGLUNIFORM1UIPROC) (GLint location, GLuint v0);
typedef void ( * PFNGLUNIFORM2UIPROC) (GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLUNIFORM3UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLUNIFORM4UIPROC) (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLUNIFORM1UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM2UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM3UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLUNIFORM4UIVPROC) (GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, const GLint *params);
typedef void ( * PFNGLTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, const GLuint *params);
typedef void ( * PFNGLGETTEXPARAMETERIIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef void ( * PFNGLGETTEXPARAMETERIUIVPROC) (GLenum target, GLenum pname, GLuint *params);
typedef void ( * PFNGLCLEARBUFFERIVPROC) (GLenum buffer, GLint drawbuffer, const GLint *value);
typedef void ( * PFNGLCLEARBUFFERUIVPROC) (GLenum buffer, GLint drawbuffer, const GLuint *value);
typedef void ( * PFNGLCLEARBUFFERFVPROC) (GLenum buffer, GLint drawbuffer, const GLfloat *value);
typedef void ( * PFNGLCLEARBUFFERFIPROC) (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil);
typedef const GLubyte * ( * PFNGLGETSTRINGIPROC) (GLenum name, GLuint index);
extern void glDrawArraysInstanced (GLenum mode, GLint first, GLsizei count, GLsizei instancecount) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawElementsInstanced (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexBuffer (GLenum target, GLenum internalformat, GLuint buffer) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPrimitiveRestartIndex (GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);
typedef void ( * PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index);
extern void glGetInteger64i_v (GLenum target, GLuint index, GLint64 *data) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetBufferParameteri64v (GLenum target, GLenum pname, GLint64 *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferTexture (GLenum target, GLenum attachment, GLuint texture, GLint level) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data);
typedef void ( * PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
extern void glVertexAttribDivisor (GLuint index, GLuint divisor);

typedef void ( * PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor);
extern void glMinSampleShading (GLfloat value) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendEquationi (GLuint buf, GLenum mode) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendEquationSeparatei (GLuint buf, GLenum modeRGB, GLenum modeAlpha) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendFunci (GLuint buf, GLenum src, GLenum dst) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlendFuncSeparatei (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLMINSAMPLESHADINGPROC) (GLfloat value);
typedef void ( * PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void ( * PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
extern GLboolean glIsRenderbuffer (GLuint renderbuffer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindRenderbuffer (GLenum target, GLuint renderbuffer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteRenderbuffers (GLsizei n, const GLuint *renderbuffers) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenRenderbuffers (GLsizei n, GLuint *renderbuffers) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsFramebuffer (GLuint framebuffer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindFramebuffer (GLenum target, GLuint framebuffer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteFramebuffers (GLsizei n, const GLuint *framebuffers) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenFramebuffers (GLsizei n, GLuint *framebuffers) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLenum glCheckFramebufferStatus (GLenum target) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferTexture1D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferTexture3D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenerateMipmap (GLenum target) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBlitFramebuffer (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glRenderbufferStorageMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glFramebufferTextureLayer (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer) __attribute__((availability(macos,introduced=10.8,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef GLboolean ( * PFNGLISRENDERBUFFERPROC) (GLuint renderbuffer);
typedef void ( * PFNGLBINDRENDERBUFFERPROC) (GLenum target, GLuint renderbuffer);
typedef void ( * PFNGLDELETERENDERBUFFERSPROC) (GLsizei n, const GLuint *renderbuffers);
typedef void ( * PFNGLGENRENDERBUFFERSPROC) (GLsizei n, GLuint *renderbuffers);
typedef void ( * PFNGLRENDERBUFFERSTORAGEPROC) (GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLGETRENDERBUFFERPARAMETERIVPROC) (GLenum target, GLenum pname, GLint *params);
typedef GLboolean ( * PFNGLISFRAMEBUFFERPROC) (GLuint framebuffer);
typedef void ( * PFNGLBINDFRAMEBUFFERPROC) (GLenum target, GLuint framebuffer);
typedef void ( * PFNGLDELETEFRAMEBUFFERSPROC) (GLsizei n, const GLuint *framebuffers);
typedef void ( * PFNGLGENFRAMEBUFFERSPROC) (GLsizei n, GLuint *framebuffers);
typedef GLenum ( * PFNGLCHECKFRAMEBUFFERSTATUSPROC) (GLenum target);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE1DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE2DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void ( * PFNGLFRAMEBUFFERTEXTURE3DPROC) (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void ( * PFNGLFRAMEBUFFERRENDERBUFFERPROC) (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void ( * PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC) (GLenum target, GLenum attachment, GLenum pname, GLint *params);
typedef void ( * PFNGLGENERATEMIPMAPPROC) (GLenum target);
typedef void ( * PFNGLBLITFRAMEBUFFERPROC) (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter);
typedef void ( * PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height);
typedef void ( * PFNGLFRAMEBUFFERTEXTURELAYERPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer);
extern GLvoid* glMapBufferRange (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
extern void glFlushMappedBufferRange (GLenum target, GLintptr offset, GLsizeiptr length);

typedef GLvoid* ( * PFNGLMAPBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length, GLbitfield access);
typedef void ( * PFNGLFLUSHMAPPEDBUFFERRANGEPROC) (GLenum target, GLintptr offset, GLsizeiptr length);
extern void glBindVertexArray (GLuint array) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteVertexArrays (GLsizei n, const GLuint *arrays) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenVertexArrays (GLsizei n, GLuint *arrays) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsVertexArray (GLuint array) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void ( * PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void ( * PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean ( * PFNGLISVERTEXARRAYPROC) (GLuint array);





extern void glGetUniformIndices (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveUniformsiv (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveUniformName (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLuint glGetUniformBlockIndex (GLuint program, const GLchar *uniformBlockName) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveUniformBlockiv (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveUniformBlockName (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformBlockBinding (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLGETUNIFORMINDICESPROC) (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices);
typedef void ( * PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
typedef GLuint ( * PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program, const GLchar *uniformBlockName);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
typedef void ( * PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);





extern void glCopyBufferSubData (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size) __attribute__((availability(macos,introduced=10.5,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
extern void glDrawElementsBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawRangeElementsBaseVertex (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawElementsInstancedBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glMultiDrawElementsBaseVertex (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void ( * PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex);
typedef void ( * PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex);
extern void glProvokingVertex (GLenum mode) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLPROVOKINGVERTEXPROC) (GLenum mode);
extern GLsync glFenceSync (GLenum condition, GLbitfield flags) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsSync (GLsync sync) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteSync (GLsync sync) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLenum glClientWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetInteger64v (GLenum pname, GLint64 *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetSynciv (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef GLsync ( * PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags);
typedef GLboolean ( * PFNGLISSYNCPROC) (GLsync sync);
typedef void ( * PFNGLDELETESYNCPROC) (GLsync sync);
typedef GLenum ( * PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values);





extern void glTexImage2DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glTexImage3DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetMultisamplefv (GLenum pname, GLuint index, GLfloat *val) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSampleMaski (GLuint index, GLbitfield mask) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void ( * PFNGLSAMPLEMASKIPROC) (GLuint index, GLbitfield mask);
extern void glBindFragDataLocationIndexed (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLint glGetFragDataIndex (GLuint program, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATAINDEXPROC) (GLuint program, const GLchar *name);
extern void glGenSamplers (GLsizei count, GLuint *samplers) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteSamplers (GLsizei count, const GLuint *samplers) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsSampler (GLuint sampler) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindSampler (GLuint unit, GLuint sampler) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameteri (GLuint sampler, GLenum pname, GLint param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameteriv (GLuint sampler, GLenum pname, const GLint *param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameterf (GLuint sampler, GLenum pname, GLfloat param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameterfv (GLuint sampler, GLenum pname, const GLfloat *param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameterIiv (GLuint sampler, GLenum pname, const GLint *param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glSamplerParameterIuiv (GLuint sampler, GLenum pname, const GLuint *param) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetSamplerParameteriv (GLuint sampler, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetSamplerParameterIiv (GLuint sampler, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetSamplerParameterfv (GLuint sampler, GLenum pname, GLfloat *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetSamplerParameterIuiv (GLuint sampler, GLenum pname, GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLGENSAMPLERSPROC) (GLsizei count, GLuint *samplers);
typedef void ( * PFNGLDELETESAMPLERSPROC) (GLsizei count, const GLuint *samplers);
typedef GLboolean ( * PFNGLISSAMPLERPROC) (GLuint sampler);
typedef void ( * PFNGLBINDSAMPLERPROC) (GLuint unit, GLuint sampler);
typedef void ( * PFNGLSAMPLERPARAMETERIPROC) (GLuint sampler, GLenum pname, GLint param);
typedef void ( * PFNGLSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void ( * PFNGLSAMPLERPARAMETERFPROC) (GLuint sampler, GLenum pname, GLfloat param);
typedef void ( * PFNGLSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, const GLfloat *param);
typedef void ( * PFNGLSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, const GLint *param);
typedef void ( * PFNGLSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, const GLuint *param);
typedef void ( * PFNGLGETSAMPLERPARAMETERIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERIIVPROC) (GLuint sampler, GLenum pname, GLint *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERFVPROC) (GLuint sampler, GLenum pname, GLfloat *params);
typedef void ( * PFNGLGETSAMPLERPARAMETERIUIVPROC) (GLuint sampler, GLenum pname, GLuint *params);
extern void glQueryCounter (GLuint id, GLenum target) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryObjecti64v (GLuint id, GLenum pname, GLint64 *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryObjectui64v (GLuint id, GLenum pname, GLuint64 *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target);
typedef void ( * PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params);





extern void glVertexAttribP1ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP1uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP2ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP2uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP3ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP3uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP4ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribP4uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);





extern void glDrawArraysIndirect (GLenum mode, const GLvoid *indirect) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawElementsIndirect (GLenum mode, GLenum type, const GLvoid *indirect) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const GLvoid *indirect);
typedef void ( * PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const GLvoid *indirect);
extern void glUniform1d (GLint location, GLdouble x) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2d (GLint location, GLdouble x, GLdouble y) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3d (GLint location, GLdouble x, GLdouble y, GLdouble z) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4d (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform1dv (GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform2dv (GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform3dv (GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniform4dv (GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix2x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix2x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix3x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformMatrix4x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetUniformdv (GLuint program, GLint location, GLdouble *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLUNIFORM1DPROC) (GLint location, GLdouble x);
typedef void ( * PFNGLUNIFORM2DPROC) (GLint location, GLdouble x, GLdouble y);
typedef void ( * PFNGLUNIFORM3DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLUNIFORM4DPROC) (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLUNIFORM1DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM2DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM3DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORM4DVPROC) (GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX2X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX3X4DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4X2DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLUNIFORMMATRIX4X3DVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLGETUNIFORMDVPROC) (GLuint program, GLint location, GLdouble *params);





extern GLint glGetSubroutineUniformLocation (GLuint program, GLenum shadertype, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLuint glGetSubroutineIndex (GLuint program, GLenum shadertype, const GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveSubroutineUniformiv (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveSubroutineUniformName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetActiveSubroutineName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glUniformSubroutinesuiv (GLenum shadertype, GLsizei count, const GLuint *indices) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetUniformSubroutineuiv (GLenum shadertype, GLint location, GLuint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetProgramStageiv (GLuint program, GLenum shadertype, GLenum pname, GLint *values) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef GLint ( * PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef GLuint ( * PFNGLGETSUBROUTINEINDEXPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices);
typedef void ( * PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params);
typedef void ( * PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program, GLenum shadertype, GLenum pname, GLint *values);





extern void glPatchParameteri (GLenum pname, GLint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPatchParameterfv (GLenum pname, const GLfloat *values) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value);
typedef void ( * PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values);
extern void glBindTransformFeedback (GLenum target, GLuint id) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteTransformFeedbacks (GLsizei n, const GLuint *ids) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenTransformFeedbacks (GLsizei n, GLuint *ids) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsTransformFeedback (GLuint id) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glPauseTransformFeedback (void) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glResumeTransformFeedback (void) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDrawTransformFeedback (GLenum mode, GLuint id) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids);
typedef void ( * PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef GLboolean ( * PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id);
typedef void ( * PFNGLPAUSETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLRESUMETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id);





extern void glDrawTransformFeedbackStream (GLenum mode, GLuint id, GLuint stream) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBeginQueryIndexed (GLenum target, GLuint index, GLuint id) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glEndQueryIndexed (GLenum target, GLuint index) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetQueryIndexediv (GLenum target, GLuint index, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream);
typedef void ( * PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id);
typedef void ( * PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);





extern void glReleaseShaderCompiler (void) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glShaderBinary (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthRangef (GLclampf n, GLclampf f) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glClearDepthf (GLclampf d) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLRELEASESHADERCOMPILERPROC) (void);
typedef void ( * PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length);
typedef void ( * PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
typedef void ( * PFNGLDEPTHRANGEFPROC) (GLclampf n, GLclampf f);
typedef void ( * PFNGLCLEARDEPTHFPROC) (GLclampf d);





extern void glGetProgramBinary (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramBinary (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramParameteri (GLuint program, GLenum pname, GLint value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLGETPROGRAMBINARYPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary);
typedef void ( * PFNGLPROGRAMBINARYPROC) (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length);
typedef void ( * PFNGLPROGRAMPARAMETERIPROC) (GLuint program, GLenum pname, GLint value);





extern void glUseProgramStages (GLuint pipeline, GLbitfield stages, GLuint program) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glActiveShaderProgram (GLuint pipeline, GLuint program) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLuint glCreateShaderProgramv (GLenum type, GLsizei count, const GLchar* const *strings) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glBindProgramPipeline (GLuint pipeline) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDeleteProgramPipelines (GLsizei n, const GLuint *pipelines) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGenProgramPipelines (GLsizei n, GLuint *pipelines) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern GLboolean glIsProgramPipeline (GLuint pipeline) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetProgramPipelineiv (GLuint pipeline, GLenum pname, GLint *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1i (GLuint program, GLint location, GLint v0) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1iv (GLuint program, GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1f (GLuint program, GLint location, GLfloat v0) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1d (GLuint program, GLint location, GLdouble v0) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1ui (GLuint program, GLint location, GLuint v0) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform1uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2i (GLuint program, GLint location, GLint v0, GLint v1) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2iv (GLuint program, GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2f (GLuint program, GLint location, GLfloat v0, GLfloat v1) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2d (GLuint program, GLint location, GLdouble v0, GLdouble v1) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2ui (GLuint program, GLint location, GLuint v0, GLuint v1) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform2uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3iv (GLuint program, GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform3uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4iv (GLuint program, GLint location, GLsizei count, const GLint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniform4uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix2x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix3x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glProgramUniformMatrix4x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glValidateProgramPipeline (GLuint pipeline) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetProgramPipelineInfoLog (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLUSEPROGRAMSTAGESPROC) (GLuint pipeline, GLbitfield stages, GLuint program);
typedef void ( * PFNGLACTIVESHADERPROGRAMPROC) (GLuint pipeline, GLuint program);
typedef GLuint ( * PFNGLCREATESHADERPROGRAMVPROC) (GLenum type, GLsizei count, const GLchar* const *strings);
typedef void ( * PFNGLBINDPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLDELETEPROGRAMPIPELINESPROC) (GLsizei n, const GLuint *pipelines);
typedef void ( * PFNGLGENPROGRAMPIPELINESPROC) (GLsizei n, GLuint *pipelines);
typedef GLboolean ( * PFNGLISPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLGETPROGRAMPIPELINEIVPROC) (GLuint pipeline, GLenum pname, GLint *params);
typedef void ( * PFNGLPROGRAMUNIFORM1IPROC) (GLuint program, GLint location, GLint v0);
typedef void ( * PFNGLPROGRAMUNIFORM1IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM1FPROC) (GLuint program, GLint location, GLfloat v0);
typedef void ( * PFNGLPROGRAMUNIFORM1FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM1DPROC) (GLuint program, GLint location, GLdouble v0);
typedef void ( * PFNGLPROGRAMUNIFORM1DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM1UIPROC) (GLuint program, GLint location, GLuint v0);
typedef void ( * PFNGLPROGRAMUNIFORM1UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2IPROC) (GLuint program, GLint location, GLint v0, GLint v1);
typedef void ( * PFNGLPROGRAMUNIFORM2IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM2FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1);
typedef void ( * PFNGLPROGRAMUNIFORM2FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM2DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1);
typedef void ( * PFNGLPROGRAMUNIFORM2DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM2UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1);
typedef void ( * PFNGLPROGRAMUNIFORM2UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2);
typedef void ( * PFNGLPROGRAMUNIFORM3IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM3FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void ( * PFNGLPROGRAMUNIFORM3FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM3DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2);
typedef void ( * PFNGLPROGRAMUNIFORM3DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM3UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2);
typedef void ( * PFNGLPROGRAMUNIFORM3UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4IPROC) (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void ( * PFNGLPROGRAMUNIFORM4IVPROC) (GLuint program, GLint location, GLsizei count, const GLint *value);
typedef void ( * PFNGLPROGRAMUNIFORM4FPROC) (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void ( * PFNGLPROGRAMUNIFORM4FVPROC) (GLuint program, GLint location, GLsizei count, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORM4DPROC) (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3);
typedef void ( * PFNGLPROGRAMUNIFORM4DVPROC) (GLuint program, GLint location, GLsizei count, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORM4UIPROC) (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3);
typedef void ( * PFNGLPROGRAMUNIFORM4UIVPROC) (GLuint program, GLint location, GLsizei count, const GLuint *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX2X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X2DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX3X4DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLPROGRAMUNIFORMMATRIX4X3DVPROC) (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value);
typedef void ( * PFNGLVALIDATEPROGRAMPIPELINEPROC) (GLuint pipeline);
typedef void ( * PFNGLGETPROGRAMPIPELINEINFOLOGPROC) (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
extern void glVertexAttribL1d (GLuint index, GLdouble x) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL2d (GLuint index, GLdouble x, GLdouble y) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL3d (GLuint index, GLdouble x, GLdouble y, GLdouble z) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL1dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL2dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL3dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribL4dv (GLuint index, const GLdouble *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glVertexAttribLPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetVertexAttribLdv (GLuint index, GLenum pname, GLdouble *params) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLVERTEXATTRIBL1DPROC) (GLuint index, GLdouble x);
typedef void ( * PFNGLVERTEXATTRIBL2DPROC) (GLuint index, GLdouble x, GLdouble y);
typedef void ( * PFNGLVERTEXATTRIBL3DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z);
typedef void ( * PFNGLVERTEXATTRIBL4DPROC) (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w);
typedef void ( * PFNGLVERTEXATTRIBL1DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL2DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL3DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBL4DVPROC) (GLuint index, const GLdouble *v);
typedef void ( * PFNGLVERTEXATTRIBLPOINTERPROC) (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer);
typedef void ( * PFNGLGETVERTEXATTRIBLDVPROC) (GLuint index, GLenum pname, GLdouble *params);





extern void glViewportArrayv (GLuint first, GLsizei count, const GLfloat *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glViewportIndexedf (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glViewportIndexedfv (GLuint index, const GLfloat *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glScissorArrayv (GLuint first, GLsizei count, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glScissorIndexed (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glScissorIndexedv (GLuint index, const GLint *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthRangeArrayv (GLuint first, GLsizei count, const GLclampd *v) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glDepthRangeIndexed (GLuint index, GLclampd n, GLclampd f) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetFloati_v (GLenum target, GLuint index, GLfloat *data) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));
extern void glGetDoublei_v (GLenum target, GLuint index, GLdouble *data) __attribute__((availability(macos,introduced=10.7,deprecated=10.14,message="OpenGL API deprecated. (Define GL_SILENCE_DEPRECATION to silence these warnings)")));

typedef void ( * PFNGLVIEWPORTARRAYVPROC) (GLuint first, GLsizei count, const GLfloat *v);
typedef void ( * PFNGLVIEWPORTINDEXEDFPROC) (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h);
typedef void ( * PFNGLVIEWPORTINDEXEDFVPROC) (GLuint index, const GLfloat *v);
typedef void ( * PFNGLSCISSORARRAYVPROC) (GLuint first, GLsizei count, const GLint *v);
typedef void ( * PFNGLSCISSORINDEXEDPROC) (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height);
typedef void ( * PFNGLSCISSORINDEXEDVPROC) (GLuint index, const GLint *v);
typedef void ( * PFNGLDEPTHRANGEARRAYVPROC) (GLuint first, GLsizei count, const GLclampd *v);
typedef void ( * PFNGLDEPTHRANGEINDEXEDPROC) (GLuint index, GLclampd n, GLclampd f);
typedef void ( * PFNGLGETFLOATI_VPROC) (GLenum target, GLuint index, GLfloat *data);
typedef void ( * PFNGLGETDOUBLEI_VPROC) (GLenum target, GLuint index, GLdouble *data);

