





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



extern void glCullFace (GLenum mode) ;
extern void glFrontFace (GLenum mode) ;
extern void glHint (GLenum target, GLenum mode) ;
extern void glLineWidth (GLfloat width) ;
extern void glPointSize (GLfloat size) ;
extern void glPolygonMode (GLenum face, GLenum mode) ;
extern void glScissor (GLint x, GLint y, GLsizei width, GLsizei height) ;
extern void glTexParameterf (GLenum target, GLenum pname, GLfloat param) ;
extern void glTexParameterfv (GLenum target, GLenum pname, const GLfloat *params) ;
extern void glTexParameteri (GLenum target, GLenum pname, GLint param) ;
extern void glTexParameteriv (GLenum target, GLenum pname, const GLint *params) ;
extern void glTexImage1D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glTexImage2D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glDrawBuffer (GLenum mode) ;
extern void glClear (GLbitfield mask) ;
extern void glClearColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) ;
extern void glClearStencil (GLint s) ;
extern void glClearDepth (GLclampd depth) ;
extern void glStencilMask (GLuint mask) ;
extern void glColorMask (GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha) ;
extern void glDepthMask (GLboolean flag) ;
extern void glDisable (GLenum cap) ;
extern void glEnable (GLenum cap) ;
extern void glFinish (void) ;
extern void glFlush (void) ;
extern void glBlendFunc (GLenum sfactor, GLenum dfactor) ;
extern void glLogicOp (GLenum opcode) ;
extern void glStencilFunc (GLenum func, GLint ref, GLuint mask) ;
extern void glStencilOp (GLenum fail, GLenum zfail, GLenum zpass) ;
extern void glDepthFunc (GLenum func) ;
extern void glPixelStoref (GLenum pname, GLfloat param) ;
extern void glPixelStorei (GLenum pname, GLint param) ;
extern void glReadBuffer (GLenum mode) ;
extern void glReadPixels (GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels) ;
extern void glGetBooleanv (GLenum pname, GLboolean *params) ;
extern void glGetDoublev (GLenum pname, GLdouble *params) ;
extern GLenum glGetError (void) ;
extern void glGetFloatv (GLenum pname, GLfloat *params) ;
extern void glGetIntegerv (GLenum pname, GLint *params) ;
extern const GLubyte * glGetString (GLenum name) ;
extern void glGetTexImage (GLenum target, GLint level, GLenum format, GLenum type, GLvoid *pixels) ;
extern void glGetTexParameterfv (GLenum target, GLenum pname, GLfloat *params) ;
extern void glGetTexParameteriv (GLenum target, GLenum pname, GLint *params) ;
extern void glGetTexLevelParameterfv (GLenum target, GLint level, GLenum pname, GLfloat *params) ;
extern void glGetTexLevelParameteriv (GLenum target, GLint level, GLenum pname, GLint *params) ;
extern GLboolean glIsEnabled (GLenum cap) ;
extern void glDepthRange (GLclampd near, GLclampd far) ;
extern void glViewport (GLint x, GLint y, GLsizei width, GLsizei height) ;

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





extern void glDrawArrays (GLenum mode, GLint first, GLsizei count) ;
extern void glDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices) ;
extern void glPolygonOffset (GLfloat factor, GLfloat units) ;
extern void glCopyTexImage1D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLint border) ;
extern void glCopyTexImage2D (GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border) ;
extern void glCopyTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width) ;
extern void glCopyTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height) ;
extern void glTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glBindTexture (GLenum target, GLuint texture) ;
extern void glDeleteTextures (GLsizei n, const GLuint *textures) ;
extern void glGenTextures (GLsizei n, GLuint *textures) ;
extern GLboolean glIsTexture (GLuint texture) ;

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





extern void glBlendColor (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha) ;
extern void glBlendEquation (GLenum mode) ;
extern void glDrawRangeElements (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices) ;
extern void glTexImage3D (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels) ;
extern void glCopyTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height) ;

typedef void ( * PFNGLBLENDCOLORPROC) (GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void ( * PFNGLBLENDEQUATIONPROC) (GLenum mode);
typedef void ( * PFNGLDRAWRANGEELEMENTSPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices);
typedef void ( * PFNGLTEXIMAGE3DPROC) (GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLenum type, const GLvoid *pixels);
typedef void ( * PFNGLCOPYTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLint x, GLint y, GLsizei width, GLsizei height);





extern void glActiveTexture (GLenum texture) ;
extern void glSampleCoverage (GLclampf value, GLboolean invert) ;
extern void glCompressedTexImage3D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data) ;
extern void glCompressedTexImage2D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data) ;
extern void glCompressedTexImage1D (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data) ;
extern void glCompressedTexSubImage3D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data) ;
extern void glCompressedTexSubImage2D (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data) ;
extern void glCompressedTexSubImage1D (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data) ;
extern void glGetCompressedTexImage (GLenum target, GLint level, GLvoid *img) ;

typedef void ( * PFNGLACTIVETEXTUREPROC) (GLenum texture);
typedef void ( * PFNGLSAMPLECOVERAGEPROC) (GLclampf value, GLboolean invert);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE3DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLsizei depth, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE2DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLsizei height, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXIMAGE1DPROC) (GLenum target, GLint level, GLenum internalformat, GLsizei width, GLint border, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint zoffset, GLsizei width, GLsizei height, GLsizei depth, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC) (GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLCOMPRESSEDTEXSUBIMAGE1DPROC) (GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLsizei imageSize, const GLvoid *data);
typedef void ( * PFNGLGETCOMPRESSEDTEXIMAGEPROC) (GLenum target, GLint level, GLvoid *img);





extern void glBlendFuncSeparate (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha) ;
extern void glMultiDrawArrays (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount) ;
extern void glMultiDrawElements (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount) ;
extern void glPointParameterf (GLenum pname, GLfloat param) ;
extern void glPointParameterfv (GLenum pname, const GLfloat *params) ;
extern void glPointParameteri (GLenum pname, GLint param) ;
extern void glPointParameteriv (GLenum pname, const GLint *params) ;

typedef void ( * PFNGLBLENDFUNCSEPARATEPROC) (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);
typedef void ( * PFNGLMULTIDRAWARRAYSPROC) (GLenum mode, const GLint *first, const GLsizei *count, GLsizei drawcount);
typedef void ( * PFNGLMULTIDRAWELEMENTSPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount);
typedef void ( * PFNGLPOINTPARAMETERFPROC) (GLenum pname, GLfloat param);
typedef void ( * PFNGLPOINTPARAMETERFVPROC) (GLenum pname, const GLfloat *params);
typedef void ( * PFNGLPOINTPARAMETERIPROC) (GLenum pname, GLint param);
typedef void ( * PFNGLPOINTPARAMETERIVPROC) (GLenum pname, const GLint *params);





extern void glGenQueries (GLsizei n, GLuint *ids) ;
extern void glDeleteQueries (GLsizei n, const GLuint *ids) ;
extern GLboolean glIsQuery (GLuint id) ;
extern void glBeginQuery (GLenum target, GLuint id) ;
extern void glEndQuery (GLenum target) ;
extern void glGetQueryiv (GLenum target, GLenum pname, GLint *params) ;
extern void glGetQueryObjectiv (GLuint id, GLenum pname, GLint *params) ;
extern void glGetQueryObjectuiv (GLuint id, GLenum pname, GLuint *params) ;
extern void glBindBuffer (GLenum target, GLuint buffer) ;
extern void glDeleteBuffers (GLsizei n, const GLuint *buffers) ;
extern void glGenBuffers (GLsizei n, GLuint *buffers) ;
extern GLboolean glIsBuffer (GLuint buffer) ;
extern void glBufferData (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage) ;
extern void glBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data) ;
extern void glGetBufferSubData (GLenum target, GLintptr offset, GLsizeiptr size, GLvoid *data) ;
extern GLvoid* glMapBuffer (GLenum target, GLenum access) ;
extern GLboolean glUnmapBuffer (GLenum target) ;
extern void glGetBufferParameteriv (GLenum target, GLenum pname, GLint *params) ;
extern void glGetBufferPointerv (GLenum target, GLenum pname, GLvoid* *params) ;

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





extern void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha) ;
extern void glDrawBuffers (GLsizei n, const GLenum *bufs) ;
extern void glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass) ;
extern void glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask) ;
extern void glStencilMaskSeparate (GLenum face, GLuint mask) ;
extern void glAttachShader (GLuint program, GLuint shader) ;
extern void glBindAttribLocation (GLuint program, GLuint index, const GLchar *name) ;
extern void glCompileShader (GLuint shader) ;
extern GLuint glCreateProgram (void) ;
extern GLuint glCreateShader (GLenum type) ;
extern void glDeleteProgram (GLuint program) ;
extern void glDeleteShader (GLuint shader) ;
extern void glDetachShader (GLuint program, GLuint shader) ;
extern void glDisableVertexAttribArray (GLuint index) ;
extern void glEnableVertexAttribArray (GLuint index) ;
extern void glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name) ;
extern void glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name) ;
extern void glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders) ;
extern GLint glGetAttribLocation (GLuint program, const GLchar *name) ;
extern void glGetProgramiv (GLuint program, GLenum pname, GLint *params) ;
extern void glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog) ;
extern void glGetShaderiv (GLuint shader, GLenum pname, GLint *params) ;
extern void glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog) ;
extern void glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source) ;
extern GLint glGetUniformLocation (GLuint program, const GLchar *name) ;
extern void glGetUniformfv (GLuint program, GLint location, GLfloat *params) ;
extern void glGetUniformiv (GLuint program, GLint location, GLint *params) ;
extern void glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params) ;
extern void glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params) ;
extern void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params) ;
extern void glGetVertexAttribPointerv (GLuint index, GLenum pname, GLvoid* *pointer) ;
extern GLboolean glIsProgram (GLuint program) ;
extern GLboolean glIsShader (GLuint shader) ;
extern void glLinkProgram (GLuint program) ;
extern void glShaderSource (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length) ;
extern void glUseProgram (GLuint program) ;
extern void glUniform1f (GLint location, GLfloat v0) ;
extern void glUniform2f (GLint location, GLfloat v0, GLfloat v1) ;
extern void glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2) ;
extern void glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3) ;
extern void glUniform1i (GLint location, GLint v0) ;
extern void glUniform2i (GLint location, GLint v0, GLint v1) ;
extern void glUniform3i (GLint location, GLint v0, GLint v1, GLint v2) ;
extern void glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3) ;
extern void glUniform1fv (GLint location, GLsizei count, const GLfloat *value) ;
extern void glUniform2fv (GLint location, GLsizei count, const GLfloat *value) ;
extern void glUniform3fv (GLint location, GLsizei count, const GLfloat *value) ;
extern void glUniform4fv (GLint location, GLsizei count, const GLfloat *value) ;
extern void glUniform1iv (GLint location, GLsizei count, const GLint *value) ;
extern void glUniform2iv (GLint location, GLsizei count, const GLint *value) ;
extern void glUniform3iv (GLint location, GLsizei count, const GLint *value) ;
extern void glUniform4iv (GLint location, GLsizei count, const GLint *value) ;
extern void glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glValidateProgram (GLuint program) ;
extern void glVertexAttrib1d (GLuint index, GLdouble x) ;
extern void glVertexAttrib1dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttrib1f (GLuint index, GLfloat x) ;
extern void glVertexAttrib1fv (GLuint index, const GLfloat *v) ;
extern void glVertexAttrib1s (GLuint index, GLshort x) ;
extern void glVertexAttrib1sv (GLuint index, const GLshort *v) ;
extern void glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y) ;
extern void glVertexAttrib2dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y) ;
extern void glVertexAttrib2fv (GLuint index, const GLfloat *v) ;
extern void glVertexAttrib2s (GLuint index, GLshort x, GLshort y) ;
extern void glVertexAttrib2sv (GLuint index, const GLshort *v) ;
extern void glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z) ;
extern void glVertexAttrib3dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z) ;
extern void glVertexAttrib3fv (GLuint index, const GLfloat *v) ;
extern void glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z) ;
extern void glVertexAttrib3sv (GLuint index, const GLshort *v) ;
extern void glVertexAttrib4Nbv (GLuint index, const GLbyte *v) ;
extern void glVertexAttrib4Niv (GLuint index, const GLint *v) ;
extern void glVertexAttrib4Nsv (GLuint index, const GLshort *v) ;
extern void glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w) ;
extern void glVertexAttrib4Nubv (GLuint index, const GLubyte *v) ;
extern void glVertexAttrib4Nuiv (GLuint index, const GLuint *v) ;
extern void glVertexAttrib4Nusv (GLuint index, const GLushort *v) ;
extern void glVertexAttrib4bv (GLuint index, const GLbyte *v) ;
extern void glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w) ;
extern void glVertexAttrib4dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w) ;
extern void glVertexAttrib4fv (GLuint index, const GLfloat *v) ;
extern void glVertexAttrib4iv (GLuint index, const GLint *v) ;
extern void glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w) ;
extern void glVertexAttrib4sv (GLuint index, const GLshort *v) ;
extern void glVertexAttrib4ubv (GLuint index, const GLubyte *v) ;
extern void glVertexAttrib4uiv (GLuint index, const GLuint *v) ;
extern void glVertexAttrib4usv (GLuint index, const GLushort *v) ;
extern void glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer) ;

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





extern void glUniformMatrix2x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix3x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix2x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix4x2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix3x4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glUniformMatrix4x3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;

typedef void ( * PFNGLUNIFORMMATRIX2X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX2X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X2FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX3X4FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void ( * PFNGLUNIFORMMATRIX4X3FVPROC) (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
extern void glColorMaski (GLuint index, GLboolean r, GLboolean g, GLboolean b, GLboolean a) ;
extern void glGetBooleani_v (GLenum target, GLuint index, GLboolean *data) ;
extern void glGetIntegeri_v (GLenum target, GLuint index, GLint *data) ;
extern void glEnablei (GLenum target, GLuint index) ;
extern void glDisablei (GLenum target, GLuint index) ;
extern GLboolean glIsEnabledi (GLenum target, GLuint index) ;
extern void glBeginTransformFeedback (GLenum primitiveMode) ;
extern void glEndTransformFeedback (void) ;
extern void glBindBufferRange (GLenum target, GLuint index, GLuint buffer, GLintptr offset, GLsizeiptr size) ;
extern void glBindBufferBase (GLenum target, GLuint index, GLuint buffer) ;
extern void glTransformFeedbackVaryings (GLuint program, GLsizei count, const GLchar* const *varyings, GLenum bufferMode) ;
extern void glGetTransformFeedbackVarying (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLsizei *size, GLenum *type, GLchar *name) ;
extern void glClampColor (GLenum target, GLenum clamp) ;
extern void glBeginConditionalRender (GLuint id, GLenum mode) ;
extern void glEndConditionalRender (void) ;
extern void glVertexAttribIPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer) ;
extern void glGetVertexAttribIiv (GLuint index, GLenum pname, GLint *params) ;
extern void glGetVertexAttribIuiv (GLuint index, GLenum pname, GLuint *params) ;
extern void glVertexAttribI1i (GLuint index, GLint x) ;
extern void glVertexAttribI2i (GLuint index, GLint x, GLint y) ;
extern void glVertexAttribI3i (GLuint index, GLint x, GLint y, GLint z) ;
extern void glVertexAttribI4i (GLuint index, GLint x, GLint y, GLint z, GLint w) ;
extern void glVertexAttribI1ui (GLuint index, GLuint x) ;
extern void glVertexAttribI2ui (GLuint index, GLuint x, GLuint y) ;
extern void glVertexAttribI3ui (GLuint index, GLuint x, GLuint y, GLuint z) ;
extern void glVertexAttribI4ui (GLuint index, GLuint x, GLuint y, GLuint z, GLuint w) ;
extern void glVertexAttribI1iv (GLuint index, const GLint *v) ;
extern void glVertexAttribI2iv (GLuint index, const GLint *v) ;
extern void glVertexAttribI3iv (GLuint index, const GLint *v) ;
extern void glVertexAttribI4iv (GLuint index, const GLint *v) ;
extern void glVertexAttribI1uiv (GLuint index, const GLuint *v) ;
extern void glVertexAttribI2uiv (GLuint index, const GLuint *v) ;
extern void glVertexAttribI3uiv (GLuint index, const GLuint *v) ;
extern void glVertexAttribI4uiv (GLuint index, const GLuint *v) ;
extern void glVertexAttribI4bv (GLuint index, const GLbyte *v) ;
extern void glVertexAttribI4sv (GLuint index, const GLshort *v) ;
extern void glVertexAttribI4ubv (GLuint index, const GLubyte *v) ;
extern void glVertexAttribI4usv (GLuint index, const GLushort *v) ;
extern void glGetUniformuiv (GLuint program, GLint location, GLuint *params) ;
extern void glBindFragDataLocation (GLuint program, GLuint color, const GLchar *name) ;
extern GLint glGetFragDataLocation (GLuint program, const GLchar *name) ;
extern void glUniform1ui (GLint location, GLuint v0) ;
extern void glUniform2ui (GLint location, GLuint v0, GLuint v1) ;
extern void glUniform3ui (GLint location, GLuint v0, GLuint v1, GLuint v2) ;
extern void glUniform4ui (GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3) ;
extern void glUniform1uiv (GLint location, GLsizei count, const GLuint *value) ;
extern void glUniform2uiv (GLint location, GLsizei count, const GLuint *value) ;
extern void glUniform3uiv (GLint location, GLsizei count, const GLuint *value) ;
extern void glUniform4uiv (GLint location, GLsizei count, const GLuint *value) ;
extern void glTexParameterIiv (GLenum target, GLenum pname, const GLint *params) ;
extern void glTexParameterIuiv (GLenum target, GLenum pname, const GLuint *params) ;
extern void glGetTexParameterIiv (GLenum target, GLenum pname, GLint *params) ;
extern void glGetTexParameterIuiv (GLenum target, GLenum pname, GLuint *params) ;
extern void glClearBufferiv (GLenum buffer, GLint drawbuffer, const GLint *value) ;
extern void glClearBufferuiv (GLenum buffer, GLint drawbuffer, const GLuint *value) ;
extern void glClearBufferfv (GLenum buffer, GLint drawbuffer, const GLfloat *value) ;
extern void glClearBufferfi (GLenum buffer, GLint drawbuffer, GLfloat depth, GLint stencil) ;
extern const GLubyte * glGetStringi (GLenum name, GLuint index) ;

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
extern void glDrawArraysInstanced (GLenum mode, GLint first, GLsizei count, GLsizei instancecount) ;
extern void glDrawElementsInstanced (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount) ;
extern void glTexBuffer (GLenum target, GLenum internalformat, GLuint buffer) ;
extern void glPrimitiveRestartIndex (GLuint index) ;

typedef void ( * PFNGLDRAWARRAYSINSTANCEDPROC) (GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);
typedef void ( * PFNGLTEXBUFFERPROC) (GLenum target, GLenum internalformat, GLuint buffer);
typedef void ( * PFNGLPRIMITIVERESTARTINDEXPROC) (GLuint index);
extern void glGetInteger64i_v (GLenum target, GLuint index, GLint64 *data) ;
extern void glGetBufferParameteri64v (GLenum target, GLenum pname, GLint64 *params) ;
extern void glFramebufferTexture (GLenum target, GLenum attachment, GLuint texture, GLint level) ;

typedef void ( * PFNGLGETINTEGER64I_VPROC) (GLenum target, GLuint index, GLint64 *data);
typedef void ( * PFNGLGETBUFFERPARAMETERI64VPROC) (GLenum target, GLenum pname, GLint64 *params);
typedef void ( * PFNGLFRAMEBUFFERTEXTUREPROC) (GLenum target, GLenum attachment, GLuint texture, GLint level);
extern void glVertexAttribDivisor (GLuint index, GLuint divisor);

typedef void ( * PFNGLVERTEXATTRIBDIVISORPROC) (GLuint index, GLuint divisor);
extern void glMinSampleShading (GLfloat value) ;
extern void glBlendEquationi (GLuint buf, GLenum mode) ;
extern void glBlendEquationSeparatei (GLuint buf, GLenum modeRGB, GLenum modeAlpha) ;
extern void glBlendFunci (GLuint buf, GLenum src, GLenum dst) ;
extern void glBlendFuncSeparatei (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha) ;

typedef void ( * PFNGLMINSAMPLESHADINGPROC) (GLfloat value);
typedef void ( * PFNGLBLENDEQUATIONIPROC) (GLuint buf, GLenum mode);
typedef void ( * PFNGLBLENDEQUATIONSEPARATEIPROC) (GLuint buf, GLenum modeRGB, GLenum modeAlpha);
typedef void ( * PFNGLBLENDFUNCIPROC) (GLuint buf, GLenum src, GLenum dst);
typedef void ( * PFNGLBLENDFUNCSEPARATEIPROC) (GLuint buf, GLenum srcRGB, GLenum dstRGB, GLenum srcAlpha, GLenum dstAlpha);
extern GLboolean glIsRenderbuffer (GLuint renderbuffer) ;
extern void glBindRenderbuffer (GLenum target, GLuint renderbuffer) ;
extern void glDeleteRenderbuffers (GLsizei n, const GLuint *renderbuffers) ;
extern void glGenRenderbuffers (GLsizei n, GLuint *renderbuffers) ;
extern void glRenderbufferStorage (GLenum target, GLenum internalformat, GLsizei width, GLsizei height) ;
extern void glGetRenderbufferParameteriv (GLenum target, GLenum pname, GLint *params) ;
extern GLboolean glIsFramebuffer (GLuint framebuffer) ;
extern void glBindFramebuffer (GLenum target, GLuint framebuffer) ;
extern void glDeleteFramebuffers (GLsizei n, const GLuint *framebuffers) ;
extern void glGenFramebuffers (GLsizei n, GLuint *framebuffers) ;
extern GLenum glCheckFramebufferStatus (GLenum target) ;
extern void glFramebufferTexture1D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level) ;
extern void glFramebufferTexture2D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level) ;
extern void glFramebufferTexture3D (GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset) ;
extern void glFramebufferRenderbuffer (GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer) ;
extern void glGetFramebufferAttachmentParameteriv (GLenum target, GLenum attachment, GLenum pname, GLint *params) ;
extern void glGenerateMipmap (GLenum target) ;
extern void glBlitFramebuffer (GLint srcX0, GLint srcY0, GLint srcX1, GLint srcY1, GLint dstX0, GLint dstY0, GLint dstX1, GLint dstY1, GLbitfield mask, GLenum filter) ;
extern void glRenderbufferStorageMultisample (GLenum target, GLsizei samples, GLenum internalformat, GLsizei width, GLsizei height) ;
extern void glFramebufferTextureLayer (GLenum target, GLenum attachment, GLuint texture, GLint level, GLint layer) ;

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
extern void glBindVertexArray (GLuint array) ;
extern void glDeleteVertexArrays (GLsizei n, const GLuint *arrays) ;
extern void glGenVertexArrays (GLsizei n, GLuint *arrays) ;
extern GLboolean glIsVertexArray (GLuint array) ;

typedef void ( * PFNGLBINDVERTEXARRAYPROC) (GLuint array);
typedef void ( * PFNGLDELETEVERTEXARRAYSPROC) (GLsizei n, const GLuint *arrays);
typedef void ( * PFNGLGENVERTEXARRAYSPROC) (GLsizei n, GLuint *arrays);
typedef GLboolean ( * PFNGLISVERTEXARRAYPROC) (GLuint array);





extern void glGetUniformIndices (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices) ;
extern void glGetActiveUniformsiv (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params) ;
extern void glGetActiveUniformName (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName) ;
extern GLuint glGetUniformBlockIndex (GLuint program, const GLchar *uniformBlockName) ;
extern void glGetActiveUniformBlockiv (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params) ;
extern void glGetActiveUniformBlockName (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName) ;
extern void glUniformBlockBinding (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding) ;

typedef void ( * PFNGLGETUNIFORMINDICESPROC) (GLuint program, GLsizei uniformCount, const GLchar* const *uniformNames, GLuint *uniformIndices);
typedef void ( * PFNGLGETACTIVEUNIFORMSIVPROC) (GLuint program, GLsizei uniformCount, const GLuint *uniformIndices, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMNAMEPROC) (GLuint program, GLuint uniformIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformName);
typedef GLuint ( * PFNGLGETUNIFORMBLOCKINDEXPROC) (GLuint program, const GLchar *uniformBlockName);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKIVPROC) (GLuint program, GLuint uniformBlockIndex, GLenum pname, GLint *params);
typedef void ( * PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC) (GLuint program, GLuint uniformBlockIndex, GLsizei bufSize, GLsizei *length, GLchar *uniformBlockName);
typedef void ( * PFNGLUNIFORMBLOCKBINDINGPROC) (GLuint program, GLuint uniformBlockIndex, GLuint uniformBlockBinding);





extern void glCopyBufferSubData (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size) ;

typedef void ( * PFNGLCOPYBUFFERSUBDATAPROC) (GLenum readTarget, GLenum writeTarget, GLintptr readOffset, GLintptr writeOffset, GLsizeiptr size);
extern void glDrawElementsBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex) ;
extern void glDrawRangeElementsBaseVertex (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex) ;
extern void glDrawElementsInstancedBaseVertex (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex) ;
extern void glMultiDrawElementsBaseVertex (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex) ;

typedef void ( * PFNGLDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void ( * PFNGLDRAWRANGEELEMENTSBASEVERTEXPROC) (GLenum mode, GLuint start, GLuint end, GLsizei count, GLenum type, const GLvoid *indices, GLint basevertex);
typedef void ( * PFNGLDRAWELEMENTSINSTANCEDBASEVERTEXPROC) (GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount, GLint basevertex);
typedef void ( * PFNGLMULTIDRAWELEMENTSBASEVERTEXPROC) (GLenum mode, const GLsizei *count, GLenum type, const GLvoid* const *indices, GLsizei drawcount, const GLint *basevertex);
extern void glProvokingVertex (GLenum mode) ;

typedef void ( * PFNGLPROVOKINGVERTEXPROC) (GLenum mode);
extern GLsync glFenceSync (GLenum condition, GLbitfield flags) ;
extern GLboolean glIsSync (GLsync sync) ;
extern void glDeleteSync (GLsync sync) ;
extern GLenum glClientWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout) ;
extern void glWaitSync (GLsync sync, GLbitfield flags, GLuint64 timeout) ;
extern void glGetInteger64v (GLenum pname, GLint64 *params) ;
extern void glGetSynciv (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values) ;

typedef GLsync ( * PFNGLFENCESYNCPROC) (GLenum condition, GLbitfield flags);
typedef GLboolean ( * PFNGLISSYNCPROC) (GLsync sync);
typedef void ( * PFNGLDELETESYNCPROC) (GLsync sync);
typedef GLenum ( * PFNGLCLIENTWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLWAITSYNCPROC) (GLsync sync, GLbitfield flags, GLuint64 timeout);
typedef void ( * PFNGLGETINTEGER64VPROC) (GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETSYNCIVPROC) (GLsync sync, GLenum pname, GLsizei bufSize, GLsizei *length, GLint *values);





extern void glTexImage2DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations) ;
extern void glTexImage3DMultisample (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations) ;
extern void glGetMultisamplefv (GLenum pname, GLuint index, GLfloat *val) ;
extern void glSampleMaski (GLuint index, GLbitfield mask) ;

typedef void ( * PFNGLTEXIMAGE2DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLboolean fixedsamplelocations);
typedef void ( * PFNGLTEXIMAGE3DMULTISAMPLEPROC) (GLenum target, GLsizei samples, GLint internalformat, GLsizei width, GLsizei height, GLsizei depth, GLboolean fixedsamplelocations);
typedef void ( * PFNGLGETMULTISAMPLEFVPROC) (GLenum pname, GLuint index, GLfloat *val);
typedef void ( * PFNGLSAMPLEMASKIPROC) (GLuint index, GLbitfield mask);
extern void glBindFragDataLocationIndexed (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name) ;
extern GLint glGetFragDataIndex (GLuint program, const GLchar *name) ;

typedef void ( * PFNGLBINDFRAGDATALOCATIONINDEXEDPROC) (GLuint program, GLuint colorNumber, GLuint index, const GLchar *name);
typedef GLint ( * PFNGLGETFRAGDATAINDEXPROC) (GLuint program, const GLchar *name);
extern void glGenSamplers (GLsizei count, GLuint *samplers) ;
extern void glDeleteSamplers (GLsizei count, const GLuint *samplers) ;
extern GLboolean glIsSampler (GLuint sampler) ;
extern void glBindSampler (GLuint unit, GLuint sampler) ;
extern void glSamplerParameteri (GLuint sampler, GLenum pname, GLint param) ;
extern void glSamplerParameteriv (GLuint sampler, GLenum pname, const GLint *param) ;
extern void glSamplerParameterf (GLuint sampler, GLenum pname, GLfloat param) ;
extern void glSamplerParameterfv (GLuint sampler, GLenum pname, const GLfloat *param) ;
extern void glSamplerParameterIiv (GLuint sampler, GLenum pname, const GLint *param) ;
extern void glSamplerParameterIuiv (GLuint sampler, GLenum pname, const GLuint *param) ;
extern void glGetSamplerParameteriv (GLuint sampler, GLenum pname, GLint *params) ;
extern void glGetSamplerParameterIiv (GLuint sampler, GLenum pname, GLint *params) ;
extern void glGetSamplerParameterfv (GLuint sampler, GLenum pname, GLfloat *params) ;
extern void glGetSamplerParameterIuiv (GLuint sampler, GLenum pname, GLuint *params) ;

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
extern void glQueryCounter (GLuint id, GLenum target) ;
extern void glGetQueryObjecti64v (GLuint id, GLenum pname, GLint64 *params) ;
extern void glGetQueryObjectui64v (GLuint id, GLenum pname, GLuint64 *params) ;

typedef void ( * PFNGLQUERYCOUNTERPROC) (GLuint id, GLenum target);
typedef void ( * PFNGLGETQUERYOBJECTI64VPROC) (GLuint id, GLenum pname, GLint64 *params);
typedef void ( * PFNGLGETQUERYOBJECTUI64VPROC) (GLuint id, GLenum pname, GLuint64 *params);





extern void glVertexAttribP1ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) ;
extern void glVertexAttribP1uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) ;
extern void glVertexAttribP2ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) ;
extern void glVertexAttribP2uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) ;
extern void glVertexAttribP3ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) ;
extern void glVertexAttribP3uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) ;
extern void glVertexAttribP4ui (GLuint index, GLenum type, GLboolean normalized, GLuint value) ;
extern void glVertexAttribP4uiv (GLuint index, GLenum type, GLboolean normalized, const GLuint *value) ;

typedef void ( * PFNGLVERTEXATTRIBP1UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP1UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP2UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP2UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP3UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP3UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);
typedef void ( * PFNGLVERTEXATTRIBP4UIPROC) (GLuint index, GLenum type, GLboolean normalized, GLuint value);
typedef void ( * PFNGLVERTEXATTRIBP4UIVPROC) (GLuint index, GLenum type, GLboolean normalized, const GLuint *value);





extern void glDrawArraysIndirect (GLenum mode, const GLvoid *indirect) ;
extern void glDrawElementsIndirect (GLenum mode, GLenum type, const GLvoid *indirect) ;

typedef void ( * PFNGLDRAWARRAYSINDIRECTPROC) (GLenum mode, const GLvoid *indirect);
typedef void ( * PFNGLDRAWELEMENTSINDIRECTPROC) (GLenum mode, GLenum type, const GLvoid *indirect);
extern void glUniform1d (GLint location, GLdouble x) ;
extern void glUniform2d (GLint location, GLdouble x, GLdouble y) ;
extern void glUniform3d (GLint location, GLdouble x, GLdouble y, GLdouble z) ;
extern void glUniform4d (GLint location, GLdouble x, GLdouble y, GLdouble z, GLdouble w) ;
extern void glUniform1dv (GLint location, GLsizei count, const GLdouble *value) ;
extern void glUniform2dv (GLint location, GLsizei count, const GLdouble *value) ;
extern void glUniform3dv (GLint location, GLsizei count, const GLdouble *value) ;
extern void glUniform4dv (GLint location, GLsizei count, const GLdouble *value) ;
extern void glUniformMatrix2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix2x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix2x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix3x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix3x4dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix4x2dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glUniformMatrix4x3dv (GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glGetUniformdv (GLuint program, GLint location, GLdouble *params) ;

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





extern GLint glGetSubroutineUniformLocation (GLuint program, GLenum shadertype, const GLchar *name) ;
extern GLuint glGetSubroutineIndex (GLuint program, GLenum shadertype, const GLchar *name) ;
extern void glGetActiveSubroutineUniformiv (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values) ;
extern void glGetActiveSubroutineUniformName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name) ;
extern void glGetActiveSubroutineName (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name) ;
extern void glUniformSubroutinesuiv (GLenum shadertype, GLsizei count, const GLuint *indices) ;
extern void glGetUniformSubroutineuiv (GLenum shadertype, GLint location, GLuint *params) ;
extern void glGetProgramStageiv (GLuint program, GLenum shadertype, GLenum pname, GLint *values) ;

typedef GLint ( * PFNGLGETSUBROUTINEUNIFORMLOCATIONPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef GLuint ( * PFNGLGETSUBROUTINEINDEXPROC) (GLuint program, GLenum shadertype, const GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMIVPROC) (GLuint program, GLenum shadertype, GLuint index, GLenum pname, GLint *values);
typedef void ( * PFNGLGETACTIVESUBROUTINEUNIFORMNAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLGETACTIVESUBROUTINENAMEPROC) (GLuint program, GLenum shadertype, GLuint index, GLsizei bufsize, GLsizei *length, GLchar *name);
typedef void ( * PFNGLUNIFORMSUBROUTINESUIVPROC) (GLenum shadertype, GLsizei count, const GLuint *indices);
typedef void ( * PFNGLGETUNIFORMSUBROUTINEUIVPROC) (GLenum shadertype, GLint location, GLuint *params);
typedef void ( * PFNGLGETPROGRAMSTAGEIVPROC) (GLuint program, GLenum shadertype, GLenum pname, GLint *values);





extern void glPatchParameteri (GLenum pname, GLint value) ;
extern void glPatchParameterfv (GLenum pname, const GLfloat *values) ;

typedef void ( * PFNGLPATCHPARAMETERIPROC) (GLenum pname, GLint value);
typedef void ( * PFNGLPATCHPARAMETERFVPROC) (GLenum pname, const GLfloat *values);
extern void glBindTransformFeedback (GLenum target, GLuint id) ;
extern void glDeleteTransformFeedbacks (GLsizei n, const GLuint *ids) ;
extern void glGenTransformFeedbacks (GLsizei n, GLuint *ids) ;
extern GLboolean glIsTransformFeedback (GLuint id) ;
extern void glPauseTransformFeedback (void) ;
extern void glResumeTransformFeedback (void) ;
extern void glDrawTransformFeedback (GLenum mode, GLuint id) ;

typedef void ( * PFNGLBINDTRANSFORMFEEDBACKPROC) (GLenum target, GLuint id);
typedef void ( * PFNGLDELETETRANSFORMFEEDBACKSPROC) (GLsizei n, const GLuint *ids);
typedef void ( * PFNGLGENTRANSFORMFEEDBACKSPROC) (GLsizei n, GLuint *ids);
typedef GLboolean ( * PFNGLISTRANSFORMFEEDBACKPROC) (GLuint id);
typedef void ( * PFNGLPAUSETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLRESUMETRANSFORMFEEDBACKPROC) (void);
typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKPROC) (GLenum mode, GLuint id);





extern void glDrawTransformFeedbackStream (GLenum mode, GLuint id, GLuint stream) ;
extern void glBeginQueryIndexed (GLenum target, GLuint index, GLuint id) ;
extern void glEndQueryIndexed (GLenum target, GLuint index) ;
extern void glGetQueryIndexediv (GLenum target, GLuint index, GLenum pname, GLint *params) ;

typedef void ( * PFNGLDRAWTRANSFORMFEEDBACKSTREAMPROC) (GLenum mode, GLuint id, GLuint stream);
typedef void ( * PFNGLBEGINQUERYINDEXEDPROC) (GLenum target, GLuint index, GLuint id);
typedef void ( * PFNGLENDQUERYINDEXEDPROC) (GLenum target, GLuint index);
typedef void ( * PFNGLGETQUERYINDEXEDIVPROC) (GLenum target, GLuint index, GLenum pname, GLint *params);





extern void glReleaseShaderCompiler (void) ;
extern void glShaderBinary (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length) ;
extern void glGetShaderPrecisionFormat (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision) ;
extern void glDepthRangef (GLclampf n, GLclampf f) ;
extern void glClearDepthf (GLclampf d) ;

typedef void ( * PFNGLRELEASESHADERCOMPILERPROC) (void);
typedef void ( * PFNGLSHADERBINARYPROC) (GLsizei count, const GLuint *shaders, GLenum binaryformat, const GLvoid *binary, GLsizei length);
typedef void ( * PFNGLGETSHADERPRECISIONFORMATPROC) (GLenum shadertype, GLenum precisiontype, GLint *range, GLint *precision);
typedef void ( * PFNGLDEPTHRANGEFPROC) (GLclampf n, GLclampf f);
typedef void ( * PFNGLCLEARDEPTHFPROC) (GLclampf d);





extern void glGetProgramBinary (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary) ;
extern void glProgramBinary (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length) ;
extern void glProgramParameteri (GLuint program, GLenum pname, GLint value) ;

typedef void ( * PFNGLGETPROGRAMBINARYPROC) (GLuint program, GLsizei bufSize, GLsizei *length, GLenum *binaryFormat, GLvoid *binary);
typedef void ( * PFNGLPROGRAMBINARYPROC) (GLuint program, GLenum binaryFormat, const GLvoid *binary, GLsizei length);
typedef void ( * PFNGLPROGRAMPARAMETERIPROC) (GLuint program, GLenum pname, GLint value);





extern void glUseProgramStages (GLuint pipeline, GLbitfield stages, GLuint program) ;
extern void glActiveShaderProgram (GLuint pipeline, GLuint program) ;
extern GLuint glCreateShaderProgramv (GLenum type, GLsizei count, const GLchar* const *strings) ;
extern void glBindProgramPipeline (GLuint pipeline) ;
extern void glDeleteProgramPipelines (GLsizei n, const GLuint *pipelines) ;
extern void glGenProgramPipelines (GLsizei n, GLuint *pipelines) ;
extern GLboolean glIsProgramPipeline (GLuint pipeline) ;
extern void glGetProgramPipelineiv (GLuint pipeline, GLenum pname, GLint *params) ;
extern void glProgramUniform1i (GLuint program, GLint location, GLint v0) ;
extern void glProgramUniform1iv (GLuint program, GLint location, GLsizei count, const GLint *value) ;
extern void glProgramUniform1f (GLuint program, GLint location, GLfloat v0) ;
extern void glProgramUniform1fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) ;
extern void glProgramUniform1d (GLuint program, GLint location, GLdouble v0) ;
extern void glProgramUniform1dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) ;
extern void glProgramUniform1ui (GLuint program, GLint location, GLuint v0) ;
extern void glProgramUniform1uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) ;
extern void glProgramUniform2i (GLuint program, GLint location, GLint v0, GLint v1) ;
extern void glProgramUniform2iv (GLuint program, GLint location, GLsizei count, const GLint *value) ;
extern void glProgramUniform2f (GLuint program, GLint location, GLfloat v0, GLfloat v1) ;
extern void glProgramUniform2fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) ;
extern void glProgramUniform2d (GLuint program, GLint location, GLdouble v0, GLdouble v1) ;
extern void glProgramUniform2dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) ;
extern void glProgramUniform2ui (GLuint program, GLint location, GLuint v0, GLuint v1) ;
extern void glProgramUniform2uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) ;
extern void glProgramUniform3i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2) ;
extern void glProgramUniform3iv (GLuint program, GLint location, GLsizei count, const GLint *value) ;
extern void glProgramUniform3f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2) ;
extern void glProgramUniform3fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) ;
extern void glProgramUniform3d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2) ;
extern void glProgramUniform3dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) ;
extern void glProgramUniform3ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2) ;
extern void glProgramUniform3uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) ;
extern void glProgramUniform4i (GLuint program, GLint location, GLint v0, GLint v1, GLint v2, GLint v3) ;
extern void glProgramUniform4iv (GLuint program, GLint location, GLsizei count, const GLint *value) ;
extern void glProgramUniform4f (GLuint program, GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3) ;
extern void glProgramUniform4fv (GLuint program, GLint location, GLsizei count, const GLfloat *value) ;
extern void glProgramUniform4d (GLuint program, GLint location, GLdouble v0, GLdouble v1, GLdouble v2, GLdouble v3) ;
extern void glProgramUniform4dv (GLuint program, GLint location, GLsizei count, const GLdouble *value) ;
extern void glProgramUniform4ui (GLuint program, GLint location, GLuint v0, GLuint v1, GLuint v2, GLuint v3) ;
extern void glProgramUniform4uiv (GLuint program, GLint location, GLsizei count, const GLuint *value) ;
extern void glProgramUniformMatrix2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix2x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix3x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix2x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix4x2fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix3x4fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix4x3fv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLfloat *value) ;
extern void glProgramUniformMatrix2x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix3x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix2x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix4x2dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix3x4dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glProgramUniformMatrix4x3dv (GLuint program, GLint location, GLsizei count, GLboolean transpose, const GLdouble *value) ;
extern void glValidateProgramPipeline (GLuint pipeline) ;
extern void glGetProgramPipelineInfoLog (GLuint pipeline, GLsizei bufSize, GLsizei *length, GLchar *infoLog) ;

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
extern void glVertexAttribL1d (GLuint index, GLdouble x) ;
extern void glVertexAttribL2d (GLuint index, GLdouble x, GLdouble y) ;
extern void glVertexAttribL3d (GLuint index, GLdouble x, GLdouble y, GLdouble z) ;
extern void glVertexAttribL4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w) ;
extern void glVertexAttribL1dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttribL2dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttribL3dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttribL4dv (GLuint index, const GLdouble *v) ;
extern void glVertexAttribLPointer (GLuint index, GLint size, GLenum type, GLsizei stride, const GLvoid *pointer) ;
extern void glGetVertexAttribLdv (GLuint index, GLenum pname, GLdouble *params) ;

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





extern void glViewportArrayv (GLuint first, GLsizei count, const GLfloat *v) ;
extern void glViewportIndexedf (GLuint index, GLfloat x, GLfloat y, GLfloat w, GLfloat h) ;
extern void glViewportIndexedfv (GLuint index, const GLfloat *v) ;
extern void glScissorArrayv (GLuint first, GLsizei count, const GLint *v) ;
extern void glScissorIndexed (GLuint index, GLint left, GLint bottom, GLsizei width, GLsizei height) ;
extern void glScissorIndexedv (GLuint index, const GLint *v) ;
extern void glDepthRangeArrayv (GLuint first, GLsizei count, const GLclampd *v) ;
extern void glDepthRangeIndexed (GLuint index, GLclampd n, GLclampd f) ;
extern void glGetFloati_v (GLenum target, GLuint index, GLfloat *data) ;
extern void glGetDoublei_v (GLenum target, GLuint index, GLdouble *data) ;

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









extern const char * SDL_GetPlatform (void);
















static inline
__uint16_t
_OSSwapInt16(
 __uint16_t _data
 )
{
 return (__uint16_t)((_data << 8) | (_data >> 8));
}

static inline
__uint32_t
_OSSwapInt32(
 __uint32_t _data
 )
{

 return __builtin_bswap32(_data);




}


static inline
__uint64_t
_OSSwapInt64(
 __uint64_t _data
 )
{
 return __builtin_bswap64(_data);
}


typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned int u_int;

typedef unsigned long u_long;


typedef unsigned short ushort;
typedef unsigned int uint;


typedef u_int64_t u_quad_t;
typedef int64_t quad_t;
typedef quad_t * qaddr_t;


typedef char * caddr_t;

typedef int32_t daddr_t;


typedef __darwin_dev_t dev_t;

typedef u_int32_t fixpt_t;


typedef __darwin_blkcnt_t blkcnt_t;
typedef __darwin_blksize_t blksize_t;
typedef __darwin_gid_t gid_t;
typedef __uint32_t in_addr_t;
typedef __uint16_t in_port_t;
typedef __darwin_ino_t ino_t;


typedef __darwin_ino64_t ino64_t;


typedef __int32_t key_t;
typedef __darwin_mode_t mode_t;
typedef __uint16_t nlink_t;
typedef __darwin_id_t id_t;
typedef __darwin_pid_t pid_t;
typedef __darwin_off_t off_t;

typedef int32_t segsz_t;
typedef int32_t swblk_t;


typedef __darwin_uid_t uid_t;
typedef __darwin_clock_t clock_t;
typedef __darwin_size_t size_t;
typedef __darwin_ssize_t ssize_t;
typedef __darwin_time_t time_t;

typedef __darwin_useconds_t useconds_t;
typedef __darwin_suseconds_t suseconds_t;


typedef __darwin_size_t rsize_t;
typedef int errno_t;








typedef struct fd_set {
 __int32_t fds_bits[((((1024) % ((sizeof(__int32_t) * 8))) == 0) ? ((1024) / ((sizeof(__int32_t) * 8))) : (((1024) / ((sizeof(__int32_t) * 8))) + 1))];
} fd_set;

int __darwin_check_fd_set_overflow(int, const void *, int) ;


inline int
__darwin_check_fd_set(int _a, const void *_b)
{
 if ((uintptr_t)&__darwin_check_fd_set_overflow != (uintptr_t) 0) {



  return __darwin_check_fd_set_overflow(_a, _b, 0);

 } else {
  return 1;
 }
}


inline int
__darwin_fd_isset(int _fd, const struct fd_set *_p)
{
 if (__darwin_check_fd_set(_fd, (const void *) _p)) {
  return _p->fds_bits[(unsigned long)_fd / (sizeof(__int32_t) * 8)] & ((__int32_t)(((unsigned long)1) << ((unsigned long)_fd % (sizeof(__int32_t) * 8))));
 }

 return 0;
}

inline void
__darwin_fd_set(int _fd, struct fd_set *const _p)
{
 if (__darwin_check_fd_set(_fd, (const void *) _p)) {
  (_p->fds_bits[(unsigned long)_fd / (sizeof(__int32_t) * 8)] |= ((__int32_t)(((unsigned long)1) << ((unsigned long)_fd % (sizeof(__int32_t) * 8)))));
 }
}

inline void
__darwin_fd_clr(int _fd, struct fd_set *const _p)
{
 if (__darwin_check_fd_set(_fd, (const void *) _p)) {
  (_p->fds_bits[(unsigned long)_fd / (sizeof(__int32_t) * 8)] &= ~((__int32_t)(((unsigned long)1) << ((unsigned long)_fd % (sizeof(__int32_t) * 8)))));
 }
}




typedef __int32_t fd_mask;










typedef __darwin_pthread_attr_t pthread_attr_t;
typedef __darwin_pthread_cond_t pthread_cond_t;
typedef __darwin_pthread_condattr_t pthread_condattr_t;
typedef __darwin_pthread_mutex_t pthread_mutex_t;
typedef __darwin_pthread_mutexattr_t pthread_mutexattr_t;
typedef __darwin_pthread_once_t pthread_once_t;
typedef __darwin_pthread_rwlock_t pthread_rwlock_t;
typedef __darwin_pthread_rwlockattr_t pthread_rwlockattr_t;
typedef __darwin_pthread_t pthread_t;



typedef __darwin_pthread_key_t pthread_key_t;




typedef __darwin_fsblkcnt_t fsblkcnt_t;
typedef __darwin_fsfilcnt_t fsfilcnt_t;


typedef int __darwin_nl_item;
typedef int __darwin_wctrans_t;

typedef __uint32_t __darwin_wctype_t;



typedef __darwin_va_list va_list;


int renameat(int, const char *, int, const char *) ;






int renamex_np(const char *, const char *, unsigned int) ;
int renameatx_np(int, const char *, int, const char *, unsigned int) ;

typedef __darwin_off_t fpos_t;
struct __sbuf {
 unsigned char *_base;
 int _size;
};


struct __sFILEX;
typedef struct __sFILE {
 unsigned char *_p;
 int _r;
 int _w;
 short _flags;
 short _file;
 struct __sbuf _bf;
 int _lbfsize;


 void *_cookie;
 int (* _close)(void *);
 int (* _read) (void *, char *, int);
 fpos_t (* _seek) (void *, fpos_t, int);
 int (* _write)(void *, const char *, int);


 struct __sbuf _ub;
 struct __sFILEX *_extra;
 int _ur;


 unsigned char _ubuf[3];
 unsigned char _nbuf[1];


 struct __sbuf _lb;


 int _blksize;
 fpos_t _offset;
} FILE;


extern FILE *__stdinp;
extern FILE *__stdoutp;
extern FILE *__stderrp;
void clearerr(FILE *);
int fclose(FILE *);
int feof(FILE *);
int ferror(FILE *);
int fflush(FILE *);
int fgetc(FILE *);
int fgetpos(FILE * restrict, fpos_t *);
char *fgets(char * restrict, int, FILE *);



FILE *fopen(const char * restrict __filename, const char * restrict __mode) __asm("_" "fopen" );

int fprintf(FILE * restrict, const char * restrict, ...) ;
int fputc(int, FILE *);
int fputs(const char * restrict, FILE * restrict) __asm("_" "fputs" );
size_t fread(void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream);
FILE *freopen(const char * restrict, const char * restrict,
                 FILE * restrict) __asm("_" "freopen" );
int fscanf(FILE * restrict, const char * restrict, ...) ;
int fseek(FILE *, long, int);
int fsetpos(FILE *, const fpos_t *);
long ftell(FILE *);
size_t fwrite(const void * restrict __ptr, size_t __size, size_t __nitems, FILE * restrict __stream) __asm("_" "fwrite" );
int getc(FILE *);
int getchar(void);
char *gets(char *);
void perror(const char *) ;
int printf(const char * restrict, ...) ;
int putc(int, FILE *);
int putchar(int);
int puts(const char *);
int remove(const char *);
int rename (const char *__old, const char *__new);
void rewind(FILE *);
int scanf(const char * restrict, ...) ;
void setbuf(FILE * restrict, char * restrict);
int setvbuf(FILE * restrict, char * restrict, int, size_t);
int sprintf(char * restrict, const char * restrict, ...) ;
int sscanf(const char * restrict, const char * restrict, ...) ;
FILE *tmpfile(void);





char *tmpnam(char *);
int ungetc(int, FILE *);
int vfprintf(FILE * restrict, const char * restrict, va_list) ;
int vprintf(const char * restrict, va_list) ;
int vsprintf(char * restrict, const char * restrict, va_list) ;
char *ctermid(char *);




FILE *fdopen(int, const char *) __asm("_" "fdopen" );

int fileno(FILE *);
int pclose(FILE *) ;



FILE *popen(const char *, const char *) __asm("_" "popen" ) ;
int __srget(FILE *);
int __svfscanf(FILE *, const char *, va_list) ;
int __swbuf(int, FILE *);
inline int __sputc(int _c, FILE *_p) {
 if (--_p->_w >= 0 || (_p->_w >= _p->_lbfsize && (char)_c != '\n'))
  return (*_p->_p++ = _c);
 else
  return (__swbuf(_c, _p));
}
void flockfile(FILE *);
int ftrylockfile(FILE *);
void funlockfile(FILE *);
int getc_unlocked(FILE *);
int getchar_unlocked(void);
int putc_unlocked(int, FILE *);
int putchar_unlocked(int);



int getw(FILE *);
int putw(int, FILE *);






char *tempnam(const char *__dir, const char *__prefix) __asm("_" "tempnam" );
int fseeko(FILE * __stream, off_t __offset, int __whence);
off_t ftello(FILE * __stream);





int snprintf(char * restrict __str, size_t __size, const char * restrict __format, ...) ;
int vfscanf(FILE * restrict __stream, const char * restrict __format, va_list) ;
int vscanf(const char * restrict __format, va_list) ;
int vsnprintf(char * restrict __str, size_t __size, const char * restrict __format, va_list) ;
int vsscanf(const char * restrict __str, const char * restrict __format, va_list) ;
int dprintf(int, const char * restrict, ...) ;
int vdprintf(int, const char * restrict, va_list) ;
ssize_t getdelim(char ** restrict __linep, size_t * restrict __linecapp, int __delimiter, FILE * restrict __stream) ;
ssize_t getline(char ** restrict __linep, size_t * restrict __linecapp, FILE * restrict __stream) ;
FILE *fmemopen(void * restrict __buf, size_t __size, const char * restrict __mode) ;
FILE *open_memstream(char **__bufp, size_t *__sizep) ;
extern const int sys_nerr;
extern const char *const sys_errlist[];

int asprintf(char ** restrict, const char * restrict, ...) ;
char *ctermid_r(char *);
char *fgetln(FILE *, size_t *);
const char *fmtcheck(const char *, const char *);
int fpurge(FILE *);
void setbuffer(FILE *, char *, int);
int setlinebuf(FILE *);
int vasprintf(char ** restrict, const char * restrict, va_list) ;
FILE *zopen(const char *, const char *, int);





FILE *funopen(const void *,
                 int (* )(void *, char *, int),
                 int (* )(void *, const char *, int),
                 fpos_t (* )(void *, fpos_t, int),
                 int (* )(void *));
extern int __sprintf_chk (char * restrict, int, size_t,
     const char * restrict, ...);
extern int __snprintf_chk (char * restrict, size_t, int, size_t,
      const char * restrict, ...);







extern int __vsprintf_chk (char * restrict, int, size_t,
      const char * restrict, va_list);







extern int __vsnprintf_chk (char * restrict, size_t, int, size_t,
       const char * restrict, va_list);


typedef enum {
 P_ALL,
 P_PID,
 P_PGID
} idtype_t;
typedef int sig_atomic_t;
struct __darwin_i386_thread_state
{
    unsigned int __eax;
    unsigned int __ebx;
    unsigned int __ecx;
    unsigned int __edx;
    unsigned int __edi;
    unsigned int __esi;
    unsigned int __ebp;
    unsigned int __esp;
    unsigned int __ss;
    unsigned int __eflags;
    unsigned int __eip;
    unsigned int __cs;
    unsigned int __ds;
    unsigned int __es;
    unsigned int __fs;
    unsigned int __gs;
};
struct __darwin_fp_control
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
      :2,
    __pc :2,





    __rc :2,






             :1,
      :3;
};
typedef struct __darwin_fp_control __darwin_fp_control_t;
struct __darwin_fp_status
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
    __stkflt :1,
    __errsumm :1,
    __c0 :1,
    __c1 :1,
    __c2 :1,
    __tos :3,
    __c3 :1,
    __busy :1;
};
typedef struct __darwin_fp_status __darwin_fp_status_t;
struct __darwin_mmst_reg
{
 char __mmst_reg[10];
 char __mmst_rsrv[6];
};
struct __darwin_xmm_reg
{
 char __xmm_reg[16];
};
struct __darwin_ymm_reg
{
 char __ymm_reg[32];
};
struct __darwin_zmm_reg
{
 char __zmm_reg[64];
};
struct __darwin_opmask_reg
{
 char __opmask_reg[8];
};
struct __darwin_i386_float_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
};


struct __darwin_i386_avx_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
};


struct __darwin_i386_avx512_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
};
struct __darwin_i386_exception_state
{
 __uint16_t __trapno;
 __uint16_t __cpu;
 __uint32_t __err;
 __uint32_t __faultvaddr;
};
struct __darwin_x86_debug_state32
{
 unsigned int __dr0;
 unsigned int __dr1;
 unsigned int __dr2;
 unsigned int __dr3;
 unsigned int __dr4;
 unsigned int __dr5;
 unsigned int __dr6;
 unsigned int __dr7;
};
struct __x86_pagein_state
{
 int __pagein_error;
};







struct __darwin_x86_thread_state64
{
 __uint64_t __rax;
 __uint64_t __rbx;
 __uint64_t __rcx;
 __uint64_t __rdx;
 __uint64_t __rdi;
 __uint64_t __rsi;
 __uint64_t __rbp;
 __uint64_t __rsp;
 __uint64_t __r8;
 __uint64_t __r9;
 __uint64_t __r10;
 __uint64_t __r11;
 __uint64_t __r12;
 __uint64_t __r13;
 __uint64_t __r14;
 __uint64_t __r15;
 __uint64_t __rip;
 __uint64_t __rflags;
 __uint64_t __cs;
 __uint64_t __fs;
 __uint64_t __gs;
};
struct __darwin_x86_thread_full_state64
{
 struct __darwin_x86_thread_state64 __ss64;
 __uint64_t __ds;
 __uint64_t __es;
 __uint64_t __ss;
 __uint64_t __gsbase;
};
struct __darwin_x86_float_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
};


struct __darwin_x86_avx_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
};


struct __darwin_x86_avx512_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
 struct __darwin_ymm_reg __fpu_zmmh8;
 struct __darwin_ymm_reg __fpu_zmmh9;
 struct __darwin_ymm_reg __fpu_zmmh10;
 struct __darwin_ymm_reg __fpu_zmmh11;
 struct __darwin_ymm_reg __fpu_zmmh12;
 struct __darwin_ymm_reg __fpu_zmmh13;
 struct __darwin_ymm_reg __fpu_zmmh14;
 struct __darwin_ymm_reg __fpu_zmmh15;
 struct __darwin_zmm_reg __fpu_zmm16;
 struct __darwin_zmm_reg __fpu_zmm17;
 struct __darwin_zmm_reg __fpu_zmm18;
 struct __darwin_zmm_reg __fpu_zmm19;
 struct __darwin_zmm_reg __fpu_zmm20;
 struct __darwin_zmm_reg __fpu_zmm21;
 struct __darwin_zmm_reg __fpu_zmm22;
 struct __darwin_zmm_reg __fpu_zmm23;
 struct __darwin_zmm_reg __fpu_zmm24;
 struct __darwin_zmm_reg __fpu_zmm25;
 struct __darwin_zmm_reg __fpu_zmm26;
 struct __darwin_zmm_reg __fpu_zmm27;
 struct __darwin_zmm_reg __fpu_zmm28;
 struct __darwin_zmm_reg __fpu_zmm29;
 struct __darwin_zmm_reg __fpu_zmm30;
 struct __darwin_zmm_reg __fpu_zmm31;
};
struct __darwin_x86_exception_state64
{
    __uint16_t __trapno;
    __uint16_t __cpu;
    __uint32_t __err;
    __uint64_t __faultvaddr;
};
struct __darwin_x86_debug_state64
{
 __uint64_t __dr0;
 __uint64_t __dr1;
 __uint64_t __dr2;
 __uint64_t __dr3;
 __uint64_t __dr4;
 __uint64_t __dr5;
 __uint64_t __dr6;
 __uint64_t __dr7;
};
struct __darwin_x86_cpmu_state64
{
 __uint64_t __ctrs[16];
};




struct __darwin_mcontext32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_float_state __fs;
};


struct __darwin_mcontext_avx32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx_state __fs;
};



struct __darwin_mcontext_avx512_32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx512_state __fs;
};
struct __darwin_mcontext64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};


struct __darwin_mcontext64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};


struct __darwin_mcontext_avx64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};


struct __darwin_mcontext_avx64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};



struct __darwin_mcontext_avx512_64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};


struct __darwin_mcontext_avx512_64_full
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_full_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};
typedef struct __darwin_mcontext64 *mcontext_t;



struct __darwin_sigaltstack
{
 void *ss_sp;
 __darwin_size_t ss_size;
 int ss_flags;
};
typedef struct __darwin_sigaltstack stack_t;


struct __darwin_ucontext
{
 int uc_onstack;
 __darwin_sigset_t uc_sigmask;
 struct __darwin_sigaltstack uc_stack;
 struct __darwin_ucontext *uc_link;
 __darwin_size_t uc_mcsize;
 struct __darwin_mcontext64 *uc_mcontext;



};


typedef struct __darwin_ucontext ucontext_t;


typedef __darwin_sigset_t sigset_t;



union sigval {

 int sival_int;
 void *sival_ptr;
};





struct sigevent {
 int sigev_notify;
 int sigev_signo;
 union sigval sigev_value;
 void (*sigev_notify_function)(union sigval);
 pthread_attr_t *sigev_notify_attributes;
};


typedef struct __siginfo {
 int si_signo;
 int si_errno;
 int si_code;
 pid_t si_pid;
 uid_t si_uid;
 int si_status;
 void *si_addr;
 union sigval si_value;
 long si_band;
 unsigned long __pad[7];
} siginfo_t;
union __sigaction_u {
 void (*__sa_handler)(int);
 void (*__sa_sigaction)(int, struct __siginfo *,
     void *);
};


struct __sigaction {
 union __sigaction_u __sigaction_u;
 void (*sa_tramp)(void *, int, int, siginfo_t *, void *);
 sigset_t sa_mask;
 int sa_flags;
};




struct sigaction {
 union __sigaction_u __sigaction_u;
 sigset_t sa_mask;
 int sa_flags;
};
typedef void (*sig_t)(int);
struct sigvec {
 void (*sv_handler)(int);
 int sv_mask;
 int sv_flags;
};
struct sigstack {
 char *ss_sp;
 int ss_onstack;
};
    void(*signal(int, void (*)(int)))(int);
struct timeval
{
 __darwin_time_t tv_sec;
 __darwin_suseconds_t tv_usec;
};








typedef __uint64_t rlim_t;
struct rusage {
 struct timeval ru_utime;
 struct timeval ru_stime;
 long ru_maxrss;

 long ru_ixrss;
 long ru_idrss;
 long ru_isrss;
 long ru_minflt;
 long ru_majflt;
 long ru_nswap;
 long ru_inblock;
 long ru_oublock;
 long ru_msgsnd;
 long ru_msgrcv;
 long ru_nsignals;
 long ru_nvcsw;
 long ru_nivcsw;


};
typedef void *rusage_info_t;

struct rusage_info_v0 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
};

struct rusage_info_v1 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
};

struct rusage_info_v2 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
};

struct rusage_info_v3 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
};

struct rusage_info_v4 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
 uint64_t ri_logical_writes;
 uint64_t ri_lifetime_max_phys_footprint;
 uint64_t ri_instructions;
 uint64_t ri_cycles;
 uint64_t ri_billed_energy;
 uint64_t ri_serviced_energy;
 uint64_t ri_interval_max_phys_footprint;
 uint64_t ri_runnable_time;
};

typedef struct rusage_info_v4 rusage_info_current;
struct rlimit {
 rlim_t rlim_cur;
 rlim_t rlim_max;
};
struct proc_rlimit_control_wakeupmon {
 uint32_t wm_flags;
 int32_t wm_rate;
};
int getpriority(int, id_t);

int getiopolicy_np(int, int) ;

int getrlimit(int, struct rlimit *) __asm("_" "getrlimit" );
int getrusage(int, struct rusage *);
int setpriority(int, id_t, int);

int setiopolicy_np(int, int, int) ;

int setrlimit(int, const struct rlimit *) __asm("_" "setrlimit" );
union wait {
 int w_status;



 struct {

  unsigned int w_Termsig:7,
      w_Coredump:1,
      w_Retcode:8,
      w_Filler:16;







 } w_T;





 struct {

  unsigned int w_Stopval:8,
      w_Stopsig:8,
      w_Filler:16;






 } w_S;
};
pid_t wait(int *) __asm("_" "wait" );
pid_t waitpid(pid_t, int *, int) __asm("_" "waitpid" );

int waitid(idtype_t, id_t, siginfo_t *, int) __asm("_" "waitid" );


pid_t wait3(int *, int, struct rusage *);
pid_t wait4(pid_t, int *, int, struct rusage *);

void *alloca(size_t);








typedef __darwin_ct_rune_t ct_rune_t;
typedef __darwin_rune_t rune_t;


typedef __darwin_wchar_t wchar_t;

typedef struct {
 int quot;
 int rem;
} div_t;

typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef struct {
 long long quot;
 long long rem;
} lldiv_t;
extern int __mb_cur_max;
void *malloc(size_t __size) ;
void *calloc(size_t __count, size_t __size) ;
void free(void *);
void *realloc(void *__ptr, size_t __size) ;

void *valloc(size_t) ;




void *aligned_alloc(size_t __alignment, size_t __size) ;

int posix_memalign(void **__memptr, size_t __alignment, size_t __size) ;


void abort(void) ;
int abs(int) ;
int atexit(void (* )(void));
double atof(const char *);
int atoi(const char *);
long atol(const char *);

long long
  atoll(const char *);

void *bsearch(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (* )(const void *, const void *));

div_t div(int, int) ;
void exit(int) ;

char *getenv(const char *);
long labs(long) ;
ldiv_t ldiv(long, long) ;

long long
  llabs(long long);
lldiv_t lldiv(long long, long long);


int mblen(const char *__s, size_t __n);
size_t mbstowcs(wchar_t * restrict , const char * restrict, size_t);
int mbtowc(wchar_t * restrict, const char * restrict, size_t);

void qsort(void *__base, size_t __nel, size_t __width,
     int (* )(const void *, const void *));
int rand(void) ;

void srand(unsigned) ;
double strtod(const char *, char **) __asm("_" "strtod" );
float strtof(const char *, char **) __asm("_" "strtof" );
long strtol(const char *__str, char **__endptr, int __base);
long double
  strtold(const char *, char **);

long long
  strtoll(const char *__str, char **__endptr, int __base);

unsigned long
  strtoul(const char *__str, char **__endptr, int __base);

unsigned long long
  strtoull(const char *__str, char **__endptr, int __base);
int system(const char *) __asm("_" "system" );



size_t wcstombs(char * restrict, const wchar_t * restrict, size_t);
int wctomb(char *, wchar_t);


void _Exit(int) ;
long a64l(const char *);
double drand48(void);
char *ecvt(double, int, int *restrict, int *restrict);
double erand48(unsigned short[3]);
char *fcvt(double, int, int *restrict, int *restrict);
char *gcvt(double, int, char *);
int getsubopt(char **, char * const *, char **);
int grantpt(int);

char *initstate(unsigned, char *, size_t);



long jrand48(unsigned short[3]) ;
char *l64a(long);
void lcong48(unsigned short[7]);
long lrand48(void) ;
char *mktemp(char *);
int mkstemp(char *);
long mrand48(void) ;
long nrand48(unsigned short[3]) ;
int posix_openpt(int);
char *ptsname(int);


int ptsname_r(int fildes, char *buffer, size_t buflen) ;


int putenv(char *) __asm("_" "putenv" );
long random(void) ;
int rand_r(unsigned *) ;

char *realpath(const char * restrict, char * restrict) __asm("_" "realpath" "$DARWIN_EXTSN");



unsigned short
 *seed48(unsigned short[3]);
int setenv(const char * __name, const char * __value, int __overwrite) __asm("_" "setenv" );

void setkey(const char *) __asm("_" "setkey" );



char *setstate(const char *);
void srand48(long);

void srandom(unsigned);



int unlockpt(int);

int unsetenv(const char *) __asm("_" "unsetenv" );
uint32_t arc4random(void);
void arc4random_addrandom(unsigned char * , int )



                                                         ;
void arc4random_buf(void * __buf, size_t __nbytes) ;
void arc4random_stir(void);
uint32_t
  arc4random_uniform(uint32_t __upper_bound) ;

int atexit_b(void (^ )(void)) ;
void *bsearch_b(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (^ )(const void *, const void *)) ;



char *cgetcap(char *, const char *, int);
int cgetclose(void);
int cgetent(char **, char **, const char *);
int cgetfirst(char **, char **);
int cgetmatch(const char *, const char *);
int cgetnext(char **, char **);
int cgetnum(char *, const char *, long *);
int cgetset(const char *);
int cgetstr(char *, const char *, char **);
int cgetustr(char *, const char *, char **);

int daemon(int, int) __asm("_" "daemon" "$1050") ;
char *devname(dev_t, mode_t);
char *devname_r(dev_t, mode_t, char *buf, int len);
char *getbsize(int *, long *);
int getloadavg(double [], int);
const char
 *getprogname(void);
void setprogname(const char *);
int heapsort(void *__base, size_t __nel, size_t __width,
     int (* )(const void *, const void *));

int heapsort_b(void *__base, size_t __nel, size_t __width,
     int (^ )(const void *, const void *) )
                                                       ;

int mergesort(void *__base, size_t __nel, size_t __width,
     int (* )(const void *, const void *));

int mergesort_b(void *__base, size_t __nel, size_t __width,
     int (^ )(const void *, const void *) )
                                                       ;

void psort(void *__base, size_t __nel, size_t __width,
     int (* )(const void *, const void *))
                                                       ;

void psort_b(void *__base, size_t __nel, size_t __width,
     int (^ )(const void *, const void *) )
                                                       ;

void psort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* )(void *, const void *, const void *))
                                                       ;

void qsort_b(void *__base, size_t __nel, size_t __width,
     int (^ )(const void *, const void *) )
                                                       ;

void qsort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* )(void *, const void *, const void *));
int radixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
int rpmatch(const char *)
                                                                   ;
int sradixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
void sranddev(void);
void srandomdev(void);
void *reallocf(void *__ptr, size_t __size) ;

long long
  strtoq(const char *__str, char **__endptr, int __base);
unsigned long long
  strtouq(const char *__str, char **__endptr, int __base);

extern char *suboptarg;
typedef long int ptrdiff_t;
typedef long double max_align_t;
typedef __builtin_va_list va_list;
typedef __builtin_va_list __gnuc_va_list;
void *memchr(const void *__s, int __c, size_t __n);
int memcmp(const void *__s1, const void *__s2, size_t __n);
void *memcpy(void *__dst, const void *__src, size_t __n);
void *memmove(void *__dst, const void *__src, size_t __len);
void *memset(void *__b, int __c, size_t __len);
char *strcat(char *__s1, const char *__s2);
char *strchr(const char *__s, int __c);
int strcmp(const char *__s1, const char *__s2);
int strcoll(const char *__s1, const char *__s2);
char *strcpy(char *__dst, const char *__src);
size_t strcspn(const char *__s, const char *__charset);
char *strerror(int __errnum) __asm("_" "strerror" );
size_t strlen(const char *__s);
char *strncat(char *__s1, const char *__s2, size_t __n);
int strncmp(const char *__s1, const char *__s2, size_t __n);
char *strncpy(char *__dst, const char *__src, size_t __n);
char *strpbrk(const char *__s, const char *__charset);
char *strrchr(const char *__s, int __c);
size_t strspn(const char *__s, const char *__charset);
char *strstr(const char *__big, const char *__little);
char *strtok(char *__str, const char *__sep);
size_t strxfrm(char *__s1, const char *__s2, size_t __n);
char *strtok_r(char *__str, const char *__sep, char **__lasts);
int strerror_r(int __errnum, char *__strerrbuf, size_t __buflen);
char *strdup(const char *__s1);
void *memccpy(void *__dst, const void *__src, int __c, size_t __n);
char *stpcpy(char *__dst, const char *__src);
char *stpncpy(char *__dst, const char *__src, size_t __n) ;
char *strndup(const char *__s1, size_t __n) ;
size_t strnlen(const char *__s1, size_t __n) ;
char *strsignal(int __sig);
errno_t memset_s(void *__s, rsize_t __smax, int __c, rsize_t __n) ;
void *memmem(const void *__big, size_t __big_len, const void *__little, size_t __little_len) ;
void memset_pattern4(void *__b, const void *__pattern4, size_t __len) ;
void memset_pattern8(void *__b, const void *__pattern8, size_t __len) ;
void memset_pattern16(void *__b, const void *__pattern16, size_t __len) ;

char *strcasestr(const char *__big, const char *__little);
char *strnstr(const char *__big, const char *__little, size_t __len);
size_t strlcat(char *__dst, const char *__source, size_t __size);
size_t strlcpy(char *__dst, const char *__source, size_t __size);
void strmode(int __mode, char *__bp);
char *strsep(char **__stringp, const char *__delim);


void swab(const void * restrict, void * restrict, ssize_t);



int timingsafe_bcmp(const void *__b1, const void *__b2, size_t __len);








int bcmp(const void *, const void *, size_t) ;
void bcopy(const void *, void *, size_t) ;
void bzero(void *, size_t) ;
char *index(const char *, int) ;
char *rindex(const char *, int) ;


int ffs(int);
int strcasecmp(const char *, const char *);
int strncasecmp(const char *, const char *, size_t);





int ffsl(long) ;
int ffsll(long long) ;
int fls(int) ;
int flsl(long) ;
int flsll(long long) ;






















extern intmax_t
imaxabs(intmax_t j);


typedef struct {
 intmax_t quot;
 intmax_t rem;
} imaxdiv_t;


extern imaxdiv_t
imaxdiv(intmax_t __numer, intmax_t __denom);



extern intmax_t
strtoimax(const char * restrict __nptr,
   char ** restrict __endptr,
   int __base);


extern uintmax_t
strtoumax(const char * restrict __nptr,
   char ** restrict __endptr,
   int __base);



extern intmax_t
wcstoimax(const wchar_t * restrict __nptr,
   wchar_t ** restrict __endptr,
   int __base);


extern uintmax_t
wcstoumax(const wchar_t * restrict __nptr,
   wchar_t ** restrict __endptr,
   int __base);




typedef __darwin_wint_t wint_t;
typedef struct {
 __darwin_rune_t __min;
 __darwin_rune_t __max;
 __darwin_rune_t __map;
 __uint32_t *__types;
} _RuneEntry;

typedef struct {
 int __nranges;
 _RuneEntry *__ranges;
} _RuneRange;

typedef struct {
 char __name[14];
 __uint32_t __mask;
} _RuneCharClass;

typedef struct {
 char __magic[8];
 char __encoding[32];

 __darwin_rune_t (*__sgetrune)(const char *, __darwin_size_t, char const **);
 int (*__sputrune)(__darwin_rune_t, char *, __darwin_size_t, char **);
 __darwin_rune_t __invalid_rune;

 __uint32_t __runetype[(1 <<8 )];
 __darwin_rune_t __maplower[(1 <<8 )];
 __darwin_rune_t __mapupper[(1 <<8 )];






 _RuneRange __runetype_ext;
 _RuneRange __maplower_ext;
 _RuneRange __mapupper_ext;

 void *__variable;
 int __variable_len;




 int __ncharclasses;
 _RuneCharClass *__charclasses;
} _RuneLocale;




extern _RuneLocale _DefaultRuneLocale;
extern _RuneLocale *_CurrentRuneLocale;
unsigned long ___runetype(__darwin_ct_rune_t);
__darwin_ct_rune_t ___tolower(__darwin_ct_rune_t);
__darwin_ct_rune_t ___toupper(__darwin_ct_rune_t);


inline int
isascii(int _c)
{
 return ((_c & ~0x7F) == 0);
}
int __maskrune(__darwin_ct_rune_t, unsigned long);



inline int
__istype(__darwin_ct_rune_t _c, unsigned long _f)
{



 return (isascii(_c) ? !!(_DefaultRuneLocale.__runetype[_c] & _f)
  : !!__maskrune(_c, _f));

}

inline __darwin_ct_rune_t
__isctype(__darwin_ct_rune_t _c, unsigned long _f)
{



 return (_c < 0 || _c >= (1 <<8 )) ? 0 :
  !!(_DefaultRuneLocale.__runetype[_c] & _f);

}
__darwin_ct_rune_t __toupper(__darwin_ct_rune_t);
__darwin_ct_rune_t __tolower(__darwin_ct_rune_t);



inline int
__wcwidth(__darwin_ct_rune_t _c)
{
 unsigned int _x;

 if (_c == 0)
  return (0);
 _x = (unsigned int)__maskrune(_c, 0xe0000000L|0x00040000L);
 if ((_x & 0xe0000000L) != 0)
  return ((_x & 0xe0000000L) >> 30);
 return ((_x & 0x00040000L) != 0 ? 1 : -1);
}






inline int
isalnum(int _c)
{
 return (__istype(_c, 0x00000100L|0x00000400L));
}

inline int
isalpha(int _c)
{
 return (__istype(_c, 0x00000100L));
}

inline int
isblank(int _c)
{
 return (__istype(_c, 0x00020000L));
}

inline int
iscntrl(int _c)
{
 return (__istype(_c, 0x00000200L));
}


inline int
isdigit(int _c)
{
 return (__isctype(_c, 0x00000400L));
}

inline int
isgraph(int _c)
{
 return (__istype(_c, 0x00000800L));
}

inline int
islower(int _c)
{
 return (__istype(_c, 0x00001000L));
}

inline int
isprint(int _c)
{
 return (__istype(_c, 0x00040000L));
}

inline int
ispunct(int _c)
{
 return (__istype(_c, 0x00002000L));
}

inline int
isspace(int _c)
{
 return (__istype(_c, 0x00004000L));
}

inline int
isupper(int _c)
{
 return (__istype(_c, 0x00008000L));
}


inline int
isxdigit(int _c)
{
 return (__isctype(_c, 0x00010000L));
}

inline int
toascii(int _c)
{
 return (_c & 0x7F);
}

inline int
tolower(int _c)
{
        return (__tolower(_c));
}

inline int
toupper(int _c)
{
        return (__toupper(_c));
}


inline int
digittoint(int _c)
{
 return (__maskrune(_c, 0x0F));
}

inline int
ishexnumber(int _c)
{
 return (__istype(_c, 0x00010000L));
}

inline int
isideogram(int _c)
{
 return (__istype(_c, 0x00080000L));
}

inline int
isnumber(int _c)
{
 return (__istype(_c, 0x00000400L));
}

inline int
isphonogram(int _c)
{
 return (__istype(_c, 0x00200000L));
}

inline int
isrune(int _c)
{
 return (__istype(_c, 0xFFFFFFF0L));
}

inline int
isspecial(int _c)
{
 return (__istype(_c, 0x00100000L));
}
    typedef float float_t;
    typedef double double_t;
extern int __math_errhandling(void);
extern int __fpclassifyf(float);
extern int __fpclassifyd(double);
extern int __fpclassifyl(long double);
inline int __inline_isfinitef(float);
inline int __inline_isfinited(double);
inline int __inline_isfinitel(long double);
inline int __inline_isinff(float);
inline int __inline_isinfd(double);
inline int __inline_isinfl(long double);
inline int __inline_isnanf(float);
inline int __inline_isnand(double);
inline int __inline_isnanl(long double);
inline int __inline_isnormalf(float);
inline int __inline_isnormald(double);
inline int __inline_isnormall(long double);
inline int __inline_signbitf(float);
inline int __inline_signbitd(double);
inline int __inline_signbitl(long double);

inline int __inline_isfinitef(float __x) {
    return __x == __x && __builtin_fabsf(__x) != __builtin_inff();
}
inline int __inline_isfinited(double __x) {
    return __x == __x && __builtin_fabs(__x) != __builtin_inf();
}
inline int __inline_isfinitel(long double __x) {
    return __x == __x && __builtin_fabsl(__x) != __builtin_infl();
}
inline int __inline_isinff(float __x) {
    return __builtin_fabsf(__x) == __builtin_inff();
}
inline int __inline_isinfd(double __x) {
    return __builtin_fabs(__x) == __builtin_inf();
}
inline int __inline_isinfl(long double __x) {
    return __builtin_fabsl(__x) == __builtin_infl();
}
inline int __inline_isnanf(float __x) {
    return __x != __x;
}
inline int __inline_isnand(double __x) {
    return __x != __x;
}
inline int __inline_isnanl(long double __x) {
    return __x != __x;
}
inline int __inline_signbitf(float __x) {
    union { float __f; unsigned int __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 31);
}
inline int __inline_signbitd(double __x) {
    union { double __f; unsigned long long __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 63);
}

inline int __inline_signbitl(long double __x) {
    union {
        long double __ld;
        struct{ unsigned long long __m; unsigned short __sexp; } __p;
    } __u;
    __u.__ld = __x;
    return (int)(__u.__p.__sexp >> 15);
}







inline int __inline_isnormalf(float __x) {
    return __inline_isfinitef(__x) && __builtin_fabsf(__x) >= 1.17549435e-38F;
}
inline int __inline_isnormald(double __x) {
    return __inline_isfinited(__x) && __builtin_fabs(__x) >= 2.2250738585072014e-308;
}
inline int __inline_isnormall(long double __x) {
    return __inline_isfinitel(__x) && __builtin_fabsl(__x) >= 3.36210314311209350626e-4932L;
}
extern float acosf(float);
extern double acos(double);
extern long double acosl(long double);

extern float asinf(float);
extern double asin(double);
extern long double asinl(long double);

extern float atanf(float);
extern double atan(double);
extern long double atanl(long double);

extern float atan2f(float, float);
extern double atan2(double, double);
extern long double atan2l(long double, long double);

extern float cosf(float);
extern double cos(double);
extern long double cosl(long double);

extern float sinf(float);
extern double sin(double);
extern long double sinl(long double);

extern float tanf(float);
extern double tan(double);
extern long double tanl(long double);

extern float acoshf(float);
extern double acosh(double);
extern long double acoshl(long double);

extern float asinhf(float);
extern double asinh(double);
extern long double asinhl(long double);

extern float atanhf(float);
extern double atanh(double);
extern long double atanhl(long double);

extern float coshf(float);
extern double cosh(double);
extern long double coshl(long double);

extern float sinhf(float);
extern double sinh(double);
extern long double sinhl(long double);

extern float tanhf(float);
extern double tanh(double);
extern long double tanhl(long double);

extern float expf(float);
extern double exp(double);
extern long double expl(long double);

extern float exp2f(float);
extern double exp2(double);
extern long double exp2l(long double);

extern float expm1f(float);
extern double expm1(double);
extern long double expm1l(long double);

extern float logf(float);
extern double log(double);
extern long double logl(long double);

extern float log10f(float);
extern double log10(double);
extern long double log10l(long double);

extern float log2f(float);
extern double log2(double);
extern long double log2l(long double);

extern float log1pf(float);
extern double log1p(double);
extern long double log1pl(long double);

extern float logbf(float);
extern double logb(double);
extern long double logbl(long double);

extern float modff(float, float *);
extern double modf(double, double *);
extern long double modfl(long double, long double *);

extern float ldexpf(float, int);
extern double ldexp(double, int);
extern long double ldexpl(long double, int);

extern float frexpf(float, int *);
extern double frexp(double, int *);
extern long double frexpl(long double, int *);

extern int ilogbf(float);
extern int ilogb(double);
extern int ilogbl(long double);

extern float scalbnf(float, int);
extern double scalbn(double, int);
extern long double scalbnl(long double, int);

extern float scalblnf(float, long int);
extern double scalbln(double, long int);
extern long double scalblnl(long double, long int);

extern float fabsf(float);
extern double fabs(double);
extern long double fabsl(long double);

extern float cbrtf(float);
extern double cbrt(double);
extern long double cbrtl(long double);

extern float hypotf(float, float);
extern double hypot(double, double);
extern long double hypotl(long double, long double);

extern float powf(float, float);
extern double pow(double, double);
extern long double powl(long double, long double);

extern float sqrtf(float);
extern double sqrt(double);
extern long double sqrtl(long double);

extern float erff(float);
extern double erf(double);
extern long double erfl(long double);

extern float erfcf(float);
extern double erfc(double);
extern long double erfcl(long double);




extern float lgammaf(float);
extern double lgamma(double);
extern long double lgammal(long double);

extern float tgammaf(float);
extern double tgamma(double);
extern long double tgammal(long double);

extern float ceilf(float);
extern double ceil(double);
extern long double ceill(long double);

extern float floorf(float);
extern double floor(double);
extern long double floorl(long double);

extern float nearbyintf(float);
extern double nearbyint(double);
extern long double nearbyintl(long double);

extern float rintf(float);
extern double rint(double);
extern long double rintl(long double);

extern long int lrintf(float);
extern long int lrint(double);
extern long int lrintl(long double);

extern float roundf(float);
extern double round(double);
extern long double roundl(long double);

extern long int lroundf(float);
extern long int lround(double);
extern long int lroundl(long double);




extern long long int llrintf(float);
extern long long int llrint(double);
extern long long int llrintl(long double);

extern long long int llroundf(float);
extern long long int llround(double);
extern long long int llroundl(long double);


extern float truncf(float);
extern double trunc(double);
extern long double truncl(long double);

extern float fmodf(float, float);
extern double fmod(double, double);
extern long double fmodl(long double, long double);

extern float remainderf(float, float);
extern double remainder(double, double);
extern long double remainderl(long double, long double);

extern float remquof(float, float, int *);
extern double remquo(double, double, int *);
extern long double remquol(long double, long double, int *);

extern float copysignf(float, float);
extern double copysign(double, double);
extern long double copysignl(long double, long double);

extern float nanf(const char *);
extern double nan(const char *);
extern long double nanl(const char *);

extern float nextafterf(float, float);
extern double nextafter(double, double);
extern long double nextafterl(long double, long double);

extern double nexttoward(double, long double);
extern float nexttowardf(float, long double);
extern long double nexttowardl(long double, long double);

extern float fdimf(float, float);
extern double fdim(double, double);
extern long double fdiml(long double, long double);

extern float fmaxf(float, float);
extern double fmax(double, double);
extern long double fmaxl(long double, long double);

extern float fminf(float, float);
extern double fmin(double, double);
extern long double fminl(long double, long double);

extern float fmaf(float, float, float);
extern double fma(double, double, double);
extern long double fmal(long double, long double, long double);
extern float __inff(void)
                                                                                                          ;
extern double __inf(void)
                                                                                                   ;
extern long double __infl(void)
                                                                                                                ;
extern float __nan(void)
                                                                                               ;
extern float __exp10f(float) ;
extern double __exp10(double) ;





inline void __sincosf(float __x, float *__sinp, float *__cosp);
inline void __sincos(double __x, double *__sinp, double *__cosp);
extern float __cospif(float) ;
extern double __cospi(double) ;
extern float __sinpif(float) ;
extern double __sinpi(double) ;
extern float __tanpif(float) ;
extern double __tanpi(double) ;
inline void __sincospif(float __x, float *__sinp, float *__cosp);
inline void __sincospi(double __x, double *__sinp, double *__cosp);






struct __float2 { float __sinval; float __cosval; };
struct __double2 { double __sinval; double __cosval; };

extern struct __float2 __sincosf_stret(float);
extern struct __double2 __sincos_stret(double);
extern struct __float2 __sincospif_stret(float);
extern struct __double2 __sincospi_stret(double);

inline void __sincosf(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincosf_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline void __sincos(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincos_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline void __sincospif(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincospif_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline void __sincospi(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincospi_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}







extern double j0(double) ;
extern double j1(double) ;
extern double jn(int, double) ;
extern double y0(double) ;
extern double y1(double) ;
extern double yn(int, double) ;
extern double scalb(double, double);
extern int signgam;
extern long int rinttol(double)
                                                                                                   ;

extern long int roundtol(double)
                                                                                                    ;

extern double drem(double, double)
                                                                                                       ;

extern int finite(double)
                                                                                                               ;

extern double gamma(double)
                                                                                                    ;

extern double significand(double)
                                                                                                                                ;


struct exception {
    int type;
    char *name;
    double arg1;
    double arg2;
    double retval;
};


typedef enum
{
    SDL_FALSE = 0,
    SDL_TRUE = 1
} SDL_bool;







typedef int8_t Sint8;





typedef uint8_t Uint8;





typedef int16_t Sint16;





typedef uint16_t Uint16;





typedef int32_t Sint32;





typedef uint32_t Uint32;






typedef int64_t Sint64;





typedef uint64_t Uint64;
typedef int SDL_compile_time_assert_uint8[(sizeof(Uint8) == 1) * 2 - 1];
typedef int SDL_compile_time_assert_sint8[(sizeof(Sint8) == 1) * 2 - 1];
typedef int SDL_compile_time_assert_uint16[(sizeof(Uint16) == 2) * 2 - 1];
typedef int SDL_compile_time_assert_sint16[(sizeof(Sint16) == 2) * 2 - 1];
typedef int SDL_compile_time_assert_uint32[(sizeof(Uint32) == 4) * 2 - 1];
typedef int SDL_compile_time_assert_sint32[(sizeof(Sint32) == 4) * 2 - 1];
typedef int SDL_compile_time_assert_uint64[(sizeof(Uint64) == 8) * 2 - 1];
typedef int SDL_compile_time_assert_sint64[(sizeof(Sint64) == 8) * 2 - 1];
typedef enum
{
    DUMMY_ENUM_VALUE
} SDL_DUMMY_ENUM;

typedef int SDL_compile_time_assert_enum[(sizeof(SDL_DUMMY_ENUM) == sizeof(int)) * 2 - 1];





extern void * SDL_malloc(size_t size);
extern void * SDL_calloc(size_t nmemb, size_t size);
extern void * SDL_realloc(void *mem, size_t size);
extern void SDL_free(void *mem);

typedef void *( *SDL_malloc_func)(size_t size);
typedef void *( *SDL_calloc_func)(size_t nmemb, size_t size);
typedef void *( *SDL_realloc_func)(void *mem, size_t size);
typedef void ( *SDL_free_func)(void *mem);




extern void SDL_GetMemoryFunctions(SDL_malloc_func *malloc_func,
                                                    SDL_calloc_func *calloc_func,
                                                    SDL_realloc_func *realloc_func,
                                                    SDL_free_func *free_func);
extern int SDL_SetMemoryFunctions(SDL_malloc_func malloc_func,
                                                   SDL_calloc_func calloc_func,
                                                   SDL_realloc_func realloc_func,
                                                   SDL_free_func free_func);




extern int SDL_GetNumAllocations(void);

extern char * SDL_getenv(const char *name);
extern int SDL_setenv(const char *name, const char *value, int overwrite);

extern void SDL_qsort(void *base, size_t nmemb, size_t size, int (*compare) (const void *, const void *));

extern int SDL_abs(int x);






extern int SDL_isdigit(int x);
extern int SDL_isspace(int x);
extern int SDL_isupper(int x);
extern int SDL_islower(int x);
extern int SDL_toupper(int x);
extern int SDL_tolower(int x);

extern void * SDL_memset( void *dst, int c, size_t len);






 static void SDL_memset4(void *dst, Uint32 val, size_t dwords)
{

    memset_pattern4(dst, &val, dwords * 4);
}

extern void * SDL_memcpy( void *dst, const void *src, size_t len);

extern void * SDL_memmove( void *dst, const void *src, size_t len);
extern int SDL_memcmp(const void *s1, const void *s2, size_t len);

extern size_t SDL_wcslen(const wchar_t *wstr);
extern size_t SDL_wcslcpy( wchar_t *dst, const wchar_t *src, size_t maxlen);
extern size_t SDL_wcslcat( wchar_t *dst, const wchar_t *src, size_t maxlen);
extern wchar_t * SDL_wcsdup(const wchar_t *wstr);
extern wchar_t * SDL_wcsstr(const wchar_t *haystack, const wchar_t *needle);

extern int SDL_wcscmp(const wchar_t *str1, const wchar_t *str2);
extern int SDL_wcsncmp(const wchar_t *str1, const wchar_t *str2, size_t maxlen);

extern size_t SDL_strlen(const char *str);
extern size_t SDL_strlcpy( char *dst, const char *src, size_t maxlen);
extern size_t SDL_utf8strlcpy( char *dst, const char *src, size_t dst_bytes);
extern size_t SDL_strlcat( char *dst, const char *src, size_t maxlen);
extern char * SDL_strdup(const char *str);
extern char * SDL_strrev(char *str);
extern char * SDL_strupr(char *str);
extern char * SDL_strlwr(char *str);
extern char * SDL_strchr(const char *str, int c);
extern char * SDL_strrchr(const char *str, int c);
extern char * SDL_strstr(const char *haystack, const char *needle);
extern char * SDL_strtokr(char *s1, const char *s2, char **saveptr);
extern size_t SDL_utf8strlen(const char *str);

extern char * SDL_itoa(int value, char *str, int radix);
extern char * SDL_uitoa(unsigned int value, char *str, int radix);
extern char * SDL_ltoa(long value, char *str, int radix);
extern char * SDL_ultoa(unsigned long value, char *str, int radix);
extern char * SDL_lltoa(Sint64 value, char *str, int radix);
extern char * SDL_ulltoa(Uint64 value, char *str, int radix);

extern int SDL_atoi(const char *str);
extern double SDL_atof(const char *str);
extern long SDL_strtol(const char *str, char **endp, int base);
extern unsigned long SDL_strtoul(const char *str, char **endp, int base);
extern Sint64 SDL_strtoll(const char *str, char **endp, int base);
extern Uint64 SDL_strtoull(const char *str, char **endp, int base);
extern double SDL_strtod(const char *str, char **endp);

extern int SDL_strcmp(const char *str1, const char *str2);
extern int SDL_strncmp(const char *str1, const char *str2, size_t maxlen);
extern int SDL_strcasecmp(const char *str1, const char *str2);
extern int SDL_strncasecmp(const char *str1, const char *str2, size_t len);

extern int SDL_sscanf(const char *text, const char *fmt, ...) ;
extern int SDL_vsscanf(const char *text, const char *fmt, va_list ap);
extern int SDL_snprintf( char *text, size_t maxlen, const char *fmt, ... ) ;
extern int SDL_vsnprintf( char *text, size_t maxlen, const char *fmt, va_list ap);







extern double SDL_acos(double x);
extern float SDL_acosf(float x);
extern double SDL_asin(double x);
extern float SDL_asinf(float x);
extern double SDL_atan(double x);
extern float SDL_atanf(float x);
extern double SDL_atan2(double x, double y);
extern float SDL_atan2f(float x, float y);
extern double SDL_ceil(double x);
extern float SDL_ceilf(float x);
extern double SDL_copysign(double x, double y);
extern float SDL_copysignf(float x, float y);
extern double SDL_cos(double x);
extern float SDL_cosf(float x);
extern double SDL_exp(double x);
extern float SDL_expf(float x);
extern double SDL_fabs(double x);
extern float SDL_fabsf(float x);
extern double SDL_floor(double x);
extern float SDL_floorf(float x);
extern double SDL_fmod(double x, double y);
extern float SDL_fmodf(float x, float y);
extern double SDL_log(double x);
extern float SDL_logf(float x);
extern double SDL_log10(double x);
extern float SDL_log10f(float x);
extern double SDL_pow(double x, double y);
extern float SDL_powf(float x, float y);
extern double SDL_scalbn(double x, int n);
extern float SDL_scalbnf(float x, int n);
extern double SDL_sin(double x);
extern float SDL_sinf(float x);
extern double SDL_sqrt(double x);
extern float SDL_sqrtf(float x);
extern double SDL_tan(double x);
extern float SDL_tanf(float x);
typedef struct _SDL_iconv_t *SDL_iconv_t;
extern SDL_iconv_t SDL_iconv_open(const char *tocode,
                                                   const char *fromcode);
extern int SDL_iconv_close(SDL_iconv_t cd);
extern size_t SDL_iconv(SDL_iconv_t cd, const char **inbuf,
                                         size_t * inbytesleft, char **outbuf,
                                         size_t * outbytesleft);




extern char * SDL_iconv_string(const char *tocode,
                                               const char *fromcode,
                                               const char *inbuf,
                                               size_t inbytesleft);
 static void *SDL_memcpy4( void *dst, const void *src, size_t dwords)
{
    return SDL_memcpy(dst, src, dwords * 4);
}













typedef int (*SDL_main_func)(int argc, char *argv[]);
extern int SDL_main(int argc, char *argv[]);
extern void SDL_SetMainReady(void);

typedef enum
{
    SDL_ASSERTION_RETRY,
    SDL_ASSERTION_BREAK,
    SDL_ASSERTION_ABORT,
    SDL_ASSERTION_IGNORE,
    SDL_ASSERTION_ALWAYS_IGNORE
} SDL_AssertState;

typedef struct SDL_AssertData
{
    int always_ignore;
    unsigned int trigger_count;
    const char *condition;
    const char *filename;
    int linenum;
    const char *function;
    const struct SDL_AssertData *next;
} SDL_AssertData;




extern SDL_AssertState SDL_ReportAssertion(SDL_AssertData *,
                                                             const char *,
                                                             const char *, int)
;
typedef SDL_AssertState ( *SDL_AssertionHandler)(
                                 const SDL_AssertData* data, void* userdata);
extern void SDL_SetAssertionHandler(
                                            SDL_AssertionHandler handler,
                                            void *userdata);
extern SDL_AssertionHandler SDL_GetDefaultAssertionHandler(void);
extern SDL_AssertionHandler SDL_GetAssertionHandler(void **puserdata);
extern const SDL_AssertData * SDL_GetAssertionReport(void);
extern void SDL_ResetAssertionReport(void);
typedef int SDL_SpinLock;
extern SDL_bool SDL_AtomicTryLock(SDL_SpinLock *lock);






extern void SDL_AtomicLock(SDL_SpinLock *lock);






extern void SDL_AtomicUnlock(SDL_SpinLock *lock);
extern void SDL_MemoryBarrierReleaseFunction(void);
extern void SDL_MemoryBarrierAcquireFunction(void);
typedef struct { int value; } SDL_atomic_t;
extern SDL_bool SDL_AtomicCAS(SDL_atomic_t *a, int oldval, int newval);






extern int SDL_AtomicSet(SDL_atomic_t *a, int v);




extern int SDL_AtomicGet(SDL_atomic_t *a);
extern int SDL_AtomicAdd(SDL_atomic_t *a, int v);
extern SDL_bool SDL_AtomicCASPtr(void **a, void *oldval, void *newval);






extern void* SDL_AtomicSetPtr(void **a, void* v);




extern void* SDL_AtomicGetPtr(void **a);














extern int SDL_SetError( const char *fmt, ...) ;
extern const char * SDL_GetError(void);
extern void SDL_ClearError(void);
typedef enum
{
    SDL_ENOMEM,
    SDL_EFREAD,
    SDL_EFWRITE,
    SDL_EFSEEK,
    SDL_UNSUPPORTED,
    SDL_LASTERROR
} SDL_errorcode;

extern int SDL_Error(SDL_errorcode code);







 static Uint16
SDL_Swap16(Uint16 x)
{
  __asm__("xchgb %b0,%h0": "=Q"(x):"0"(x));
    return x;
}
 static Uint32
SDL_Swap32(Uint32 x)
{
  __asm__("bswapl %0": "=r"(x):"0"(x));
    return x;
}
 static Uint64
SDL_Swap64(Uint64 x)
{
  __asm__("bswapq %0": "=r"(x):"0"(x));
    return x;
}
 static float
SDL_SwapFloat(float x)
{
    union
    {
        float f;
        Uint32 ui32;
    } swapper;
    swapper.f = x;
    swapper.ui32 = SDL_Swap32(swapper.ui32);
    return swapper.f;
}
struct SDL_mutex;
typedef struct SDL_mutex SDL_mutex;




extern SDL_mutex * SDL_CreateMutex(void);







extern int SDL_LockMutex(SDL_mutex * mutex);






extern int SDL_TryLockMutex(SDL_mutex * mutex);
extern int SDL_UnlockMutex(SDL_mutex * mutex);




extern void SDL_DestroyMutex(SDL_mutex * mutex);
struct SDL_semaphore;
typedef struct SDL_semaphore SDL_sem;




extern SDL_sem * SDL_CreateSemaphore(Uint32 initial_value);




extern void SDL_DestroySemaphore(SDL_sem * sem);






extern int SDL_SemWait(SDL_sem * sem);







extern int SDL_SemTryWait(SDL_sem * sem);
extern int SDL_SemWaitTimeout(SDL_sem * sem, Uint32 ms);






extern int SDL_SemPost(SDL_sem * sem);




extern Uint32 SDL_SemValue(SDL_sem * sem);
struct SDL_cond;
typedef struct SDL_cond SDL_cond;
extern SDL_cond * SDL_CreateCond(void);




extern void SDL_DestroyCond(SDL_cond * cond);






extern int SDL_CondSignal(SDL_cond * cond);






extern int SDL_CondBroadcast(SDL_cond * cond);
extern int SDL_CondWait(SDL_cond * cond, SDL_mutex * mutex);
extern int SDL_CondWaitTimeout(SDL_cond * cond,
                                                SDL_mutex * mutex, Uint32 ms);






struct SDL_Thread;
typedef struct SDL_Thread SDL_Thread;


typedef unsigned long SDL_threadID;


typedef unsigned int SDL_TLSID;






typedef enum {
    SDL_THREAD_PRIORITY_LOW,
    SDL_THREAD_PRIORITY_NORMAL,
    SDL_THREAD_PRIORITY_HIGH,
    SDL_THREAD_PRIORITY_TIME_CRITICAL
} SDL_ThreadPriority;





typedef int ( * SDL_ThreadFunction) (void *data);
extern SDL_Thread *
SDL_CreateThread(SDL_ThreadFunction fn, const char *name, void *data);
extern SDL_Thread *
SDL_CreateThreadWithStackSize(SDL_ThreadFunction fn, const char *name, const size_t stacksize, void *data);
extern const char * SDL_GetThreadName(SDL_Thread *thread);




extern SDL_threadID SDL_ThreadID(void);






extern SDL_threadID SDL_GetThreadID(SDL_Thread * thread);




extern int SDL_SetThreadPriority(SDL_ThreadPriority priority);
extern void SDL_WaitThread(SDL_Thread * thread, int *status);
extern void SDL_DetachThread(SDL_Thread * thread);
extern SDL_TLSID SDL_TLSCreate(void);
extern void * SDL_TLSGet(SDL_TLSID id);
extern int SDL_TLSSet(SDL_TLSID id, const void *value, void ( *destructor)(void*));







typedef struct SDL_RWops
{



    Sint64 ( * size) (struct SDL_RWops * context);







    Sint64 ( * seek) (struct SDL_RWops * context, Sint64 offset,
                             int whence);







    size_t ( * read) (struct SDL_RWops * context, void *ptr,
                             size_t size, size_t maxnum);







    size_t ( * write) (struct SDL_RWops * context, const void *ptr,
                              size_t size, size_t num);






    int ( * close) (struct SDL_RWops * context);

    Uint32 type;
    union
    {
        struct
        {
            SDL_bool autoclose;
            FILE *fp;
        } stdio;

        struct
        {
            Uint8 *base;
            Uint8 *here;
            Uint8 *stop;
        } mem;
        struct
        {
            void *data1;
            void *data2;
        } unknown;
    } hidden;

} SDL_RWops;
extern SDL_RWops * SDL_RWFromFile(const char *file,
                                                  const char *mode);


extern SDL_RWops * SDL_RWFromFP(FILE * fp,
                                                SDL_bool autoclose);





extern SDL_RWops * SDL_RWFromMem(void *mem, int size);
extern SDL_RWops * SDL_RWFromConstMem(const void *mem,
                                                      int size);




extern SDL_RWops * SDL_AllocRW(void);
extern void SDL_FreeRW(SDL_RWops * area);
extern Sint64 SDL_RWsize(SDL_RWops *context);







extern Sint64 SDL_RWseek(SDL_RWops *context,
                                          Sint64 offset, int whence);




extern Sint64 SDL_RWtell(SDL_RWops *context);







extern size_t SDL_RWread(SDL_RWops *context,
                                          void *ptr, size_t size, size_t maxnum);







extern size_t SDL_RWwrite(SDL_RWops *context,
                                           const void *ptr, size_t size, size_t num);






extern int SDL_RWclose(SDL_RWops *context);
extern void * SDL_LoadFile_RW(SDL_RWops * src, size_t *datasize,
                                                    int freesrc);
extern void * SDL_LoadFile(const char *file, size_t *datasize);







extern Uint8 SDL_ReadU8(SDL_RWops * src);
extern Uint16 SDL_ReadLE16(SDL_RWops * src);
extern Uint16 SDL_ReadBE16(SDL_RWops * src);
extern Uint32 SDL_ReadLE32(SDL_RWops * src);
extern Uint32 SDL_ReadBE32(SDL_RWops * src);
extern Uint64 SDL_ReadLE64(SDL_RWops * src);
extern Uint64 SDL_ReadBE64(SDL_RWops * src);
extern size_t SDL_WriteU8(SDL_RWops * dst, Uint8 value);
extern size_t SDL_WriteLE16(SDL_RWops * dst, Uint16 value);
extern size_t SDL_WriteBE16(SDL_RWops * dst, Uint16 value);
extern size_t SDL_WriteLE32(SDL_RWops * dst, Uint32 value);
extern size_t SDL_WriteBE32(SDL_RWops * dst, Uint32 value);
extern size_t SDL_WriteLE64(SDL_RWops * dst, Uint64 value);
extern size_t SDL_WriteBE64(SDL_RWops * dst, Uint64 value);








typedef Uint16 SDL_AudioFormat;
typedef void ( * SDL_AudioCallback) (void *userdata, Uint8 * stream,
                                            int len);
typedef struct SDL_AudioSpec
{
    int freq;
    SDL_AudioFormat format;
    Uint8 channels;
    Uint8 silence;
    Uint16 samples;
    Uint16 padding;
    Uint32 size;
    SDL_AudioCallback callback;
    void *userdata;
} SDL_AudioSpec;


struct SDL_AudioCVT;
typedef void ( * SDL_AudioFilter) (struct SDL_AudioCVT * cvt,
                                          SDL_AudioFormat format);
typedef struct SDL_AudioCVT
{
    int needed;
    SDL_AudioFormat src_format;
    SDL_AudioFormat dst_format;
    double rate_incr;
    Uint8 *buf;
    int len;
    int len_cvt;
    int len_mult;
    double len_ratio;
    SDL_AudioFilter filters[9 + 1];
    int filter_index;
} SDL_AudioCVT;
extern int SDL_GetNumAudioDrivers(void);
extern const char * SDL_GetAudioDriver(int index);
extern int SDL_AudioInit(const char *driver_name);
extern void SDL_AudioQuit(void);






extern const char * SDL_GetCurrentAudioDriver(void);
extern int SDL_OpenAudio(SDL_AudioSpec * desired,
                                          SDL_AudioSpec * obtained);
typedef Uint32 SDL_AudioDeviceID;
extern int SDL_GetNumAudioDevices(int iscapture);
extern const char * SDL_GetAudioDeviceName(int index,
                                                           int iscapture);
extern SDL_AudioDeviceID SDL_OpenAudioDevice(const char
                                                              *device,
                                                              int iscapture,
                                                              const
                                                              SDL_AudioSpec *
                                                              desired,
                                                              SDL_AudioSpec *
                                                              obtained,
                                                              int
                                                              allowed_changes);
typedef enum
{
    SDL_AUDIO_STOPPED = 0,
    SDL_AUDIO_PLAYING,
    SDL_AUDIO_PAUSED
} SDL_AudioStatus;
extern SDL_AudioStatus SDL_GetAudioStatus(void);

extern SDL_AudioStatus
SDL_GetAudioDeviceStatus(SDL_AudioDeviceID dev);
extern void SDL_PauseAudio(int pause_on);
extern void SDL_PauseAudioDevice(SDL_AudioDeviceID dev,
                                                  int pause_on);
extern SDL_AudioSpec * SDL_LoadWAV_RW(SDL_RWops * src,
                                                      int freesrc,
                                                      SDL_AudioSpec * spec,
                                                      Uint8 ** audio_buf,
                                                      Uint32 * audio_len);
extern void SDL_FreeWAV(Uint8 * audio_buf);
extern int SDL_BuildAudioCVT(SDL_AudioCVT * cvt,
                                              SDL_AudioFormat src_format,
                                              Uint8 src_channels,
                                              int src_rate,
                                              SDL_AudioFormat dst_format,
                                              Uint8 dst_channels,
                                              int dst_rate);
extern int SDL_ConvertAudio(SDL_AudioCVT * cvt);
struct _SDL_AudioStream;
typedef struct _SDL_AudioStream SDL_AudioStream;
extern SDL_AudioStream * SDL_NewAudioStream(const SDL_AudioFormat src_format,
                                           const Uint8 src_channels,
                                           const int src_rate,
                                           const SDL_AudioFormat dst_format,
                                           const Uint8 dst_channels,
                                           const int dst_rate);
extern int SDL_AudioStreamPut(SDL_AudioStream *stream, const void *buf, int len);
extern int SDL_AudioStreamGet(SDL_AudioStream *stream, void *buf, int len);
extern int SDL_AudioStreamAvailable(SDL_AudioStream *stream);
extern int SDL_AudioStreamFlush(SDL_AudioStream *stream);
extern void SDL_AudioStreamClear(SDL_AudioStream *stream);
extern void SDL_FreeAudioStream(SDL_AudioStream *stream);
extern void SDL_MixAudio(Uint8 * dst, const Uint8 * src,
                                          Uint32 len, int volume);






extern void SDL_MixAudioFormat(Uint8 * dst,
                                                const Uint8 * src,
                                                SDL_AudioFormat format,
                                                Uint32 len, int volume);
extern int SDL_QueueAudio(SDL_AudioDeviceID dev, const void *data, Uint32 len);
extern Uint32 SDL_DequeueAudio(SDL_AudioDeviceID dev, void *data, Uint32 len);
extern Uint32 SDL_GetQueuedAudioSize(SDL_AudioDeviceID dev);
extern void SDL_ClearQueuedAudio(SDL_AudioDeviceID dev);
extern void SDL_LockAudio(void);
extern void SDL_LockAudioDevice(SDL_AudioDeviceID dev);
extern void SDL_UnlockAudio(void);
extern void SDL_UnlockAudioDevice(SDL_AudioDeviceID dev);





extern void SDL_CloseAudio(void);
extern void SDL_CloseAudioDevice(SDL_AudioDeviceID dev);






extern int SDL_SetClipboardText(const char *text);






extern char * SDL_GetClipboardText(void);






extern SDL_bool SDL_HasClipboardText(void);







typedef long long __m64 ;

typedef long long __v1di ;
typedef int __v2si ;
typedef short __v4hi ;
typedef char __v8qi ;
static void
_mm_empty(void)
{
    __builtin_ia32_emms();
}
static __m64
_mm_cvtsi32_si64(int __i)
{
    return (__m64)__builtin_ia32_vec_init_v2si(__i, 0);
}
static int
_mm_cvtsi64_si32(__m64 __m)
{
    return __builtin_ia32_vec_ext_v2si((__v2si)__m, 0);
}
static __m64
_mm_cvtsi64_m64(long long __i)
{
    return (__m64)__i;
}
static long long
_mm_cvtm64_si64(__m64 __m)
{
    return (long long)__m;
}
static __m64
_mm_packs_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_packsswb((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_packs_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_packssdw((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_packs_pu16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_packuswb((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_unpackhi_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpckhbw((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_unpackhi_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpckhwd((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_unpackhi_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpckhdq((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_unpacklo_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpcklbw((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_unpacklo_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpcklwd((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_unpacklo_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_punpckldq((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_add_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_add_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_add_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddd((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_adds_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddsb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_adds_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddsw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_adds_pu8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddusb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_adds_pu16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_paddusw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_sub_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_sub_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_sub_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubd((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_subs_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubsb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_subs_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubsw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_subs_pu8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubusb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_subs_pu16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_psubusw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_madd_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pmaddwd((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_mulhi_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pmulhw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_mullo_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pmullw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_sll_pi16(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psllw((__v4hi)__m, __count);
}
static __m64
_mm_slli_pi16(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psllwi((__v4hi)__m, __count);
}
static __m64
_mm_sll_pi32(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_pslld((__v2si)__m, __count);
}
static __m64
_mm_slli_pi32(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_pslldi((__v2si)__m, __count);
}
static __m64
_mm_sll_si64(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psllq((__v1di)__m, __count);
}
static __m64
_mm_slli_si64(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psllqi((__v1di)__m, __count);
}
static __m64
_mm_sra_pi16(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psraw((__v4hi)__m, __count);
}
static __m64
_mm_srai_pi16(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psrawi((__v4hi)__m, __count);
}
static __m64
_mm_sra_pi32(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psrad((__v2si)__m, __count);
}
static __m64
_mm_srai_pi32(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psradi((__v2si)__m, __count);
}
static __m64
_mm_srl_pi16(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psrlw((__v4hi)__m, __count);
}
static __m64
_mm_srli_pi16(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psrlwi((__v4hi)__m, __count);
}
static __m64
_mm_srl_pi32(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psrld((__v2si)__m, __count);
}
static __m64
_mm_srli_pi32(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psrldi((__v2si)__m, __count);
}
static __m64
_mm_srl_si64(__m64 __m, __m64 __count)
{
    return (__m64)__builtin_ia32_psrlq((__v1di)__m, __count);
}
static __m64
_mm_srli_si64(__m64 __m, int __count)
{
    return (__m64)__builtin_ia32_psrlqi((__v1di)__m, __count);
}
static __m64
_mm_and_si64(__m64 __m1, __m64 __m2)
{
    return __builtin_ia32_pand((__v1di)__m1, (__v1di)__m2);
}
static __m64
_mm_andnot_si64(__m64 __m1, __m64 __m2)
{
    return __builtin_ia32_pandn((__v1di)__m1, (__v1di)__m2);
}
static __m64
_mm_or_si64(__m64 __m1, __m64 __m2)
{
    return __builtin_ia32_por((__v1di)__m1, (__v1di)__m2);
}
static __m64
_mm_xor_si64(__m64 __m1, __m64 __m2)
{
    return __builtin_ia32_pxor((__v1di)__m1, (__v1di)__m2);
}
static __m64
_mm_cmpeq_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpeqb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_cmpeq_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpeqw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_cmpeq_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpeqd((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_cmpgt_pi8(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpgtb((__v8qi)__m1, (__v8qi)__m2);
}
static __m64
_mm_cmpgt_pi16(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpgtw((__v4hi)__m1, (__v4hi)__m2);
}
static __m64
_mm_cmpgt_pi32(__m64 __m1, __m64 __m2)
{
    return (__m64)__builtin_ia32_pcmpgtd((__v2si)__m1, (__v2si)__m2);
}
static __m64
_mm_setzero_si64(void)
{
    return __extension__ (__m64){ 0LL };
}
static __m64
_mm_set_pi32(int __i1, int __i0)
{
    return (__m64)__builtin_ia32_vec_init_v2si(__i0, __i1);
}
static __m64
_mm_set_pi16(short __s3, short __s2, short __s1, short __s0)
{
    return (__m64)__builtin_ia32_vec_init_v4hi(__s0, __s1, __s2, __s3);
}
static __m64
_mm_set_pi8(char __b7, char __b6, char __b5, char __b4, char __b3, char __b2,
            char __b1, char __b0)
{
    return (__m64)__builtin_ia32_vec_init_v8qi(__b0, __b1, __b2, __b3,
                                               __b4, __b5, __b6, __b7);
}
static __m64
_mm_set1_pi32(int __i)
{
    return _mm_set_pi32(__i, __i);
}
static __m64
_mm_set1_pi16(short __w)
{
    return _mm_set_pi16(__w, __w, __w, __w);
}
static __m64
_mm_set1_pi8(char __b)
{
    return _mm_set_pi8(__b, __b, __b, __b, __b, __b, __b, __b);
}
static __m64
_mm_setr_pi32(int __i0, int __i1)
{
    return _mm_set_pi32(__i1, __i0);
}
static __m64
_mm_setr_pi16(short __w0, short __w1, short __w2, short __w3)
{
    return _mm_set_pi16(__w3, __w2, __w1, __w0);
}
static __m64
_mm_setr_pi8(char __b0, char __b1, char __b2, char __b3, char __b4, char __b5,
             char __b6, char __b7)
{
    return _mm_set_pi8(__b7, __b6, __b5, __b4, __b3, __b2, __b1, __b0);
}


typedef int __v4si ;
typedef float __v4sf ;
typedef float __m128 ;

typedef float __m128_u ;


typedef unsigned int __v4su ;





extern int posix_memalign(void **__memptr, size_t __alignment, size_t __size);
static void *

_mm_malloc(size_t __size, size_t __align)
{
  if (__align == 1) {
    return malloc(__size);
  }

  if (!(__align & (__align - 1)) && __align < sizeof(void *))
    __align = sizeof(void *);

  void *__mallocedMemory;





  if (posix_memalign(&__mallocedMemory, __align, __size))
    return 0;


  return __mallocedMemory;
}

static void
_mm_free(void *__p)
{
  free(__p);
}
static __m128
_mm_add_ss(__m128 __a, __m128 __b)
{
  __a[0] += __b[0];
  return __a;
}
static __m128
_mm_add_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4sf)__a + (__v4sf)__b);
}
static __m128
_mm_sub_ss(__m128 __a, __m128 __b)
{
  __a[0] -= __b[0];
  return __a;
}
static __m128
_mm_sub_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4sf)__a - (__v4sf)__b);
}
static __m128
_mm_mul_ss(__m128 __a, __m128 __b)
{
  __a[0] *= __b[0];
  return __a;
}
static __m128
_mm_mul_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4sf)__a * (__v4sf)__b);
}
static __m128
_mm_div_ss(__m128 __a, __m128 __b)
{
  __a[0] /= __b[0];
  return __a;
}
static __m128
_mm_div_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4sf)__a / (__v4sf)__b);
}
static __m128
_mm_sqrt_ss(__m128 __a)
{
  return (__m128)__builtin_ia32_sqrtss((__v4sf)__a);
}
static __m128
_mm_sqrt_ps(__m128 __a)
{
  return __builtin_ia32_sqrtps((__v4sf)__a);
}
static __m128
_mm_rcp_ss(__m128 __a)
{
  return (__m128)__builtin_ia32_rcpss((__v4sf)__a);
}
static __m128
_mm_rcp_ps(__m128 __a)
{
  return (__m128)__builtin_ia32_rcpps((__v4sf)__a);
}
static __m128
_mm_rsqrt_ss(__m128 __a)
{
  return __builtin_ia32_rsqrtss((__v4sf)__a);
}
static __m128
_mm_rsqrt_ps(__m128 __a)
{
  return __builtin_ia32_rsqrtps((__v4sf)__a);
}
static __m128
_mm_min_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_minss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_min_ps(__m128 __a, __m128 __b)
{
  return __builtin_ia32_minps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_max_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_maxss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_max_ps(__m128 __a, __m128 __b)
{
  return __builtin_ia32_maxps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_and_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4su)__a & (__v4su)__b);
}
static __m128
_mm_andnot_ps(__m128 __a, __m128 __b)
{
  return (__m128)(~(__v4su)__a & (__v4su)__b);
}
static __m128
_mm_or_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4su)__a | (__v4su)__b);
}
static __m128
_mm_xor_ps(__m128 __a, __m128 __b)
{
  return (__m128)((__v4su)__a ^ (__v4su)__b);
}
static __m128
_mm_cmpeq_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpeqss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpeq_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpeqps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmplt_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpltss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmplt_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpltps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmple_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpless((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmple_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpleps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpgt_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_shufflevector((__v4sf)__a,
                                         (__v4sf)__builtin_ia32_cmpltss((__v4sf)__b, (__v4sf)__a),
                                         4, 1, 2, 3);
}
static __m128
_mm_cmpgt_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpltps((__v4sf)__b, (__v4sf)__a);
}
static __m128
_mm_cmpge_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_shufflevector((__v4sf)__a,
                                         (__v4sf)__builtin_ia32_cmpless((__v4sf)__b, (__v4sf)__a),
                                         4, 1, 2, 3);
}
static __m128
_mm_cmpge_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpleps((__v4sf)__b, (__v4sf)__a);
}
static __m128
_mm_cmpneq_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpneqss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpneq_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpneqps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpnlt_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnltss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpnlt_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnltps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpnle_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnless((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpnle_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnleps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpngt_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_shufflevector((__v4sf)__a,
                                         (__v4sf)__builtin_ia32_cmpnltss((__v4sf)__b, (__v4sf)__a),
                                         4, 1, 2, 3);
}
static __m128
_mm_cmpngt_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnltps((__v4sf)__b, (__v4sf)__a);
}
static __m128
_mm_cmpnge_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_shufflevector((__v4sf)__a,
                                         (__v4sf)__builtin_ia32_cmpnless((__v4sf)__b, (__v4sf)__a),
                                         4, 1, 2, 3);
}
static __m128
_mm_cmpnge_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpnleps((__v4sf)__b, (__v4sf)__a);
}
static __m128
_mm_cmpord_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpordss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpord_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpordps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpunord_ss(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpunordss((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_cmpunord_ps(__m128 __a, __m128 __b)
{
  return (__m128)__builtin_ia32_cmpunordps((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comieq_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comieq((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comilt_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comilt((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comile_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comile((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comigt_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comigt((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comige_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comige((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_comineq_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_comineq((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomieq_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomieq((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomilt_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomilt((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomile_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomile((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomigt_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomigt((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomige_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomige((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_ucomineq_ss(__m128 __a, __m128 __b)
{
  return __builtin_ia32_ucomineq((__v4sf)__a, (__v4sf)__b);
}
static int
_mm_cvtss_si32(__m128 __a)
{
  return __builtin_ia32_cvtss2si((__v4sf)__a);
}
static int
_mm_cvt_ss2si(__m128 __a)
{
  return _mm_cvtss_si32(__a);
}
static long long
_mm_cvtss_si64(__m128 __a)
{
  return __builtin_ia32_cvtss2si64((__v4sf)__a);
}
static __m64
_mm_cvtps_pi32(__m128 __a)
{
  return (__m64)__builtin_ia32_cvtps2pi((__v4sf)__a);
}
static __m64
_mm_cvt_ps2pi(__m128 __a)
{
  return _mm_cvtps_pi32(__a);
}
static int
_mm_cvttss_si32(__m128 __a)
{
  return __builtin_ia32_cvttss2si((__v4sf)__a);
}
static int
_mm_cvtt_ss2si(__m128 __a)
{
  return _mm_cvttss_si32(__a);
}
static long long
_mm_cvttss_si64(__m128 __a)
{
  return __builtin_ia32_cvttss2si64((__v4sf)__a);
}
static __m64
_mm_cvttps_pi32(__m128 __a)
{
  return (__m64)__builtin_ia32_cvttps2pi((__v4sf)__a);
}
static __m64
_mm_cvtt_ps2pi(__m128 __a)
{
  return _mm_cvttps_pi32(__a);
}
static __m128
_mm_cvtsi32_ss(__m128 __a, int __b)
{
  __a[0] = __b;
  return __a;
}
static __m128
_mm_cvt_si2ss(__m128 __a, int __b)
{
  return _mm_cvtsi32_ss(__a, __b);
}
static __m128
_mm_cvtsi64_ss(__m128 __a, long long __b)
{
  __a[0] = __b;
  return __a;
}
static __m128
_mm_cvtpi32_ps(__m128 __a, __m64 __b)
{
  return __builtin_ia32_cvtpi2ps((__v4sf)__a, (__v2si)__b);
}
static __m128
_mm_cvt_pi2ps(__m128 __a, __m64 __b)
{
  return _mm_cvtpi32_ps(__a, __b);
}
static float
_mm_cvtss_f32(__m128 __a)
{
  return __a[0];
}
static __m128
_mm_loadh_pi(__m128 __a, const __m64 *__p)
{
  typedef float __mm_loadh_pi_v2f32 ;
  struct __mm_loadh_pi_struct {
    __mm_loadh_pi_v2f32 __u;
  } ;
  __mm_loadh_pi_v2f32 __b = ((struct __mm_loadh_pi_struct*)__p)->__u;
  __m128 __bb = __builtin_shufflevector(__b, __b, 0, 1, 0, 1);
  return __builtin_shufflevector(__a, __bb, 0, 1, 4, 5);
}
static __m128
_mm_loadl_pi(__m128 __a, const __m64 *__p)
{
  typedef float __mm_loadl_pi_v2f32 ;
  struct __mm_loadl_pi_struct {
    __mm_loadl_pi_v2f32 __u;
  } ;
  __mm_loadl_pi_v2f32 __b = ((struct __mm_loadl_pi_struct*)__p)->__u;
  __m128 __bb = __builtin_shufflevector(__b, __b, 0, 1, 0, 1);
  return __builtin_shufflevector(__a, __bb, 4, 5, 2, 3);
}
static __m128
_mm_load_ss(const float *__p)
{
  struct __mm_load_ss_struct {
    float __u;
  } ;
  float __u = ((struct __mm_load_ss_struct*)__p)->__u;
  return __extension__ (__m128){ __u, 0, 0, 0 };
}
static __m128
_mm_load1_ps(const float *__p)
{
  struct __mm_load1_ps_struct {
    float __u;
  } ;
  float __u = ((struct __mm_load1_ps_struct*)__p)->__u;
  return __extension__ (__m128){ __u, __u, __u, __u };
}
static __m128
_mm_load_ps(const float *__p)
{
  return *(__m128*)__p;
}
static __m128
_mm_loadu_ps(const float *__p)
{
  struct __loadu_ps {
    __m128_u __v;
  } ;
  return ((struct __loadu_ps*)__p)->__v;
}
static __m128
_mm_loadr_ps(const float *__p)
{
  __m128 __a = _mm_load_ps(__p);
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 3, 2, 1, 0);
}
static __m128
_mm_undefined_ps(void)
{
  return (__m128)__builtin_ia32_undef128();
}
static __m128
_mm_set_ss(float __w)
{
  return __extension__ (__m128){ __w, 0, 0, 0 };
}
static __m128
_mm_set1_ps(float __w)
{
  return __extension__ (__m128){ __w, __w, __w, __w };
}
static __m128
_mm_set_ps1(float __w)
{
    return _mm_set1_ps(__w);
}
static __m128
_mm_set_ps(float __z, float __y, float __x, float __w)
{
  return __extension__ (__m128){ __w, __x, __y, __z };
}
static __m128
_mm_setr_ps(float __z, float __y, float __x, float __w)
{
  return __extension__ (__m128){ __z, __y, __x, __w };
}
static __m128
_mm_setzero_ps(void)
{
  return __extension__ (__m128){ 0, 0, 0, 0 };
}
static void
_mm_storeh_pi(__m64 *__p, __m128 __a)
{
  __builtin_ia32_storehps((__v2si *)__p, (__v4sf)__a);
}
static void
_mm_storel_pi(__m64 *__p, __m128 __a)
{
  __builtin_ia32_storelps((__v2si *)__p, (__v4sf)__a);
}
static void
_mm_store_ss(float *__p, __m128 __a)
{
  struct __mm_store_ss_struct {
    float __u;
  } ;
  ((struct __mm_store_ss_struct*)__p)->__u = __a[0];
}
static void
_mm_storeu_ps(float *__p, __m128 __a)
{
  struct __storeu_ps {
    __m128_u __v;
  } ;
  ((struct __storeu_ps*)__p)->__v = __a;
}
static void
_mm_store_ps(float *__p, __m128 __a)
{
  *(__m128*)__p = __a;
}
static void
_mm_store1_ps(float *__p, __m128 __a)
{
  __a = __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 0, 0, 0, 0);
  _mm_store_ps(__p, __a);
}
static void
_mm_store_ps1(float *__p, __m128 __a)
{
  _mm_store1_ps(__p, __a);
}
static void
_mm_storer_ps(float *__p, __m128 __a)
{
  __a = __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 3, 2, 1, 0);
  _mm_store_ps(__p, __a);
}
static void
_mm_stream_pi(__m64 *__p, __m64 __a)
{
  __builtin_ia32_movntq(__p, __a);
}
static void
_mm_stream_ps(float *__p, __m128 __a)
{
  __builtin_nontemporal_store((__v4sf)__a, (__v4sf*)__p);
}
void _mm_sfence(void);
static __m64
_mm_max_pi16(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pmaxsw((__v4hi)__a, (__v4hi)__b);
}
static __m64
_mm_max_pu8(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pmaxub((__v8qi)__a, (__v8qi)__b);
}
static __m64
_mm_min_pi16(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pminsw((__v4hi)__a, (__v4hi)__b);
}
static __m64
_mm_min_pu8(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pminub((__v8qi)__a, (__v8qi)__b);
}
static int
_mm_movemask_pi8(__m64 __a)
{
  return __builtin_ia32_pmovmskb((__v8qi)__a);
}
static __m64
_mm_mulhi_pu16(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pmulhuw((__v4hi)__a, (__v4hi)__b);
}
static void
_mm_maskmove_si64(__m64 __d, __m64 __n, char *__p)
{
  __builtin_ia32_maskmovq((__v8qi)__d, (__v8qi)__n, __p);
}
static __m64
_mm_avg_pu8(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pavgb((__v8qi)__a, (__v8qi)__b);
}
static __m64
_mm_avg_pu16(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_pavgw((__v4hi)__a, (__v4hi)__b);
}
static __m64
_mm_sad_pu8(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_psadbw((__v8qi)__a, (__v8qi)__b);
}
unsigned int _mm_getcsr(void);
void _mm_setcsr(unsigned int __i);
static __m128
_mm_unpackhi_ps(__m128 __a, __m128 __b)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__b, 2, 6, 3, 7);
}
static __m128
_mm_unpacklo_ps(__m128 __a, __m128 __b)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__b, 0, 4, 1, 5);
}
static __m128
_mm_move_ss(__m128 __a, __m128 __b)
{
  __a[0] = __b[0];
  return __a;
}
static __m128
_mm_movehl_ps(__m128 __a, __m128 __b)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__b, 6, 7, 2, 3);
}
static __m128
_mm_movelh_ps(__m128 __a, __m128 __b)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__b, 0, 1, 4, 5);
}
static __m128
_mm_cvtpi16_ps(__m64 __a)
{
  __m64 __b, __c;
  __m128 __r;

  __b = _mm_setzero_si64();
  __b = _mm_cmpgt_pi16(__b, __a);
  __c = _mm_unpackhi_pi16(__a, __b);
  __r = _mm_setzero_ps();
  __r = _mm_cvtpi32_ps(__r, __c);
  __r = _mm_movelh_ps(__r, __r);
  __c = _mm_unpacklo_pi16(__a, __b);
  __r = _mm_cvtpi32_ps(__r, __c);

  return __r;
}
static __m128
_mm_cvtpu16_ps(__m64 __a)
{
  __m64 __b, __c;
  __m128 __r;

  __b = _mm_setzero_si64();
  __c = _mm_unpackhi_pi16(__a, __b);
  __r = _mm_setzero_ps();
  __r = _mm_cvtpi32_ps(__r, __c);
  __r = _mm_movelh_ps(__r, __r);
  __c = _mm_unpacklo_pi16(__a, __b);
  __r = _mm_cvtpi32_ps(__r, __c);

  return __r;
}
static __m128
_mm_cvtpi8_ps(__m64 __a)
{
  __m64 __b;

  __b = _mm_setzero_si64();
  __b = _mm_cmpgt_pi8(__b, __a);
  __b = _mm_unpacklo_pi8(__a, __b);

  return _mm_cvtpi16_ps(__b);
}
static __m128
_mm_cvtpu8_ps(__m64 __a)
{
  __m64 __b;

  __b = _mm_setzero_si64();
  __b = _mm_unpacklo_pi8(__a, __b);

  return _mm_cvtpi16_ps(__b);
}
static __m128
_mm_cvtpi32x2_ps(__m64 __a, __m64 __b)
{
  __m128 __c;

  __c = _mm_setzero_ps();
  __c = _mm_cvtpi32_ps(__c, __b);
  __c = _mm_movelh_ps(__c, __c);

  return _mm_cvtpi32_ps(__c, __a);
}
static __m64
_mm_cvtps_pi16(__m128 __a)
{
  __m64 __b, __c;

  __b = _mm_cvtps_pi32(__a);
  __a = _mm_movehl_ps(__a, __a);
  __c = _mm_cvtps_pi32(__a);

  return _mm_packs_pi32(__b, __c);
}
static __m64
_mm_cvtps_pi8(__m128 __a)
{
  __m64 __b, __c;

  __b = _mm_cvtps_pi16(__a);
  __c = _mm_setzero_si64();

  return _mm_packs_pi16(__b, __c);
}
static int
_mm_movemask_ps(__m128 __a)
{
  return __builtin_ia32_movmskps((__v4sf)__a);
}

typedef double __m128d ;
typedef long long __m128i ;

typedef double __m128d_u ;
typedef long long __m128i_u ;


typedef double __v2df ;
typedef long long __v2di ;
typedef short __v8hi ;
typedef char __v16qi ;


typedef unsigned long long __v2du ;
typedef unsigned short __v8hu ;
typedef unsigned char __v16qu ;



typedef signed char __v16qs ;
static __m128d
_mm_add_sd(__m128d __a, __m128d __b)
{
  __a[0] += __b[0];
  return __a;
}
static __m128d
_mm_add_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2df)__a + (__v2df)__b);
}
static __m128d
_mm_sub_sd(__m128d __a, __m128d __b)
{
  __a[0] -= __b[0];
  return __a;
}
static __m128d
_mm_sub_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2df)__a - (__v2df)__b);
}
static __m128d
_mm_mul_sd(__m128d __a, __m128d __b)
{
  __a[0] *= __b[0];
  return __a;
}
static __m128d
_mm_mul_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2df)__a * (__v2df)__b);
}
static __m128d
_mm_div_sd(__m128d __a, __m128d __b)
{
  __a[0] /= __b[0];
  return __a;
}
static __m128d
_mm_div_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2df)__a / (__v2df)__b);
}
static __m128d
_mm_sqrt_sd(__m128d __a, __m128d __b)
{
  __m128d __c = __builtin_ia32_sqrtsd((__v2df)__b);
  return __extension__ (__m128d) { __c[0], __a[1] };
}
static __m128d
_mm_sqrt_pd(__m128d __a)
{
  return __builtin_ia32_sqrtpd((__v2df)__a);
}
static __m128d
_mm_min_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_minsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_min_pd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_minpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_max_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_maxsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_max_pd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_maxpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_and_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2du)__a & (__v2du)__b);
}
static __m128d
_mm_andnot_pd(__m128d __a, __m128d __b)
{
  return (__m128d)(~(__v2du)__a & (__v2du)__b);
}
static __m128d
_mm_or_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2du)__a | (__v2du)__b);
}
static __m128d
_mm_xor_pd(__m128d __a, __m128d __b)
{
  return (__m128d)((__v2du)__a ^ (__v2du)__b);
}
static __m128d
_mm_cmpeq_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpeqpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmplt_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpltpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmple_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmplepd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpgt_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpltpd((__v2df)__b, (__v2df)__a);
}
static __m128d
_mm_cmpge_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmplepd((__v2df)__b, (__v2df)__a);
}
static __m128d
_mm_cmpord_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpordpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpunord_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpunordpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpneq_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpneqpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpnlt_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnltpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpnle_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnlepd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpngt_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnltpd((__v2df)__b, (__v2df)__a);
}
static __m128d
_mm_cmpnge_pd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnlepd((__v2df)__b, (__v2df)__a);
}
static __m128d
_mm_cmpeq_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpeqsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmplt_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpltsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmple_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmplesd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpgt_sd(__m128d __a, __m128d __b)
{
  __m128d __c = __builtin_ia32_cmpltsd((__v2df)__b, (__v2df)__a);
  return __extension__ (__m128d) { __c[0], __a[1] };
}
static __m128d
_mm_cmpge_sd(__m128d __a, __m128d __b)
{
  __m128d __c = __builtin_ia32_cmplesd((__v2df)__b, (__v2df)__a);
  return __extension__ (__m128d) { __c[0], __a[1] };
}
static __m128d
_mm_cmpord_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpordsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpunord_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpunordsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpneq_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpneqsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpnlt_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnltsd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpnle_sd(__m128d __a, __m128d __b)
{
  return (__m128d)__builtin_ia32_cmpnlesd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_cmpngt_sd(__m128d __a, __m128d __b)
{
  __m128d __c = __builtin_ia32_cmpnltsd((__v2df)__b, (__v2df)__a);
  return __extension__ (__m128d) { __c[0], __a[1] };
}
static __m128d
_mm_cmpnge_sd(__m128d __a, __m128d __b)
{
  __m128d __c = __builtin_ia32_cmpnlesd((__v2df)__b, (__v2df)__a);
  return __extension__ (__m128d) { __c[0], __a[1] };
}
static int
_mm_comieq_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdeq((__v2df)__a, (__v2df)__b);
}
static int
_mm_comilt_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdlt((__v2df)__a, (__v2df)__b);
}
static int
_mm_comile_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdle((__v2df)__a, (__v2df)__b);
}
static int
_mm_comigt_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdgt((__v2df)__a, (__v2df)__b);
}
static int
_mm_comige_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdge((__v2df)__a, (__v2df)__b);
}
static int
_mm_comineq_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_comisdneq((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomieq_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdeq((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomilt_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdlt((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomile_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdle((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomigt_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdgt((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomige_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdge((__v2df)__a, (__v2df)__b);
}
static int
_mm_ucomineq_sd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_ucomisdneq((__v2df)__a, (__v2df)__b);
}
static __m128
_mm_cvtpd_ps(__m128d __a)
{
  return __builtin_ia32_cvtpd2ps((__v2df)__a);
}
static __m128d
_mm_cvtps_pd(__m128 __a)
{
  return (__m128d) __builtin_convertvector(
      __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 0, 1), __v2df);
}
static __m128d
_mm_cvtepi32_pd(__m128i __a)
{
  return (__m128d) __builtin_convertvector(
      __builtin_shufflevector((__v4si)__a, (__v4si)__a, 0, 1), __v2df);
}
static __m128i
_mm_cvtpd_epi32(__m128d __a)
{
  return __builtin_ia32_cvtpd2dq((__v2df)__a);
}
static int
_mm_cvtsd_si32(__m128d __a)
{
  return __builtin_ia32_cvtsd2si((__v2df)__a);
}
static __m128
_mm_cvtsd_ss(__m128 __a, __m128d __b)
{
  return (__m128)__builtin_ia32_cvtsd2ss((__v4sf)__a, (__v2df)__b);
}
static __m128d
_mm_cvtsi32_sd(__m128d __a, int __b)
{
  __a[0] = __b;
  return __a;
}
static __m128d
_mm_cvtss_sd(__m128d __a, __m128 __b)
{
  __a[0] = __b[0];
  return __a;
}
static __m128i
_mm_cvttpd_epi32(__m128d __a)
{
  return (__m128i)__builtin_ia32_cvttpd2dq((__v2df)__a);
}
static int
_mm_cvttsd_si32(__m128d __a)
{
  return __builtin_ia32_cvttsd2si((__v2df)__a);
}
static __m64
_mm_cvtpd_pi32(__m128d __a)
{
  return (__m64)__builtin_ia32_cvtpd2pi((__v2df)__a);
}
static __m64
_mm_cvttpd_pi32(__m128d __a)
{
  return (__m64)__builtin_ia32_cvttpd2pi((__v2df)__a);
}
static __m128d
_mm_cvtpi32_pd(__m64 __a)
{
  return __builtin_ia32_cvtpi2pd((__v2si)__a);
}
static double
_mm_cvtsd_f64(__m128d __a)
{
  return __a[0];
}
static __m128d
_mm_load_pd(double const *__dp)
{
  return *(__m128d*)__dp;
}
static __m128d
_mm_load1_pd(double const *__dp)
{
  struct __mm_load1_pd_struct {
    double __u;
  } ;
  double __u = ((struct __mm_load1_pd_struct*)__dp)->__u;
  return __extension__ (__m128d){ __u, __u };
}
static __m128d
_mm_loadr_pd(double const *__dp)
{
  __m128d __u = *(__m128d*)__dp;
  return __builtin_shufflevector((__v2df)__u, (__v2df)__u, 1, 0);
}
static __m128d
_mm_loadu_pd(double const *__dp)
{
  struct __loadu_pd {
    __m128d_u __v;
  } ;
  return ((struct __loadu_pd*)__dp)->__v;
}
static __m128i
_mm_loadu_si64(void const *__a)
{
  struct __loadu_si64 {
    long long __v;
  } ;
  long long __u = ((struct __loadu_si64*)__a)->__v;
  return __extension__ (__m128i)(__v2di){__u, 0LL};
}
static __m128i
_mm_loadu_si32(void const *__a)
{
  struct __loadu_si32 {
    int __v;
  } ;
  int __u = ((struct __loadu_si32*)__a)->__v;
  return __extension__ (__m128i)(__v4si){__u, 0, 0, 0};
}
static __m128i
_mm_loadu_si16(void const *__a)
{
  struct __loadu_si16 {
    short __v;
  } ;
  short __u = ((struct __loadu_si16*)__a)->__v;
  return __extension__ (__m128i)(__v8hi){__u, 0, 0, 0, 0, 0, 0, 0};
}
static __m128d
_mm_load_sd(double const *__dp)
{
  struct __mm_load_sd_struct {
    double __u;
  } ;
  double __u = ((struct __mm_load_sd_struct*)__dp)->__u;
  return __extension__ (__m128d){ __u, 0 };
}
static __m128d
_mm_loadh_pd(__m128d __a, double const *__dp)
{
  struct __mm_loadh_pd_struct {
    double __u;
  } ;
  double __u = ((struct __mm_loadh_pd_struct*)__dp)->__u;
  return __extension__ (__m128d){ __a[0], __u };
}
static __m128d
_mm_loadl_pd(__m128d __a, double const *__dp)
{
  struct __mm_loadl_pd_struct {
    double __u;
  } ;
  double __u = ((struct __mm_loadl_pd_struct*)__dp)->__u;
  return __extension__ (__m128d){ __u, __a[1] };
}
static __m128d
_mm_undefined_pd(void)
{
  return (__m128d)__builtin_ia32_undef128();
}
static __m128d
_mm_set_sd(double __w)
{
  return __extension__ (__m128d){ __w, 0 };
}
static __m128d
_mm_set1_pd(double __w)
{
  return __extension__ (__m128d){ __w, __w };
}
static __m128d
_mm_set_pd1(double __w)
{
  return _mm_set1_pd(__w);
}
static __m128d
_mm_set_pd(double __w, double __x)
{
  return __extension__ (__m128d){ __x, __w };
}
static __m128d
_mm_setr_pd(double __w, double __x)
{
  return __extension__ (__m128d){ __w, __x };
}
static __m128d
_mm_setzero_pd(void)
{
  return __extension__ (__m128d){ 0, 0 };
}
static __m128d
_mm_move_sd(__m128d __a, __m128d __b)
{
  __a[0] = __b[0];
  return __a;
}
static void
_mm_store_sd(double *__dp, __m128d __a)
{
  struct __mm_store_sd_struct {
    double __u;
  } ;
  ((struct __mm_store_sd_struct*)__dp)->__u = __a[0];
}
static void
_mm_store_pd(double *__dp, __m128d __a)
{
  *(__m128d*)__dp = __a;
}
static void
_mm_store1_pd(double *__dp, __m128d __a)
{
  __a = __builtin_shufflevector((__v2df)__a, (__v2df)__a, 0, 0);
  _mm_store_pd(__dp, __a);
}
static void
_mm_store_pd1(double *__dp, __m128d __a)
{
  _mm_store1_pd(__dp, __a);
}
static void
_mm_storeu_pd(double *__dp, __m128d __a)
{
  struct __storeu_pd {
    __m128d_u __v;
  } ;
  ((struct __storeu_pd*)__dp)->__v = __a;
}
static void
_mm_storer_pd(double *__dp, __m128d __a)
{
  __a = __builtin_shufflevector((__v2df)__a, (__v2df)__a, 1, 0);
  *(__m128d *)__dp = __a;
}
static void
_mm_storeh_pd(double *__dp, __m128d __a)
{
  struct __mm_storeh_pd_struct {
    double __u;
  } ;
  ((struct __mm_storeh_pd_struct*)__dp)->__u = __a[1];
}
static void
_mm_storel_pd(double *__dp, __m128d __a)
{
  struct __mm_storeh_pd_struct {
    double __u;
  } ;
  ((struct __mm_storeh_pd_struct*)__dp)->__u = __a[0];
}
static __m128i
_mm_add_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)((__v16qu)__a + (__v16qu)__b);
}
static __m128i
_mm_add_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)((__v8hu)__a + (__v8hu)__b);
}
static __m128i
_mm_add_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)((__v4su)__a + (__v4su)__b);
}
static __m64
_mm_add_si64(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_paddq((__v1di)__a, (__v1di)__b);
}
static __m128i
_mm_add_epi64(__m128i __a, __m128i __b)
{
  return (__m128i)((__v2du)__a + (__v2du)__b);
}
static __m128i
_mm_adds_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_paddsb128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_adds_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_paddsw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_adds_epu8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_paddusb128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_adds_epu16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_paddusw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_avg_epu8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pavgb128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_avg_epu16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pavgw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_madd_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pmaddwd128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_max_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pmaxsw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_max_epu8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pmaxub128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_min_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pminsw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_min_epu8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pminub128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_mulhi_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pmulhw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_mulhi_epu16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_pmulhuw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_mullo_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)((__v8hu)__a * (__v8hu)__b);
}
static __m64
_mm_mul_su32(__m64 __a, __m64 __b)
{
  return __builtin_ia32_pmuludq((__v2si)__a, (__v2si)__b);
}
static __m128i
_mm_mul_epu32(__m128i __a, __m128i __b)
{
  return __builtin_ia32_pmuludq128((__v4si)__a, (__v4si)__b);
}
static __m128i
_mm_sad_epu8(__m128i __a, __m128i __b)
{
  return __builtin_ia32_psadbw128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_sub_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)((__v16qu)__a - (__v16qu)__b);
}
static __m128i
_mm_sub_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)((__v8hu)__a - (__v8hu)__b);
}
static __m128i
_mm_sub_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)((__v4su)__a - (__v4su)__b);
}
static __m64
_mm_sub_si64(__m64 __a, __m64 __b)
{
  return (__m64)__builtin_ia32_psubq((__v1di)__a, (__v1di)__b);
}
static __m128i
_mm_sub_epi64(__m128i __a, __m128i __b)
{
  return (__m128i)((__v2du)__a - (__v2du)__b);
}
static __m128i
_mm_subs_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_psubsb128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_subs_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_psubsw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_subs_epu8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_psubusb128((__v16qi)__a, (__v16qi)__b);
}
static __m128i
_mm_subs_epu16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_psubusw128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_and_si128(__m128i __a, __m128i __b)
{
  return (__m128i)((__v2du)__a & (__v2du)__b);
}
static __m128i
_mm_andnot_si128(__m128i __a, __m128i __b)
{
  return (__m128i)(~(__v2du)__a & (__v2du)__b);
}
static __m128i
_mm_or_si128(__m128i __a, __m128i __b)
{
  return (__m128i)((__v2du)__a | (__v2du)__b);
}
static __m128i
_mm_xor_si128(__m128i __a, __m128i __b)
{
  return (__m128i)((__v2du)__a ^ (__v2du)__b);
}
static __m128i
_mm_slli_epi16(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_psllwi128((__v8hi)__a, __count);
}
static __m128i
_mm_sll_epi16(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_psllw128((__v8hi)__a, (__v8hi)__count);
}
static __m128i
_mm_slli_epi32(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_pslldi128((__v4si)__a, __count);
}
static __m128i
_mm_sll_epi32(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_pslld128((__v4si)__a, (__v4si)__count);
}
static __m128i
_mm_slli_epi64(__m128i __a, int __count)
{
  return __builtin_ia32_psllqi128((__v2di)__a, __count);
}
static __m128i
_mm_sll_epi64(__m128i __a, __m128i __count)
{
  return __builtin_ia32_psllq128((__v2di)__a, (__v2di)__count);
}
static __m128i
_mm_srai_epi16(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_psrawi128((__v8hi)__a, __count);
}
static __m128i
_mm_sra_epi16(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_psraw128((__v8hi)__a, (__v8hi)__count);
}
static __m128i
_mm_srai_epi32(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_psradi128((__v4si)__a, __count);
}
static __m128i
_mm_sra_epi32(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_psrad128((__v4si)__a, (__v4si)__count);
}
static __m128i
_mm_srli_epi16(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_psrlwi128((__v8hi)__a, __count);
}
static __m128i
_mm_srl_epi16(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_psrlw128((__v8hi)__a, (__v8hi)__count);
}
static __m128i
_mm_srli_epi32(__m128i __a, int __count)
{
  return (__m128i)__builtin_ia32_psrldi128((__v4si)__a, __count);
}
static __m128i
_mm_srl_epi32(__m128i __a, __m128i __count)
{
  return (__m128i)__builtin_ia32_psrld128((__v4si)__a, (__v4si)__count);
}
static __m128i
_mm_srli_epi64(__m128i __a, int __count)
{
  return __builtin_ia32_psrlqi128((__v2di)__a, __count);
}
static __m128i
_mm_srl_epi64(__m128i __a, __m128i __count)
{
  return __builtin_ia32_psrlq128((__v2di)__a, (__v2di)__count);
}
static __m128i
_mm_cmpeq_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)((__v16qi)__a == (__v16qi)__b);
}
static __m128i
_mm_cmpeq_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)((__v8hi)__a == (__v8hi)__b);
}
static __m128i
_mm_cmpeq_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)((__v4si)__a == (__v4si)__b);
}
static __m128i
_mm_cmpgt_epi8(__m128i __a, __m128i __b)
{


  return (__m128i)((__v16qs)__a > (__v16qs)__b);
}
static __m128i
_mm_cmpgt_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)((__v8hi)__a > (__v8hi)__b);
}
static __m128i
_mm_cmpgt_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)((__v4si)__a > (__v4si)__b);
}
static __m128i
_mm_cmplt_epi8(__m128i __a, __m128i __b)
{
  return _mm_cmpgt_epi8(__b, __a);
}
static __m128i
_mm_cmplt_epi16(__m128i __a, __m128i __b)
{
  return _mm_cmpgt_epi16(__b, __a);
}
static __m128i
_mm_cmplt_epi32(__m128i __a, __m128i __b)
{
  return _mm_cmpgt_epi32(__b, __a);
}
static __m128d
_mm_cvtsi64_sd(__m128d __a, long long __b)
{
  __a[0] = __b;
  return __a;
}
static long long
_mm_cvtsd_si64(__m128d __a)
{
  return __builtin_ia32_cvtsd2si64((__v2df)__a);
}
static long long
_mm_cvttsd_si64(__m128d __a)
{
  return __builtin_ia32_cvttsd2si64((__v2df)__a);
}
static __m128
_mm_cvtepi32_ps(__m128i __a)
{
  return (__m128)__builtin_convertvector((__v4si)__a, __v4sf);
}
static __m128i
_mm_cvtps_epi32(__m128 __a)
{
  return (__m128i)__builtin_ia32_cvtps2dq((__v4sf)__a);
}
static __m128i
_mm_cvttps_epi32(__m128 __a)
{
  return (__m128i)__builtin_ia32_cvttps2dq((__v4sf)__a);
}
static __m128i
_mm_cvtsi32_si128(int __a)
{
  return __extension__ (__m128i)(__v4si){ __a, 0, 0, 0 };
}
static __m128i
_mm_cvtsi64_si128(long long __a)
{
  return __extension__ (__m128i)(__v2di){ __a, 0 };
}
static int
_mm_cvtsi128_si32(__m128i __a)
{
  __v4si __b = (__v4si)__a;
  return __b[0];
}
static long long
_mm_cvtsi128_si64(__m128i __a)
{
  return __a[0];
}
static __m128i
_mm_load_si128(__m128i const *__p)
{
  return *__p;
}
static __m128i
_mm_loadu_si128(__m128i_u const *__p)
{
  struct __loadu_si128 {
    __m128i_u __v;
  } ;
  return ((struct __loadu_si128*)__p)->__v;
}
static __m128i
_mm_loadl_epi64(__m128i_u const *__p)
{
  struct __mm_loadl_epi64_struct {
    long long __u;
  } ;
  return __extension__ (__m128i) { ((struct __mm_loadl_epi64_struct*)__p)->__u, 0};
}
static __m128i
_mm_undefined_si128(void)
{
  return (__m128i)__builtin_ia32_undef128();
}
static __m128i
_mm_set_epi64x(long long __q1, long long __q0)
{
  return __extension__ (__m128i)(__v2di){ __q0, __q1 };
}
static __m128i
_mm_set_epi64(__m64 __q1, __m64 __q0)
{
  return _mm_set_epi64x((long long)__q1, (long long)__q0);
}
static __m128i
_mm_set_epi32(int __i3, int __i2, int __i1, int __i0)
{
  return __extension__ (__m128i)(__v4si){ __i0, __i1, __i2, __i3};
}
static __m128i
_mm_set_epi16(short __w7, short __w6, short __w5, short __w4, short __w3, short __w2, short __w1, short __w0)
{
  return __extension__ (__m128i)(__v8hi){ __w0, __w1, __w2, __w3, __w4, __w5, __w6, __w7 };
}
static __m128i
_mm_set_epi8(char __b15, char __b14, char __b13, char __b12, char __b11, char __b10, char __b9, char __b8, char __b7, char __b6, char __b5, char __b4, char __b3, char __b2, char __b1, char __b0)
{
  return __extension__ (__m128i)(__v16qi){ __b0, __b1, __b2, __b3, __b4, __b5, __b6, __b7, __b8, __b9, __b10, __b11, __b12, __b13, __b14, __b15 };
}
static __m128i
_mm_set1_epi64x(long long __q)
{
  return _mm_set_epi64x(__q, __q);
}
static __m128i
_mm_set1_epi64(__m64 __q)
{
  return _mm_set_epi64(__q, __q);
}
static __m128i
_mm_set1_epi32(int __i)
{
  return _mm_set_epi32(__i, __i, __i, __i);
}
static __m128i
_mm_set1_epi16(short __w)
{
  return _mm_set_epi16(__w, __w, __w, __w, __w, __w, __w, __w);
}
static __m128i
_mm_set1_epi8(char __b)
{
  return _mm_set_epi8(__b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b, __b);
}
static __m128i
_mm_setr_epi64(__m64 __q0, __m64 __q1)
{
  return _mm_set_epi64(__q1, __q0);
}
static __m128i
_mm_setr_epi32(int __i0, int __i1, int __i2, int __i3)
{
  return _mm_set_epi32(__i3, __i2, __i1, __i0);
}
static __m128i
_mm_setr_epi16(short __w0, short __w1, short __w2, short __w3, short __w4, short __w5, short __w6, short __w7)
{
  return _mm_set_epi16(__w7, __w6, __w5, __w4, __w3, __w2, __w1, __w0);
}
static __m128i
_mm_setr_epi8(char __b0, char __b1, char __b2, char __b3, char __b4, char __b5, char __b6, char __b7, char __b8, char __b9, char __b10, char __b11, char __b12, char __b13, char __b14, char __b15)
{
  return _mm_set_epi8(__b15, __b14, __b13, __b12, __b11, __b10, __b9, __b8, __b7, __b6, __b5, __b4, __b3, __b2, __b1, __b0);
}
static __m128i
_mm_setzero_si128(void)
{
  return __extension__ (__m128i)(__v2di){ 0LL, 0LL };
}
static void
_mm_store_si128(__m128i *__p, __m128i __b)
{
  *__p = __b;
}
static void
_mm_storeu_si128(__m128i_u *__p, __m128i __b)
{
  struct __storeu_si128 {
    __m128i_u __v;
  } ;
  ((struct __storeu_si128*)__p)->__v = __b;
}
static void
_mm_storeu_si64(void const *__p, __m128i __b)
{
  struct __storeu_si64 {
    long long __v;
  } ;
  ((struct __storeu_si64*)__p)->__v = ((__v2di)__b)[0];
}
static void
_mm_storeu_si32(void const *__p, __m128i __b)
{
  struct __storeu_si32 {
    int __v;
  } ;
  ((struct __storeu_si32*)__p)->__v = ((__v4si)__b)[0];
}
static void
_mm_storeu_si16(void const *__p, __m128i __b)
{
  struct __storeu_si16 {
    short __v;
  } ;
  ((struct __storeu_si16*)__p)->__v = ((__v8hi)__b)[0];
}
static void
_mm_maskmoveu_si128(__m128i __d, __m128i __n, char *__p)
{
  __builtin_ia32_maskmovdqu((__v16qi)__d, (__v16qi)__n, __p);
}
static void
_mm_storel_epi64(__m128i_u *__p, __m128i __a)
{
  struct __mm_storel_epi64_struct {
    long long __u;
  } ;
  ((struct __mm_storel_epi64_struct*)__p)->__u = __a[0];
}
static void
_mm_stream_pd(double *__p, __m128d __a)
{
  __builtin_nontemporal_store((__v2df)__a, (__v2df*)__p);
}
static void
_mm_stream_si128(__m128i *__p, __m128i __a)
{
  __builtin_nontemporal_store((__v2di)__a, (__v2di*)__p);
}
static void
_mm_stream_si32(int *__p, int __a)
{
  __builtin_ia32_movnti(__p, __a);
}
static void
_mm_stream_si64(long long *__p, long long __a)
{
  __builtin_ia32_movnti64(__p, __a);
}
void _mm_clflush(void const * __p);
void _mm_lfence(void);
void _mm_mfence(void);
static __m128i
_mm_packs_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_packsswb128((__v8hi)__a, (__v8hi)__b);
}
static __m128i
_mm_packs_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_packssdw128((__v4si)__a, (__v4si)__b);
}
static __m128i
_mm_packus_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_ia32_packuswb128((__v8hi)__a, (__v8hi)__b);
}
static int
_mm_movemask_epi8(__m128i __a)
{
  return __builtin_ia32_pmovmskb128((__v16qi)__a);
}
static __m128i
_mm_unpackhi_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v16qi)__a, (__v16qi)__b, 8, 16+8, 9, 16+9, 10, 16+10, 11, 16+11, 12, 16+12, 13, 16+13, 14, 16+14, 15, 16+15);
}
static __m128i
_mm_unpackhi_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v8hi)__a, (__v8hi)__b, 4, 8+4, 5, 8+5, 6, 8+6, 7, 8+7);
}
static __m128i
_mm_unpackhi_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v4si)__a, (__v4si)__b, 2, 4+2, 3, 4+3);
}
static __m128i
_mm_unpackhi_epi64(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v2di)__a, (__v2di)__b, 1, 2+1);
}
static __m128i
_mm_unpacklo_epi8(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v16qi)__a, (__v16qi)__b, 0, 16+0, 1, 16+1, 2, 16+2, 3, 16+3, 4, 16+4, 5, 16+5, 6, 16+6, 7, 16+7);
}
static __m128i
_mm_unpacklo_epi16(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v8hi)__a, (__v8hi)__b, 0, 8+0, 1, 8+1, 2, 8+2, 3, 8+3);
}
static __m128i
_mm_unpacklo_epi32(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v4si)__a, (__v4si)__b, 0, 4+0, 1, 4+1);
}
static __m128i
_mm_unpacklo_epi64(__m128i __a, __m128i __b)
{
  return (__m128i)__builtin_shufflevector((__v2di)__a, (__v2di)__b, 0, 2+0);
}
static __m64
_mm_movepi64_pi64(__m128i __a)
{
  return (__m64)__a[0];
}
static __m128i
_mm_movpi64_epi64(__m64 __a)
{
  return __extension__ (__m128i)(__v2di){ (long long)__a, 0 };
}
static __m128i
_mm_move_epi64(__m128i __a)
{
  return __builtin_shufflevector((__v2di)__a, _mm_setzero_si128(), 0, 2);
}
static __m128d
_mm_unpackhi_pd(__m128d __a, __m128d __b)
{
  return __builtin_shufflevector((__v2df)__a, (__v2df)__b, 1, 2+1);
}
static __m128d
_mm_unpacklo_pd(__m128d __a, __m128d __b)
{
  return __builtin_shufflevector((__v2df)__a, (__v2df)__b, 0, 2+0);
}
static int
_mm_movemask_pd(__m128d __a)
{
  return __builtin_ia32_movmskpd((__v2df)__a);
}
static __m128
_mm_castpd_ps(__m128d __a)
{
  return (__m128)__a;
}
static __m128i
_mm_castpd_si128(__m128d __a)
{
  return (__m128i)__a;
}
static __m128d
_mm_castps_pd(__m128 __a)
{
  return (__m128d)__a;
}
static __m128i
_mm_castps_si128(__m128 __a)
{
  return (__m128i)__a;
}
static __m128
_mm_castsi128_ps(__m128i __a)
{
  return (__m128)__a;
}
static __m128d
_mm_castsi128_pd(__m128i __a)
{
  return (__m128d)__a;
}
void _mm_pause(void);





static __m128i
_mm_lddqu_si128(__m128i const *__p)
{
  return (__m128i)__builtin_ia32_lddqu((char const *)__p);
}
static __m128
_mm_addsub_ps(__m128 __a, __m128 __b)
{
  return __builtin_ia32_addsubps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_hadd_ps(__m128 __a, __m128 __b)
{
  return __builtin_ia32_haddps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_hsub_ps(__m128 __a, __m128 __b)
{
  return __builtin_ia32_hsubps((__v4sf)__a, (__v4sf)__b);
}
static __m128
_mm_movehdup_ps(__m128 __a)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 1, 1, 3, 3);
}
static __m128
_mm_moveldup_ps(__m128 __a)
{
  return __builtin_shufflevector((__v4sf)__a, (__v4sf)__a, 0, 0, 2, 2);
}
static __m128d
_mm_addsub_pd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_addsubpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_hadd_pd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_haddpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_hsub_pd(__m128d __a, __m128d __b)
{
  return __builtin_ia32_hsubpd((__v2df)__a, (__v2df)__b);
}
static __m128d
_mm_movedup_pd(__m128d __a)
{
  return __builtin_shufflevector((__v2df)__a, (__v2df)__a, 0, 0);
}
static void
_mm_monitor(void const *__p, unsigned __extensions, unsigned __hints)
{
  __builtin_ia32_monitor((void *)__p, __extensions, __hints);
}
static void
_mm_mwait(unsigned __extensions, unsigned __hints)
{
  __builtin_ia32_mwait(__extensions, __hints);
}




extern int SDL_GetCPUCount(void);







extern int SDL_GetCPUCacheLineSize(void);




extern SDL_bool SDL_HasRDTSC(void);




extern SDL_bool SDL_HasAltiVec(void);




extern SDL_bool SDL_HasMMX(void);




extern SDL_bool SDL_Has3DNow(void);




extern SDL_bool SDL_HasSSE(void);




extern SDL_bool SDL_HasSSE2(void);




extern SDL_bool SDL_HasSSE3(void);




extern SDL_bool SDL_HasSSE41(void);




extern SDL_bool SDL_HasSSE42(void);




extern SDL_bool SDL_HasAVX(void);




extern SDL_bool SDL_HasAVX2(void);




extern SDL_bool SDL_HasAVX512F(void);




extern SDL_bool SDL_HasARMSIMD(void);




extern SDL_bool SDL_HasNEON(void);




extern int SDL_GetSystemRAM(void);
extern size_t SDL_SIMDGetAlignment(void);
extern void * SDL_SIMDAlloc(const size_t len);
extern void SDL_SIMDFree(void *ptr);









typedef enum
{
    SDL_PIXELTYPE_UNKNOWN,
    SDL_PIXELTYPE_INDEX1,
    SDL_PIXELTYPE_INDEX4,
    SDL_PIXELTYPE_INDEX8,
    SDL_PIXELTYPE_PACKED8,
    SDL_PIXELTYPE_PACKED16,
    SDL_PIXELTYPE_PACKED32,
    SDL_PIXELTYPE_ARRAYU8,
    SDL_PIXELTYPE_ARRAYU16,
    SDL_PIXELTYPE_ARRAYU32,
    SDL_PIXELTYPE_ARRAYF16,
    SDL_PIXELTYPE_ARRAYF32
} SDL_PixelType;


typedef enum
{
    SDL_BITMAPORDER_NONE,
    SDL_BITMAPORDER_4321,
    SDL_BITMAPORDER_1234
} SDL_BitmapOrder;


typedef enum
{
    SDL_PACKEDORDER_NONE,
    SDL_PACKEDORDER_XRGB,
    SDL_PACKEDORDER_RGBX,
    SDL_PACKEDORDER_ARGB,
    SDL_PACKEDORDER_RGBA,
    SDL_PACKEDORDER_XBGR,
    SDL_PACKEDORDER_BGRX,
    SDL_PACKEDORDER_ABGR,
    SDL_PACKEDORDER_BGRA
} SDL_PackedOrder;




typedef enum
{
    SDL_ARRAYORDER_NONE,
    SDL_ARRAYORDER_RGB,
    SDL_ARRAYORDER_RGBA,
    SDL_ARRAYORDER_ARGB,
    SDL_ARRAYORDER_BGR,
    SDL_ARRAYORDER_BGRA,
    SDL_ARRAYORDER_ABGR
} SDL_ArrayOrder;


typedef enum
{
    SDL_PACKEDLAYOUT_NONE,
    SDL_PACKEDLAYOUT_332,
    SDL_PACKEDLAYOUT_4444,
    SDL_PACKEDLAYOUT_1555,
    SDL_PACKEDLAYOUT_5551,
    SDL_PACKEDLAYOUT_565,
    SDL_PACKEDLAYOUT_8888,
    SDL_PACKEDLAYOUT_2101010,
    SDL_PACKEDLAYOUT_1010102
} SDL_PackedLayout;
typedef enum
{
    SDL_PIXELFORMAT_UNKNOWN,
    SDL_PIXELFORMAT_INDEX1LSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX1) << 24) | ((SDL_BITMAPORDER_4321) << 20) | ((0) << 16) | ((1) << 8) | ((0) << 0)),

    SDL_PIXELFORMAT_INDEX1MSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX1) << 24) | ((SDL_BITMAPORDER_1234) << 20) | ((0) << 16) | ((1) << 8) | ((0) << 0)),

    SDL_PIXELFORMAT_INDEX4LSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX4) << 24) | ((SDL_BITMAPORDER_4321) << 20) | ((0) << 16) | ((4) << 8) | ((0) << 0)),

    SDL_PIXELFORMAT_INDEX4MSB =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX4) << 24) | ((SDL_BITMAPORDER_1234) << 20) | ((0) << 16) | ((4) << 8) | ((0) << 0)),

    SDL_PIXELFORMAT_INDEX8 =
        ((1 << 28) | ((SDL_PIXELTYPE_INDEX8) << 24) | ((0) << 20) | ((0) << 16) | ((8) << 8) | ((1) << 0)),
    SDL_PIXELFORMAT_RGB332 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED8) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_332) << 16) | ((8) << 8) | ((1) << 0)),

    SDL_PIXELFORMAT_RGB444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((12) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_BGR444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((12) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_RGB555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((15) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_BGR555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((15) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_ARGB4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_RGBA4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_ABGR4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_BGRA4444 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_4444) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_ARGB1555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_RGBA5551 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_5551) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_ABGR1555 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_1555) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_BGRA5551 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_5551) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_RGB565 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_565) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_BGR565 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED16) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_565) << 16) | ((16) << 8) | ((2) << 0)),

    SDL_PIXELFORMAT_RGB24 =
        ((1 << 28) | ((SDL_PIXELTYPE_ARRAYU8) << 24) | ((SDL_ARRAYORDER_RGB) << 20) | ((0) << 16) | ((24) << 8) | ((3) << 0)),

    SDL_PIXELFORMAT_BGR24 =
        ((1 << 28) | ((SDL_PIXELTYPE_ARRAYU8) << 24) | ((SDL_ARRAYORDER_BGR) << 20) | ((0) << 16) | ((24) << 8) | ((3) << 0)),

    SDL_PIXELFORMAT_RGB888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_XRGB) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_RGBX8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_RGBX) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_BGR888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_XBGR) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_BGRX8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_BGRX) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((24) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_ARGB8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_RGBA8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_RGBA) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_ABGR8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ABGR) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_BGRA8888 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_BGRA) << 20) | ((SDL_PACKEDLAYOUT_8888) << 16) | ((32) << 8) | ((4) << 0)),

    SDL_PIXELFORMAT_ARGB2101010 =
        ((1 << 28) | ((SDL_PIXELTYPE_PACKED32) << 24) | ((SDL_PACKEDORDER_ARGB) << 20) | ((SDL_PACKEDLAYOUT_2101010) << 16) | ((32) << 8) | ((4) << 0)),
    SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888,
    SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888,
    SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888,
    SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888,


    SDL_PIXELFORMAT_YV12 =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('1'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_IYUV =
        ((((Uint32)(((Uint8)(('I'))))) << 0) | (((Uint32)(((Uint8)(('Y'))))) << 8) | (((Uint32)(((Uint8)(('U'))))) << 16) | (((Uint32)(((Uint8)(('V'))))) << 24)),
    SDL_PIXELFORMAT_YUY2 =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('U'))))) << 8) | (((Uint32)(((Uint8)(('Y'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_UYVY =
        ((((Uint32)(((Uint8)(('U'))))) << 0) | (((Uint32)(((Uint8)(('Y'))))) << 8) | (((Uint32)(((Uint8)(('V'))))) << 16) | (((Uint32)(((Uint8)(('Y'))))) << 24)),
    SDL_PIXELFORMAT_YVYU =
        ((((Uint32)(((Uint8)(('Y'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('Y'))))) << 16) | (((Uint32)(((Uint8)(('U'))))) << 24)),
    SDL_PIXELFORMAT_NV12 =
        ((((Uint32)(((Uint8)(('N'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('1'))))) << 16) | (((Uint32)(((Uint8)(('2'))))) << 24)),
    SDL_PIXELFORMAT_NV21 =
        ((((Uint32)(((Uint8)(('N'))))) << 0) | (((Uint32)(((Uint8)(('V'))))) << 8) | (((Uint32)(((Uint8)(('2'))))) << 16) | (((Uint32)(((Uint8)(('1'))))) << 24)),
    SDL_PIXELFORMAT_EXTERNAL_OES =
        ((((Uint32)(((Uint8)(('O'))))) << 0) | (((Uint32)(((Uint8)(('E'))))) << 8) | (((Uint32)(((Uint8)(('S'))))) << 16) | (((Uint32)(((Uint8)((' '))))) << 24))
} SDL_PixelFormatEnum;

typedef struct SDL_Color
{
    Uint8 r;
    Uint8 g;
    Uint8 b;
    Uint8 a;
} SDL_Color;


typedef struct SDL_Palette
{
    int ncolors;
    SDL_Color *colors;
    Uint32 version;
    int refcount;
} SDL_Palette;




typedef struct SDL_PixelFormat
{
    Uint32 format;
    SDL_Palette *palette;
    Uint8 BitsPerPixel;
    Uint8 BytesPerPixel;
    Uint8 padding[2];
    Uint32 Rmask;
    Uint32 Gmask;
    Uint32 Bmask;
    Uint32 Amask;
    Uint8 Rloss;
    Uint8 Gloss;
    Uint8 Bloss;
    Uint8 Aloss;
    Uint8 Rshift;
    Uint8 Gshift;
    Uint8 Bshift;
    Uint8 Ashift;
    int refcount;
    struct SDL_PixelFormat *next;
} SDL_PixelFormat;




extern const char* SDL_GetPixelFormatName(Uint32 format);
extern SDL_bool SDL_PixelFormatEnumToMasks(Uint32 format,
                                                            int *bpp,
                                                            Uint32 * Rmask,
                                                            Uint32 * Gmask,
                                                            Uint32 * Bmask,
                                                            Uint32 * Amask);
extern Uint32 SDL_MasksToPixelFormatEnum(int bpp,
                                                          Uint32 Rmask,
                                                          Uint32 Gmask,
                                                          Uint32 Bmask,
                                                          Uint32 Amask);




extern SDL_PixelFormat * SDL_AllocFormat(Uint32 pixel_format);




extern void SDL_FreeFormat(SDL_PixelFormat *format);
extern SDL_Palette * SDL_AllocPalette(int ncolors);




extern int SDL_SetPixelFormatPalette(SDL_PixelFormat * format,
                                                      SDL_Palette *palette);
extern int SDL_SetPaletteColors(SDL_Palette * palette,
                                                 const SDL_Color * colors,
                                                 int firstcolor, int ncolors);






extern void SDL_FreePalette(SDL_Palette * palette);






extern Uint32 SDL_MapRGB(const SDL_PixelFormat * format,
                                          Uint8 r, Uint8 g, Uint8 b);






extern Uint32 SDL_MapRGBA(const SDL_PixelFormat * format,
                                           Uint8 r, Uint8 g, Uint8 b,
                                           Uint8 a);






extern void SDL_GetRGB(Uint32 pixel,
                                        const SDL_PixelFormat * format,
                                        Uint8 * r, Uint8 * g, Uint8 * b);






extern void SDL_GetRGBA(Uint32 pixel,
                                         const SDL_PixelFormat * format,
                                         Uint8 * r, Uint8 * g, Uint8 * b,
                                         Uint8 * a);




extern void SDL_CalculateGammaRamp(float gamma, Uint16 * ramp);







typedef struct SDL_Point
{
    int x;
    int y;
} SDL_Point;







typedef struct SDL_FPoint
{
    float x;
    float y;
} SDL_FPoint;
typedef struct SDL_Rect
{
    int x, y;
    int w, h;
} SDL_Rect;





typedef struct SDL_FRect
{
    float x;
    float y;
    float w;
    float h;
} SDL_FRect;





 static SDL_bool SDL_PointInRect(const SDL_Point *p, const SDL_Rect *r)
{
    return ( (p->x >= r->x) && (p->x < (r->x + r->w)) &&
             (p->y >= r->y) && (p->y < (r->y + r->h)) ) ? SDL_TRUE : SDL_FALSE;
}




 static SDL_bool SDL_RectEmpty(const SDL_Rect *r)
{
    return ((!r) || (r->w <= 0) || (r->h <= 0)) ? SDL_TRUE : SDL_FALSE;
}




 static SDL_bool SDL_RectEquals(const SDL_Rect *a, const SDL_Rect *b)
{
    return (a && b && (a->x == b->x) && (a->y == b->y) &&
            (a->w == b->w) && (a->h == b->h)) ? SDL_TRUE : SDL_FALSE;
}






extern SDL_bool SDL_HasIntersection(const SDL_Rect * A,
                                                     const SDL_Rect * B);






extern SDL_bool SDL_IntersectRect(const SDL_Rect * A,
                                                   const SDL_Rect * B,
                                                   SDL_Rect * result);




extern void SDL_UnionRect(const SDL_Rect * A,
                                           const SDL_Rect * B,
                                           SDL_Rect * result);






extern SDL_bool SDL_EnclosePoints(const SDL_Point * points,
                                                   int count,
                                                   const SDL_Rect * clip,
                                                   SDL_Rect * result);






extern SDL_bool SDL_IntersectRectAndLine(const SDL_Rect *
                                                          rect, int *X1,
                                                          int *Y1, int *X2,
                                                          int *Y2);














typedef enum
{
    SDL_BLENDMODE_NONE = 0x00000000,

    SDL_BLENDMODE_BLEND = 0x00000001,


    SDL_BLENDMODE_ADD = 0x00000002,


    SDL_BLENDMODE_MOD = 0x00000004,


    SDL_BLENDMODE_MUL = 0x00000008,


    SDL_BLENDMODE_INVALID = 0x7FFFFFFF



} SDL_BlendMode;




typedef enum
{
    SDL_BLENDOPERATION_ADD = 0x1,
    SDL_BLENDOPERATION_SUBTRACT = 0x2,
    SDL_BLENDOPERATION_REV_SUBTRACT = 0x3,
    SDL_BLENDOPERATION_MINIMUM = 0x4,
    SDL_BLENDOPERATION_MAXIMUM = 0x5

} SDL_BlendOperation;




typedef enum
{
    SDL_BLENDFACTOR_ZERO = 0x1,
    SDL_BLENDFACTOR_ONE = 0x2,
    SDL_BLENDFACTOR_SRC_COLOR = 0x3,
    SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = 0x4,
    SDL_BLENDFACTOR_SRC_ALPHA = 0x5,
    SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 0x6,
    SDL_BLENDFACTOR_DST_COLOR = 0x7,
    SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = 0x8,
    SDL_BLENDFACTOR_DST_ALPHA = 0x9,
    SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = 0xA

} SDL_BlendFactor;
extern SDL_BlendMode SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor,
                                                                 SDL_BlendFactor dstColorFactor,
                                                                 SDL_BlendOperation colorOperation,
                                                                 SDL_BlendFactor srcAlphaFactor,
                                                                 SDL_BlendFactor dstAlphaFactor,
                                                                 SDL_BlendOperation alphaOperation);








typedef struct SDL_Surface
{
    Uint32 flags;
    SDL_PixelFormat *format;
    int w, h;
    int pitch;
    void *pixels;


    void *userdata;


    int locked;
    void *lock_data;


    SDL_Rect clip_rect;


    struct SDL_BlitMap *map;


    int refcount;
} SDL_Surface;




typedef int ( *SDL_blit) (struct SDL_Surface * src, SDL_Rect * srcrect,
                                 struct SDL_Surface * dst, SDL_Rect * dstrect);




typedef enum
{
    SDL_YUV_CONVERSION_JPEG,
    SDL_YUV_CONVERSION_BT601,
    SDL_YUV_CONVERSION_BT709,
    SDL_YUV_CONVERSION_AUTOMATIC
} SDL_YUV_CONVERSION_MODE;
extern SDL_Surface * SDL_CreateRGBSurface
    (Uint32 flags, int width, int height, int depth,
     Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask);


extern SDL_Surface * SDL_CreateRGBSurfaceWithFormat
    (Uint32 flags, int width, int height, int depth, Uint32 format);

extern SDL_Surface * SDL_CreateRGBSurfaceFrom(void *pixels,
                                                              int width,
                                                              int height,
                                                              int depth,
                                                              int pitch,
                                                              Uint32 Rmask,
                                                              Uint32 Gmask,
                                                              Uint32 Bmask,
                                                              Uint32 Amask);
extern SDL_Surface * SDL_CreateRGBSurfaceWithFormatFrom
    (void *pixels, int width, int height, int depth, int pitch, Uint32 format);
extern void SDL_FreeSurface(SDL_Surface * surface);
extern int SDL_SetSurfacePalette(SDL_Surface * surface,
                                                  SDL_Palette * palette);
extern int SDL_LockSurface(SDL_Surface * surface);

extern void SDL_UnlockSurface(SDL_Surface * surface);
extern SDL_Surface * SDL_LoadBMP_RW(SDL_RWops * src,
                                                    int freesrc);
extern int SDL_SaveBMP_RW
    (SDL_Surface * surface, SDL_RWops * dst, int freedst);
extern int SDL_SetSurfaceRLE(SDL_Surface * surface,
                                              int flag);
extern int SDL_SetColorKey(SDL_Surface * surface,
                                            int flag, Uint32 key);






extern SDL_bool SDL_HasColorKey(SDL_Surface * surface);
extern int SDL_GetColorKey(SDL_Surface * surface,
                                            Uint32 * key);
extern int SDL_SetSurfaceColorMod(SDL_Surface * surface,
                                                   Uint8 r, Uint8 g, Uint8 b);
extern int SDL_GetSurfaceColorMod(SDL_Surface * surface,
                                                   Uint8 * r, Uint8 * g,
                                                   Uint8 * b);
extern int SDL_SetSurfaceAlphaMod(SDL_Surface * surface,
                                                   Uint8 alpha);
extern int SDL_GetSurfaceAlphaMod(SDL_Surface * surface,
                                                   Uint8 * alpha);
extern int SDL_SetSurfaceBlendMode(SDL_Surface * surface,
                                                    SDL_BlendMode blendMode);
extern int SDL_GetSurfaceBlendMode(SDL_Surface * surface,
                                                    SDL_BlendMode *blendMode);
extern SDL_bool SDL_SetClipRect(SDL_Surface * surface,
                                                 const SDL_Rect * rect);







extern void SDL_GetClipRect(SDL_Surface * surface,
                                             SDL_Rect * rect);




extern SDL_Surface * SDL_DuplicateSurface(SDL_Surface * surface);
extern SDL_Surface * SDL_ConvertSurface
    (SDL_Surface * src, const SDL_PixelFormat * fmt, Uint32 flags);
extern SDL_Surface * SDL_ConvertSurfaceFormat
    (SDL_Surface * src, Uint32 pixel_format, Uint32 flags);






extern int SDL_ConvertPixels(int width, int height,
                                              Uint32 src_format,
                                              const void * src, int src_pitch,
                                              Uint32 dst_format,
                                              void * dst, int dst_pitch);
extern int SDL_FillRect
    (SDL_Surface * dst, const SDL_Rect * rect, Uint32 color);
extern int SDL_FillRects
    (SDL_Surface * dst, const SDL_Rect * rects, int count, Uint32 color);
extern int SDL_UpperBlit
    (SDL_Surface * src, const SDL_Rect * srcrect,
     SDL_Surface * dst, SDL_Rect * dstrect);





extern int SDL_LowerBlit
    (SDL_Surface * src, SDL_Rect * srcrect,
     SDL_Surface * dst, SDL_Rect * dstrect);







extern int SDL_SoftStretch(SDL_Surface * src,
                                            const SDL_Rect * srcrect,
                                            SDL_Surface * dst,
                                            const SDL_Rect * dstrect);







extern int SDL_UpperBlitScaled
    (SDL_Surface * src, const SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);





extern int SDL_LowerBlitScaled
    (SDL_Surface * src, SDL_Rect * srcrect,
    SDL_Surface * dst, SDL_Rect * dstrect);




extern void SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode);




extern SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionMode(void);




extern SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionModeForResolution(int width, int height);







typedef struct
{
    Uint32 format;
    int w;
    int h;
    int refresh_rate;
    void *driverdata;
} SDL_DisplayMode;
typedef struct SDL_Window SDL_Window;






typedef enum
{
    SDL_WINDOW_FULLSCREEN = 0x00000001,
    SDL_WINDOW_OPENGL = 0x00000002,
    SDL_WINDOW_SHOWN = 0x00000004,
    SDL_WINDOW_HIDDEN = 0x00000008,
    SDL_WINDOW_BORDERLESS = 0x00000010,
    SDL_WINDOW_RESIZABLE = 0x00000020,
    SDL_WINDOW_MINIMIZED = 0x00000040,
    SDL_WINDOW_MAXIMIZED = 0x00000080,
    SDL_WINDOW_INPUT_GRABBED = 0x00000100,
    SDL_WINDOW_INPUT_FOCUS = 0x00000200,
    SDL_WINDOW_MOUSE_FOCUS = 0x00000400,
    SDL_WINDOW_FULLSCREEN_DESKTOP = ( SDL_WINDOW_FULLSCREEN | 0x00001000 ),
    SDL_WINDOW_FOREIGN = 0x00000800,
    SDL_WINDOW_ALLOW_HIGHDPI = 0x00002000,


    SDL_WINDOW_MOUSE_CAPTURE = 0x00004000,
    SDL_WINDOW_ALWAYS_ON_TOP = 0x00008000,
    SDL_WINDOW_SKIP_TASKBAR = 0x00010000,
    SDL_WINDOW_UTILITY = 0x00020000,
    SDL_WINDOW_TOOLTIP = 0x00040000,
    SDL_WINDOW_POPUP_MENU = 0x00080000,
    SDL_WINDOW_VULKAN = 0x10000000
} SDL_WindowFlags;
typedef enum
{
    SDL_WINDOWEVENT_NONE,
    SDL_WINDOWEVENT_SHOWN,
    SDL_WINDOWEVENT_HIDDEN,
    SDL_WINDOWEVENT_EXPOSED,

    SDL_WINDOWEVENT_MOVED,

    SDL_WINDOWEVENT_RESIZED,
    SDL_WINDOWEVENT_SIZE_CHANGED,


    SDL_WINDOWEVENT_MINIMIZED,
    SDL_WINDOWEVENT_MAXIMIZED,
    SDL_WINDOWEVENT_RESTORED,

    SDL_WINDOWEVENT_ENTER,
    SDL_WINDOWEVENT_LEAVE,
    SDL_WINDOWEVENT_FOCUS_GAINED,
    SDL_WINDOWEVENT_FOCUS_LOST,
    SDL_WINDOWEVENT_CLOSE,
    SDL_WINDOWEVENT_TAKE_FOCUS,
    SDL_WINDOWEVENT_HIT_TEST
} SDL_WindowEventID;




typedef enum
{
    SDL_DISPLAYEVENT_NONE,
    SDL_DISPLAYEVENT_ORIENTATION
} SDL_DisplayEventID;

typedef enum
{
    SDL_ORIENTATION_UNKNOWN,
    SDL_ORIENTATION_LANDSCAPE,
    SDL_ORIENTATION_LANDSCAPE_FLIPPED,
    SDL_ORIENTATION_PORTRAIT,
    SDL_ORIENTATION_PORTRAIT_FLIPPED
} SDL_DisplayOrientation;




typedef void *SDL_GLContext;




typedef enum
{
    SDL_GL_RED_SIZE,
    SDL_GL_GREEN_SIZE,
    SDL_GL_BLUE_SIZE,
    SDL_GL_ALPHA_SIZE,
    SDL_GL_BUFFER_SIZE,
    SDL_GL_DOUBLEBUFFER,
    SDL_GL_DEPTH_SIZE,
    SDL_GL_STENCIL_SIZE,
    SDL_GL_ACCUM_RED_SIZE,
    SDL_GL_ACCUM_GREEN_SIZE,
    SDL_GL_ACCUM_BLUE_SIZE,
    SDL_GL_ACCUM_ALPHA_SIZE,
    SDL_GL_STEREO,
    SDL_GL_MULTISAMPLEBUFFERS,
    SDL_GL_MULTISAMPLESAMPLES,
    SDL_GL_ACCELERATED_VISUAL,
    SDL_GL_RETAINED_BACKING,
    SDL_GL_CONTEXT_MAJOR_VERSION,
    SDL_GL_CONTEXT_MINOR_VERSION,
    SDL_GL_CONTEXT_EGL,
    SDL_GL_CONTEXT_FLAGS,
    SDL_GL_CONTEXT_PROFILE_MASK,
    SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
    SDL_GL_FRAMEBUFFER_SRGB_CAPABLE,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR,
    SDL_GL_CONTEXT_RESET_NOTIFICATION,
    SDL_GL_CONTEXT_NO_ERROR
} SDL_GLattr;

typedef enum
{
    SDL_GL_CONTEXT_PROFILE_CORE = 0x0001,
    SDL_GL_CONTEXT_PROFILE_COMPATIBILITY = 0x0002,
    SDL_GL_CONTEXT_PROFILE_ES = 0x0004
} SDL_GLprofile;

typedef enum
{
    SDL_GL_CONTEXT_DEBUG_FLAG = 0x0001,
    SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = 0x0002,
    SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG = 0x0004,
    SDL_GL_CONTEXT_RESET_ISOLATION_FLAG = 0x0008
} SDL_GLcontextFlag;

typedef enum
{
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = 0x0000,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 0x0001
} SDL_GLcontextReleaseFlag;

typedef enum
{
    SDL_GL_CONTEXT_RESET_NO_NOTIFICATION = 0x0000,
    SDL_GL_CONTEXT_RESET_LOSE_CONTEXT = 0x0001
} SDL_GLContextResetNotification;
extern int SDL_GetNumVideoDrivers(void);
extern const char * SDL_GetVideoDriver(int index);
extern int SDL_VideoInit(const char *driver_name);
extern void SDL_VideoQuit(void);
extern const char * SDL_GetCurrentVideoDriver(void);






extern int SDL_GetNumVideoDisplays(void);
extern const char * SDL_GetDisplayName(int displayIndex);
extern int SDL_GetDisplayBounds(int displayIndex, SDL_Rect * rect);
extern int SDL_GetDisplayUsableBounds(int displayIndex, SDL_Rect * rect);
extern int SDL_GetDisplayDPI(int displayIndex, float * ddpi, float * hdpi, float * vdpi);
extern SDL_DisplayOrientation SDL_GetDisplayOrientation(int displayIndex);






extern int SDL_GetNumDisplayModes(int displayIndex);
extern int SDL_GetDisplayMode(int displayIndex, int modeIndex,
                                               SDL_DisplayMode * mode);




extern int SDL_GetDesktopDisplayMode(int displayIndex, SDL_DisplayMode * mode);




extern int SDL_GetCurrentDisplayMode(int displayIndex, SDL_DisplayMode * mode);
extern SDL_DisplayMode * SDL_GetClosestDisplayMode(int displayIndex, const SDL_DisplayMode * mode, SDL_DisplayMode * closest);







extern int SDL_GetWindowDisplayIndex(SDL_Window * window);
extern int SDL_SetWindowDisplayMode(SDL_Window * window,
                                                     const SDL_DisplayMode
                                                         * mode);
extern int SDL_GetWindowDisplayMode(SDL_Window * window,
                                                     SDL_DisplayMode * mode);




extern Uint32 SDL_GetWindowPixelFormat(SDL_Window * window);
extern SDL_Window * SDL_CreateWindow(const char *title,
                                                      int x, int y, int w,
                                                      int h, Uint32 flags);
extern SDL_Window * SDL_CreateWindowFrom(const void *data);




extern Uint32 SDL_GetWindowID(SDL_Window * window);




extern SDL_Window * SDL_GetWindowFromID(Uint32 id);




extern Uint32 SDL_GetWindowFlags(SDL_Window * window);






extern void SDL_SetWindowTitle(SDL_Window * window,
                                                const char *title);






extern const char * SDL_GetWindowTitle(SDL_Window * window);







extern void SDL_SetWindowIcon(SDL_Window * window,
                                               SDL_Surface * icon);
extern void* SDL_SetWindowData(SDL_Window * window,
                                                const char *name,
                                                void *userdata);
extern void * SDL_GetWindowData(SDL_Window * window,
                                                const char *name);
extern void SDL_SetWindowPosition(SDL_Window * window,
                                                   int x, int y);
extern void SDL_GetWindowPosition(SDL_Window * window,
                                                   int *x, int *y);
extern void SDL_SetWindowSize(SDL_Window * window, int w,
                                               int h);
extern void SDL_GetWindowSize(SDL_Window * window, int *w,
                                               int *h);
extern int SDL_GetWindowBordersSize(SDL_Window * window,
                                                     int *top, int *left,
                                                     int *bottom, int *right);
extern void SDL_SetWindowMinimumSize(SDL_Window * window,
                                                      int min_w, int min_h);
extern void SDL_GetWindowMinimumSize(SDL_Window * window,
                                                      int *w, int *h);
extern void SDL_SetWindowMaximumSize(SDL_Window * window,
                                                      int max_w, int max_h);
extern void SDL_GetWindowMaximumSize(SDL_Window * window,
                                                      int *w, int *h);
extern void SDL_SetWindowBordered(SDL_Window * window,
                                                   SDL_bool bordered);
extern void SDL_SetWindowResizable(SDL_Window * window,
                                                    SDL_bool resizable);






extern void SDL_ShowWindow(SDL_Window * window);






extern void SDL_HideWindow(SDL_Window * window);




extern void SDL_RaiseWindow(SDL_Window * window);






extern void SDL_MaximizeWindow(SDL_Window * window);






extern void SDL_MinimizeWindow(SDL_Window * window);







extern void SDL_RestoreWindow(SDL_Window * window);
extern int SDL_SetWindowFullscreen(SDL_Window * window,
                                                    Uint32 flags);
extern SDL_Surface * SDL_GetWindowSurface(SDL_Window * window);
extern int SDL_UpdateWindowSurface(SDL_Window * window);
extern int SDL_UpdateWindowSurfaceRects(SDL_Window * window,
                                                         const SDL_Rect * rects,
                                                         int numrects);
extern void SDL_SetWindowGrab(SDL_Window * window,
                                               SDL_bool grabbed);
extern SDL_bool SDL_GetWindowGrab(SDL_Window * window);
extern SDL_Window * SDL_GetGrabbedWindow(void);
extern int SDL_SetWindowBrightness(SDL_Window * window, float brightness);
extern float SDL_GetWindowBrightness(SDL_Window * window);
extern int SDL_SetWindowOpacity(SDL_Window * window, float opacity);
extern int SDL_GetWindowOpacity(SDL_Window * window, float * out_opacity);
extern int SDL_SetWindowModalFor(SDL_Window * modal_window, SDL_Window * parent_window);
extern int SDL_SetWindowInputFocus(SDL_Window * window);
extern int SDL_SetWindowGammaRamp(SDL_Window * window,
                                                   const Uint16 * red,
                                                   const Uint16 * green,
                                                   const Uint16 * blue);
extern int SDL_GetWindowGammaRamp(SDL_Window * window,
                                                   Uint16 * red,
                                                   Uint16 * green,
                                                   Uint16 * blue);






typedef enum
{
    SDL_HITTEST_NORMAL,
    SDL_HITTEST_DRAGGABLE,
    SDL_HITTEST_RESIZE_TOPLEFT,
    SDL_HITTEST_RESIZE_TOP,
    SDL_HITTEST_RESIZE_TOPRIGHT,
    SDL_HITTEST_RESIZE_RIGHT,
    SDL_HITTEST_RESIZE_BOTTOMRIGHT,
    SDL_HITTEST_RESIZE_BOTTOM,
    SDL_HITTEST_RESIZE_BOTTOMLEFT,
    SDL_HITTEST_RESIZE_LEFT
} SDL_HitTestResult;






typedef SDL_HitTestResult ( *SDL_HitTest)(SDL_Window *win,
                                                 const SDL_Point *area,
                                                 void *data);
extern int SDL_SetWindowHitTest(SDL_Window * window,
                                                 SDL_HitTest callback,
                                                 void *callback_data);




extern void SDL_DestroyWindow(SDL_Window * window);
extern SDL_bool SDL_IsScreenSaverEnabled(void);







extern void SDL_EnableScreenSaver(void);







extern void SDL_DisableScreenSaver(void);
extern int SDL_GL_LoadLibrary(const char *path);




extern void * SDL_GL_GetProcAddress(const char *proc);






extern void SDL_GL_UnloadLibrary(void);





extern SDL_bool SDL_GL_ExtensionSupported(const char
                                                           *extension);




extern void SDL_GL_ResetAttributes(void);






extern int SDL_GL_SetAttribute(SDL_GLattr attr, int value);







extern int SDL_GL_GetAttribute(SDL_GLattr attr, int *value);







extern SDL_GLContext SDL_GL_CreateContext(SDL_Window *
                                                           window);






extern int SDL_GL_MakeCurrent(SDL_Window * window,
                                               SDL_GLContext context);




extern SDL_Window* SDL_GL_GetCurrentWindow(void);




extern SDL_GLContext SDL_GL_GetCurrentContext(void);
extern void SDL_GL_GetDrawableSize(SDL_Window * window, int *w,
                                                    int *h);
extern int SDL_GL_SetSwapInterval(int interval);
extern int SDL_GL_GetSwapInterval(void);





extern void SDL_GL_SwapWindow(SDL_Window * window);






extern void SDL_GL_DeleteContext(SDL_GLContext context);
typedef enum
{
    SDL_SCANCODE_UNKNOWN = 0,
    SDL_SCANCODE_A = 4,
    SDL_SCANCODE_B = 5,
    SDL_SCANCODE_C = 6,
    SDL_SCANCODE_D = 7,
    SDL_SCANCODE_E = 8,
    SDL_SCANCODE_F = 9,
    SDL_SCANCODE_G = 10,
    SDL_SCANCODE_H = 11,
    SDL_SCANCODE_I = 12,
    SDL_SCANCODE_J = 13,
    SDL_SCANCODE_K = 14,
    SDL_SCANCODE_L = 15,
    SDL_SCANCODE_M = 16,
    SDL_SCANCODE_N = 17,
    SDL_SCANCODE_O = 18,
    SDL_SCANCODE_P = 19,
    SDL_SCANCODE_Q = 20,
    SDL_SCANCODE_R = 21,
    SDL_SCANCODE_S = 22,
    SDL_SCANCODE_T = 23,
    SDL_SCANCODE_U = 24,
    SDL_SCANCODE_V = 25,
    SDL_SCANCODE_W = 26,
    SDL_SCANCODE_X = 27,
    SDL_SCANCODE_Y = 28,
    SDL_SCANCODE_Z = 29,

    SDL_SCANCODE_1 = 30,
    SDL_SCANCODE_2 = 31,
    SDL_SCANCODE_3 = 32,
    SDL_SCANCODE_4 = 33,
    SDL_SCANCODE_5 = 34,
    SDL_SCANCODE_6 = 35,
    SDL_SCANCODE_7 = 36,
    SDL_SCANCODE_8 = 37,
    SDL_SCANCODE_9 = 38,
    SDL_SCANCODE_0 = 39,

    SDL_SCANCODE_RETURN = 40,
    SDL_SCANCODE_ESCAPE = 41,
    SDL_SCANCODE_BACKSPACE = 42,
    SDL_SCANCODE_TAB = 43,
    SDL_SCANCODE_SPACE = 44,

    SDL_SCANCODE_MINUS = 45,
    SDL_SCANCODE_EQUALS = 46,
    SDL_SCANCODE_LEFTBRACKET = 47,
    SDL_SCANCODE_RIGHTBRACKET = 48,
    SDL_SCANCODE_BACKSLASH = 49,
    SDL_SCANCODE_NONUSHASH = 50,
    SDL_SCANCODE_SEMICOLON = 51,
    SDL_SCANCODE_APOSTROPHE = 52,
    SDL_SCANCODE_GRAVE = 53,
    SDL_SCANCODE_COMMA = 54,
    SDL_SCANCODE_PERIOD = 55,
    SDL_SCANCODE_SLASH = 56,

    SDL_SCANCODE_CAPSLOCK = 57,

    SDL_SCANCODE_F1 = 58,
    SDL_SCANCODE_F2 = 59,
    SDL_SCANCODE_F3 = 60,
    SDL_SCANCODE_F4 = 61,
    SDL_SCANCODE_F5 = 62,
    SDL_SCANCODE_F6 = 63,
    SDL_SCANCODE_F7 = 64,
    SDL_SCANCODE_F8 = 65,
    SDL_SCANCODE_F9 = 66,
    SDL_SCANCODE_F10 = 67,
    SDL_SCANCODE_F11 = 68,
    SDL_SCANCODE_F12 = 69,

    SDL_SCANCODE_PRINTSCREEN = 70,
    SDL_SCANCODE_SCROLLLOCK = 71,
    SDL_SCANCODE_PAUSE = 72,
    SDL_SCANCODE_INSERT = 73,

    SDL_SCANCODE_HOME = 74,
    SDL_SCANCODE_PAGEUP = 75,
    SDL_SCANCODE_DELETE = 76,
    SDL_SCANCODE_END = 77,
    SDL_SCANCODE_PAGEDOWN = 78,
    SDL_SCANCODE_RIGHT = 79,
    SDL_SCANCODE_LEFT = 80,
    SDL_SCANCODE_DOWN = 81,
    SDL_SCANCODE_UP = 82,

    SDL_SCANCODE_NUMLOCKCLEAR = 83,

    SDL_SCANCODE_KP_DIVIDE = 84,
    SDL_SCANCODE_KP_MULTIPLY = 85,
    SDL_SCANCODE_KP_MINUS = 86,
    SDL_SCANCODE_KP_PLUS = 87,
    SDL_SCANCODE_KP_ENTER = 88,
    SDL_SCANCODE_KP_1 = 89,
    SDL_SCANCODE_KP_2 = 90,
    SDL_SCANCODE_KP_3 = 91,
    SDL_SCANCODE_KP_4 = 92,
    SDL_SCANCODE_KP_5 = 93,
    SDL_SCANCODE_KP_6 = 94,
    SDL_SCANCODE_KP_7 = 95,
    SDL_SCANCODE_KP_8 = 96,
    SDL_SCANCODE_KP_9 = 97,
    SDL_SCANCODE_KP_0 = 98,
    SDL_SCANCODE_KP_PERIOD = 99,

    SDL_SCANCODE_NONUSBACKSLASH = 100,
    SDL_SCANCODE_APPLICATION = 101,
    SDL_SCANCODE_POWER = 102,


    SDL_SCANCODE_KP_EQUALS = 103,
    SDL_SCANCODE_F13 = 104,
    SDL_SCANCODE_F14 = 105,
    SDL_SCANCODE_F15 = 106,
    SDL_SCANCODE_F16 = 107,
    SDL_SCANCODE_F17 = 108,
    SDL_SCANCODE_F18 = 109,
    SDL_SCANCODE_F19 = 110,
    SDL_SCANCODE_F20 = 111,
    SDL_SCANCODE_F21 = 112,
    SDL_SCANCODE_F22 = 113,
    SDL_SCANCODE_F23 = 114,
    SDL_SCANCODE_F24 = 115,
    SDL_SCANCODE_EXECUTE = 116,
    SDL_SCANCODE_HELP = 117,
    SDL_SCANCODE_MENU = 118,
    SDL_SCANCODE_SELECT = 119,
    SDL_SCANCODE_STOP = 120,
    SDL_SCANCODE_AGAIN = 121,
    SDL_SCANCODE_UNDO = 122,
    SDL_SCANCODE_CUT = 123,
    SDL_SCANCODE_COPY = 124,
    SDL_SCANCODE_PASTE = 125,
    SDL_SCANCODE_FIND = 126,
    SDL_SCANCODE_MUTE = 127,
    SDL_SCANCODE_VOLUMEUP = 128,
    SDL_SCANCODE_VOLUMEDOWN = 129,




    SDL_SCANCODE_KP_COMMA = 133,
    SDL_SCANCODE_KP_EQUALSAS400 = 134,

    SDL_SCANCODE_INTERNATIONAL1 = 135,

    SDL_SCANCODE_INTERNATIONAL2 = 136,
    SDL_SCANCODE_INTERNATIONAL3 = 137,
    SDL_SCANCODE_INTERNATIONAL4 = 138,
    SDL_SCANCODE_INTERNATIONAL5 = 139,
    SDL_SCANCODE_INTERNATIONAL6 = 140,
    SDL_SCANCODE_INTERNATIONAL7 = 141,
    SDL_SCANCODE_INTERNATIONAL8 = 142,
    SDL_SCANCODE_INTERNATIONAL9 = 143,
    SDL_SCANCODE_LANG1 = 144,
    SDL_SCANCODE_LANG2 = 145,
    SDL_SCANCODE_LANG3 = 146,
    SDL_SCANCODE_LANG4 = 147,
    SDL_SCANCODE_LANG5 = 148,
    SDL_SCANCODE_LANG6 = 149,
    SDL_SCANCODE_LANG7 = 150,
    SDL_SCANCODE_LANG8 = 151,
    SDL_SCANCODE_LANG9 = 152,

    SDL_SCANCODE_ALTERASE = 153,
    SDL_SCANCODE_SYSREQ = 154,
    SDL_SCANCODE_CANCEL = 155,
    SDL_SCANCODE_CLEAR = 156,
    SDL_SCANCODE_PRIOR = 157,
    SDL_SCANCODE_RETURN2 = 158,
    SDL_SCANCODE_SEPARATOR = 159,
    SDL_SCANCODE_OUT = 160,
    SDL_SCANCODE_OPER = 161,
    SDL_SCANCODE_CLEARAGAIN = 162,
    SDL_SCANCODE_CRSEL = 163,
    SDL_SCANCODE_EXSEL = 164,

    SDL_SCANCODE_KP_00 = 176,
    SDL_SCANCODE_KP_000 = 177,
    SDL_SCANCODE_THOUSANDSSEPARATOR = 178,
    SDL_SCANCODE_DECIMALSEPARATOR = 179,
    SDL_SCANCODE_CURRENCYUNIT = 180,
    SDL_SCANCODE_CURRENCYSUBUNIT = 181,
    SDL_SCANCODE_KP_LEFTPAREN = 182,
    SDL_SCANCODE_KP_RIGHTPAREN = 183,
    SDL_SCANCODE_KP_LEFTBRACE = 184,
    SDL_SCANCODE_KP_RIGHTBRACE = 185,
    SDL_SCANCODE_KP_TAB = 186,
    SDL_SCANCODE_KP_BACKSPACE = 187,
    SDL_SCANCODE_KP_A = 188,
    SDL_SCANCODE_KP_B = 189,
    SDL_SCANCODE_KP_C = 190,
    SDL_SCANCODE_KP_D = 191,
    SDL_SCANCODE_KP_E = 192,
    SDL_SCANCODE_KP_F = 193,
    SDL_SCANCODE_KP_XOR = 194,
    SDL_SCANCODE_KP_POWER = 195,
    SDL_SCANCODE_KP_PERCENT = 196,
    SDL_SCANCODE_KP_LESS = 197,
    SDL_SCANCODE_KP_GREATER = 198,
    SDL_SCANCODE_KP_AMPERSAND = 199,
    SDL_SCANCODE_KP_DBLAMPERSAND = 200,
    SDL_SCANCODE_KP_VERTICALBAR = 201,
    SDL_SCANCODE_KP_DBLVERTICALBAR = 202,
    SDL_SCANCODE_KP_COLON = 203,
    SDL_SCANCODE_KP_HASH = 204,
    SDL_SCANCODE_KP_SPACE = 205,
    SDL_SCANCODE_KP_AT = 206,
    SDL_SCANCODE_KP_EXCLAM = 207,
    SDL_SCANCODE_KP_MEMSTORE = 208,
    SDL_SCANCODE_KP_MEMRECALL = 209,
    SDL_SCANCODE_KP_MEMCLEAR = 210,
    SDL_SCANCODE_KP_MEMADD = 211,
    SDL_SCANCODE_KP_MEMSUBTRACT = 212,
    SDL_SCANCODE_KP_MEMMULTIPLY = 213,
    SDL_SCANCODE_KP_MEMDIVIDE = 214,
    SDL_SCANCODE_KP_PLUSMINUS = 215,
    SDL_SCANCODE_KP_CLEAR = 216,
    SDL_SCANCODE_KP_CLEARENTRY = 217,
    SDL_SCANCODE_KP_BINARY = 218,
    SDL_SCANCODE_KP_OCTAL = 219,
    SDL_SCANCODE_KP_DECIMAL = 220,
    SDL_SCANCODE_KP_HEXADECIMAL = 221,

    SDL_SCANCODE_LCTRL = 224,
    SDL_SCANCODE_LSHIFT = 225,
    SDL_SCANCODE_LALT = 226,
    SDL_SCANCODE_LGUI = 227,
    SDL_SCANCODE_RCTRL = 228,
    SDL_SCANCODE_RSHIFT = 229,
    SDL_SCANCODE_RALT = 230,
    SDL_SCANCODE_RGUI = 231,

    SDL_SCANCODE_MODE = 257,
    SDL_SCANCODE_AUDIONEXT = 258,
    SDL_SCANCODE_AUDIOPREV = 259,
    SDL_SCANCODE_AUDIOSTOP = 260,
    SDL_SCANCODE_AUDIOPLAY = 261,
    SDL_SCANCODE_AUDIOMUTE = 262,
    SDL_SCANCODE_MEDIASELECT = 263,
    SDL_SCANCODE_WWW = 264,
    SDL_SCANCODE_MAIL = 265,
    SDL_SCANCODE_CALCULATOR = 266,
    SDL_SCANCODE_COMPUTER = 267,
    SDL_SCANCODE_AC_SEARCH = 268,
    SDL_SCANCODE_AC_HOME = 269,
    SDL_SCANCODE_AC_BACK = 270,
    SDL_SCANCODE_AC_FORWARD = 271,
    SDL_SCANCODE_AC_STOP = 272,
    SDL_SCANCODE_AC_REFRESH = 273,
    SDL_SCANCODE_AC_BOOKMARKS = 274,
    SDL_SCANCODE_BRIGHTNESSDOWN = 275,
    SDL_SCANCODE_BRIGHTNESSUP = 276,
    SDL_SCANCODE_DISPLAYSWITCH = 277,

    SDL_SCANCODE_KBDILLUMTOGGLE = 278,
    SDL_SCANCODE_KBDILLUMDOWN = 279,
    SDL_SCANCODE_KBDILLUMUP = 280,
    SDL_SCANCODE_EJECT = 281,
    SDL_SCANCODE_SLEEP = 282,

    SDL_SCANCODE_APP1 = 283,
    SDL_SCANCODE_APP2 = 284,
    SDL_SCANCODE_AUDIOREWIND = 285,
    SDL_SCANCODE_AUDIOFASTFORWARD = 286,





    SDL_NUM_SCANCODES = 512

} SDL_Scancode;
typedef Sint32 SDL_Keycode;




typedef enum
{
    SDLK_UNKNOWN = 0,

    SDLK_RETURN = '\r',
    SDLK_ESCAPE = '\033',
    SDLK_BACKSPACE = '\b',
    SDLK_TAB = '\t',
    SDLK_SPACE = ' ',
    SDLK_EXCLAIM = '!',
    SDLK_QUOTEDBL = '"',
    SDLK_HASH = '#',
    SDLK_PERCENT = '%',
    SDLK_DOLLAR = '$',
    SDLK_AMPERSAND = '&',
    SDLK_QUOTE = '\'',
    SDLK_LEFTPAREN = '(',
    SDLK_RIGHTPAREN = ')',
    SDLK_ASTERISK = '*',
    SDLK_PLUS = '+',
    SDLK_COMMA = ',',
    SDLK_MINUS = '-',
    SDLK_PERIOD = '.',
    SDLK_SLASH = '/',
    SDLK_0 = '0',
    SDLK_1 = '1',
    SDLK_2 = '2',
    SDLK_3 = '3',
    SDLK_4 = '4',
    SDLK_5 = '5',
    SDLK_6 = '6',
    SDLK_7 = '7',
    SDLK_8 = '8',
    SDLK_9 = '9',
    SDLK_COLON = ':',
    SDLK_SEMICOLON = ';',
    SDLK_LESS = '<',
    SDLK_EQUALS = '=',
    SDLK_GREATER = '>',
    SDLK_QUESTION = '?',
    SDLK_AT = '@',



    SDLK_LEFTBRACKET = '[',
    SDLK_BACKSLASH = '\\',
    SDLK_RIGHTBRACKET = ']',
    SDLK_CARET = '^',
    SDLK_UNDERSCORE = '_',
    SDLK_BACKQUOTE = '`',
    SDLK_a = 'a',
    SDLK_b = 'b',
    SDLK_c = 'c',
    SDLK_d = 'd',
    SDLK_e = 'e',
    SDLK_f = 'f',
    SDLK_g = 'g',
    SDLK_h = 'h',
    SDLK_i = 'i',
    SDLK_j = 'j',
    SDLK_k = 'k',
    SDLK_l = 'l',
    SDLK_m = 'm',
    SDLK_n = 'n',
    SDLK_o = 'o',
    SDLK_p = 'p',
    SDLK_q = 'q',
    SDLK_r = 'r',
    SDLK_s = 's',
    SDLK_t = 't',
    SDLK_u = 'u',
    SDLK_v = 'v',
    SDLK_w = 'w',
    SDLK_x = 'x',
    SDLK_y = 'y',
    SDLK_z = 'z',

    SDLK_CAPSLOCK = (SDL_SCANCODE_CAPSLOCK | (1<<30)),

    SDLK_F1 = (SDL_SCANCODE_F1 | (1<<30)),
    SDLK_F2 = (SDL_SCANCODE_F2 | (1<<30)),
    SDLK_F3 = (SDL_SCANCODE_F3 | (1<<30)),
    SDLK_F4 = (SDL_SCANCODE_F4 | (1<<30)),
    SDLK_F5 = (SDL_SCANCODE_F5 | (1<<30)),
    SDLK_F6 = (SDL_SCANCODE_F6 | (1<<30)),
    SDLK_F7 = (SDL_SCANCODE_F7 | (1<<30)),
    SDLK_F8 = (SDL_SCANCODE_F8 | (1<<30)),
    SDLK_F9 = (SDL_SCANCODE_F9 | (1<<30)),
    SDLK_F10 = (SDL_SCANCODE_F10 | (1<<30)),
    SDLK_F11 = (SDL_SCANCODE_F11 | (1<<30)),
    SDLK_F12 = (SDL_SCANCODE_F12 | (1<<30)),

    SDLK_PRINTSCREEN = (SDL_SCANCODE_PRINTSCREEN | (1<<30)),
    SDLK_SCROLLLOCK = (SDL_SCANCODE_SCROLLLOCK | (1<<30)),
    SDLK_PAUSE = (SDL_SCANCODE_PAUSE | (1<<30)),
    SDLK_INSERT = (SDL_SCANCODE_INSERT | (1<<30)),
    SDLK_HOME = (SDL_SCANCODE_HOME | (1<<30)),
    SDLK_PAGEUP = (SDL_SCANCODE_PAGEUP | (1<<30)),
    SDLK_DELETE = '\177',
    SDLK_END = (SDL_SCANCODE_END | (1<<30)),
    SDLK_PAGEDOWN = (SDL_SCANCODE_PAGEDOWN | (1<<30)),
    SDLK_RIGHT = (SDL_SCANCODE_RIGHT | (1<<30)),
    SDLK_LEFT = (SDL_SCANCODE_LEFT | (1<<30)),
    SDLK_DOWN = (SDL_SCANCODE_DOWN | (1<<30)),
    SDLK_UP = (SDL_SCANCODE_UP | (1<<30)),

    SDLK_NUMLOCKCLEAR = (SDL_SCANCODE_NUMLOCKCLEAR | (1<<30)),
    SDLK_KP_DIVIDE = (SDL_SCANCODE_KP_DIVIDE | (1<<30)),
    SDLK_KP_MULTIPLY = (SDL_SCANCODE_KP_MULTIPLY | (1<<30)),
    SDLK_KP_MINUS = (SDL_SCANCODE_KP_MINUS | (1<<30)),
    SDLK_KP_PLUS = (SDL_SCANCODE_KP_PLUS | (1<<30)),
    SDLK_KP_ENTER = (SDL_SCANCODE_KP_ENTER | (1<<30)),
    SDLK_KP_1 = (SDL_SCANCODE_KP_1 | (1<<30)),
    SDLK_KP_2 = (SDL_SCANCODE_KP_2 | (1<<30)),
    SDLK_KP_3 = (SDL_SCANCODE_KP_3 | (1<<30)),
    SDLK_KP_4 = (SDL_SCANCODE_KP_4 | (1<<30)),
    SDLK_KP_5 = (SDL_SCANCODE_KP_5 | (1<<30)),
    SDLK_KP_6 = (SDL_SCANCODE_KP_6 | (1<<30)),
    SDLK_KP_7 = (SDL_SCANCODE_KP_7 | (1<<30)),
    SDLK_KP_8 = (SDL_SCANCODE_KP_8 | (1<<30)),
    SDLK_KP_9 = (SDL_SCANCODE_KP_9 | (1<<30)),
    SDLK_KP_0 = (SDL_SCANCODE_KP_0 | (1<<30)),
    SDLK_KP_PERIOD = (SDL_SCANCODE_KP_PERIOD | (1<<30)),

    SDLK_APPLICATION = (SDL_SCANCODE_APPLICATION | (1<<30)),
    SDLK_POWER = (SDL_SCANCODE_POWER | (1<<30)),
    SDLK_KP_EQUALS = (SDL_SCANCODE_KP_EQUALS | (1<<30)),
    SDLK_F13 = (SDL_SCANCODE_F13 | (1<<30)),
    SDLK_F14 = (SDL_SCANCODE_F14 | (1<<30)),
    SDLK_F15 = (SDL_SCANCODE_F15 | (1<<30)),
    SDLK_F16 = (SDL_SCANCODE_F16 | (1<<30)),
    SDLK_F17 = (SDL_SCANCODE_F17 | (1<<30)),
    SDLK_F18 = (SDL_SCANCODE_F18 | (1<<30)),
    SDLK_F19 = (SDL_SCANCODE_F19 | (1<<30)),
    SDLK_F20 = (SDL_SCANCODE_F20 | (1<<30)),
    SDLK_F21 = (SDL_SCANCODE_F21 | (1<<30)),
    SDLK_F22 = (SDL_SCANCODE_F22 | (1<<30)),
    SDLK_F23 = (SDL_SCANCODE_F23 | (1<<30)),
    SDLK_F24 = (SDL_SCANCODE_F24 | (1<<30)),
    SDLK_EXECUTE = (SDL_SCANCODE_EXECUTE | (1<<30)),
    SDLK_HELP = (SDL_SCANCODE_HELP | (1<<30)),
    SDLK_MENU = (SDL_SCANCODE_MENU | (1<<30)),
    SDLK_SELECT = (SDL_SCANCODE_SELECT | (1<<30)),
    SDLK_STOP = (SDL_SCANCODE_STOP | (1<<30)),
    SDLK_AGAIN = (SDL_SCANCODE_AGAIN | (1<<30)),
    SDLK_UNDO = (SDL_SCANCODE_UNDO | (1<<30)),
    SDLK_CUT = (SDL_SCANCODE_CUT | (1<<30)),
    SDLK_COPY = (SDL_SCANCODE_COPY | (1<<30)),
    SDLK_PASTE = (SDL_SCANCODE_PASTE | (1<<30)),
    SDLK_FIND = (SDL_SCANCODE_FIND | (1<<30)),
    SDLK_MUTE = (SDL_SCANCODE_MUTE | (1<<30)),
    SDLK_VOLUMEUP = (SDL_SCANCODE_VOLUMEUP | (1<<30)),
    SDLK_VOLUMEDOWN = (SDL_SCANCODE_VOLUMEDOWN | (1<<30)),
    SDLK_KP_COMMA = (SDL_SCANCODE_KP_COMMA | (1<<30)),
    SDLK_KP_EQUALSAS400 =
        (SDL_SCANCODE_KP_EQUALSAS400 | (1<<30)),

    SDLK_ALTERASE = (SDL_SCANCODE_ALTERASE | (1<<30)),
    SDLK_SYSREQ = (SDL_SCANCODE_SYSREQ | (1<<30)),
    SDLK_CANCEL = (SDL_SCANCODE_CANCEL | (1<<30)),
    SDLK_CLEAR = (SDL_SCANCODE_CLEAR | (1<<30)),
    SDLK_PRIOR = (SDL_SCANCODE_PRIOR | (1<<30)),
    SDLK_RETURN2 = (SDL_SCANCODE_RETURN2 | (1<<30)),
    SDLK_SEPARATOR = (SDL_SCANCODE_SEPARATOR | (1<<30)),
    SDLK_OUT = (SDL_SCANCODE_OUT | (1<<30)),
    SDLK_OPER = (SDL_SCANCODE_OPER | (1<<30)),
    SDLK_CLEARAGAIN = (SDL_SCANCODE_CLEARAGAIN | (1<<30)),
    SDLK_CRSEL = (SDL_SCANCODE_CRSEL | (1<<30)),
    SDLK_EXSEL = (SDL_SCANCODE_EXSEL | (1<<30)),

    SDLK_KP_00 = (SDL_SCANCODE_KP_00 | (1<<30)),
    SDLK_KP_000 = (SDL_SCANCODE_KP_000 | (1<<30)),
    SDLK_THOUSANDSSEPARATOR =
        (SDL_SCANCODE_THOUSANDSSEPARATOR | (1<<30)),
    SDLK_DECIMALSEPARATOR =
        (SDL_SCANCODE_DECIMALSEPARATOR | (1<<30)),
    SDLK_CURRENCYUNIT = (SDL_SCANCODE_CURRENCYUNIT | (1<<30)),
    SDLK_CURRENCYSUBUNIT =
        (SDL_SCANCODE_CURRENCYSUBUNIT | (1<<30)),
    SDLK_KP_LEFTPAREN = (SDL_SCANCODE_KP_LEFTPAREN | (1<<30)),
    SDLK_KP_RIGHTPAREN = (SDL_SCANCODE_KP_RIGHTPAREN | (1<<30)),
    SDLK_KP_LEFTBRACE = (SDL_SCANCODE_KP_LEFTBRACE | (1<<30)),
    SDLK_KP_RIGHTBRACE = (SDL_SCANCODE_KP_RIGHTBRACE | (1<<30)),
    SDLK_KP_TAB = (SDL_SCANCODE_KP_TAB | (1<<30)),
    SDLK_KP_BACKSPACE = (SDL_SCANCODE_KP_BACKSPACE | (1<<30)),
    SDLK_KP_A = (SDL_SCANCODE_KP_A | (1<<30)),
    SDLK_KP_B = (SDL_SCANCODE_KP_B | (1<<30)),
    SDLK_KP_C = (SDL_SCANCODE_KP_C | (1<<30)),
    SDLK_KP_D = (SDL_SCANCODE_KP_D | (1<<30)),
    SDLK_KP_E = (SDL_SCANCODE_KP_E | (1<<30)),
    SDLK_KP_F = (SDL_SCANCODE_KP_F | (1<<30)),
    SDLK_KP_XOR = (SDL_SCANCODE_KP_XOR | (1<<30)),
    SDLK_KP_POWER = (SDL_SCANCODE_KP_POWER | (1<<30)),
    SDLK_KP_PERCENT = (SDL_SCANCODE_KP_PERCENT | (1<<30)),
    SDLK_KP_LESS = (SDL_SCANCODE_KP_LESS | (1<<30)),
    SDLK_KP_GREATER = (SDL_SCANCODE_KP_GREATER | (1<<30)),
    SDLK_KP_AMPERSAND = (SDL_SCANCODE_KP_AMPERSAND | (1<<30)),
    SDLK_KP_DBLAMPERSAND =
        (SDL_SCANCODE_KP_DBLAMPERSAND | (1<<30)),
    SDLK_KP_VERTICALBAR =
        (SDL_SCANCODE_KP_VERTICALBAR | (1<<30)),
    SDLK_KP_DBLVERTICALBAR =
        (SDL_SCANCODE_KP_DBLVERTICALBAR | (1<<30)),
    SDLK_KP_COLON = (SDL_SCANCODE_KP_COLON | (1<<30)),
    SDLK_KP_HASH = (SDL_SCANCODE_KP_HASH | (1<<30)),
    SDLK_KP_SPACE = (SDL_SCANCODE_KP_SPACE | (1<<30)),
    SDLK_KP_AT = (SDL_SCANCODE_KP_AT | (1<<30)),
    SDLK_KP_EXCLAM = (SDL_SCANCODE_KP_EXCLAM | (1<<30)),
    SDLK_KP_MEMSTORE = (SDL_SCANCODE_KP_MEMSTORE | (1<<30)),
    SDLK_KP_MEMRECALL = (SDL_SCANCODE_KP_MEMRECALL | (1<<30)),
    SDLK_KP_MEMCLEAR = (SDL_SCANCODE_KP_MEMCLEAR | (1<<30)),
    SDLK_KP_MEMADD = (SDL_SCANCODE_KP_MEMADD | (1<<30)),
    SDLK_KP_MEMSUBTRACT =
        (SDL_SCANCODE_KP_MEMSUBTRACT | (1<<30)),
    SDLK_KP_MEMMULTIPLY =
        (SDL_SCANCODE_KP_MEMMULTIPLY | (1<<30)),
    SDLK_KP_MEMDIVIDE = (SDL_SCANCODE_KP_MEMDIVIDE | (1<<30)),
    SDLK_KP_PLUSMINUS = (SDL_SCANCODE_KP_PLUSMINUS | (1<<30)),
    SDLK_KP_CLEAR = (SDL_SCANCODE_KP_CLEAR | (1<<30)),
    SDLK_KP_CLEARENTRY = (SDL_SCANCODE_KP_CLEARENTRY | (1<<30)),
    SDLK_KP_BINARY = (SDL_SCANCODE_KP_BINARY | (1<<30)),
    SDLK_KP_OCTAL = (SDL_SCANCODE_KP_OCTAL | (1<<30)),
    SDLK_KP_DECIMAL = (SDL_SCANCODE_KP_DECIMAL | (1<<30)),
    SDLK_KP_HEXADECIMAL =
        (SDL_SCANCODE_KP_HEXADECIMAL | (1<<30)),

    SDLK_LCTRL = (SDL_SCANCODE_LCTRL | (1<<30)),
    SDLK_LSHIFT = (SDL_SCANCODE_LSHIFT | (1<<30)),
    SDLK_LALT = (SDL_SCANCODE_LALT | (1<<30)),
    SDLK_LGUI = (SDL_SCANCODE_LGUI | (1<<30)),
    SDLK_RCTRL = (SDL_SCANCODE_RCTRL | (1<<30)),
    SDLK_RSHIFT = (SDL_SCANCODE_RSHIFT | (1<<30)),
    SDLK_RALT = (SDL_SCANCODE_RALT | (1<<30)),
    SDLK_RGUI = (SDL_SCANCODE_RGUI | (1<<30)),

    SDLK_MODE = (SDL_SCANCODE_MODE | (1<<30)),

    SDLK_AUDIONEXT = (SDL_SCANCODE_AUDIONEXT | (1<<30)),
    SDLK_AUDIOPREV = (SDL_SCANCODE_AUDIOPREV | (1<<30)),
    SDLK_AUDIOSTOP = (SDL_SCANCODE_AUDIOSTOP | (1<<30)),
    SDLK_AUDIOPLAY = (SDL_SCANCODE_AUDIOPLAY | (1<<30)),
    SDLK_AUDIOMUTE = (SDL_SCANCODE_AUDIOMUTE | (1<<30)),
    SDLK_MEDIASELECT = (SDL_SCANCODE_MEDIASELECT | (1<<30)),
    SDLK_WWW = (SDL_SCANCODE_WWW | (1<<30)),
    SDLK_MAIL = (SDL_SCANCODE_MAIL | (1<<30)),
    SDLK_CALCULATOR = (SDL_SCANCODE_CALCULATOR | (1<<30)),
    SDLK_COMPUTER = (SDL_SCANCODE_COMPUTER | (1<<30)),
    SDLK_AC_SEARCH = (SDL_SCANCODE_AC_SEARCH | (1<<30)),
    SDLK_AC_HOME = (SDL_SCANCODE_AC_HOME | (1<<30)),
    SDLK_AC_BACK = (SDL_SCANCODE_AC_BACK | (1<<30)),
    SDLK_AC_FORWARD = (SDL_SCANCODE_AC_FORWARD | (1<<30)),
    SDLK_AC_STOP = (SDL_SCANCODE_AC_STOP | (1<<30)),
    SDLK_AC_REFRESH = (SDL_SCANCODE_AC_REFRESH | (1<<30)),
    SDLK_AC_BOOKMARKS = (SDL_SCANCODE_AC_BOOKMARKS | (1<<30)),

    SDLK_BRIGHTNESSDOWN =
        (SDL_SCANCODE_BRIGHTNESSDOWN | (1<<30)),
    SDLK_BRIGHTNESSUP = (SDL_SCANCODE_BRIGHTNESSUP | (1<<30)),
    SDLK_DISPLAYSWITCH = (SDL_SCANCODE_DISPLAYSWITCH | (1<<30)),
    SDLK_KBDILLUMTOGGLE =
        (SDL_SCANCODE_KBDILLUMTOGGLE | (1<<30)),
    SDLK_KBDILLUMDOWN = (SDL_SCANCODE_KBDILLUMDOWN | (1<<30)),
    SDLK_KBDILLUMUP = (SDL_SCANCODE_KBDILLUMUP | (1<<30)),
    SDLK_EJECT = (SDL_SCANCODE_EJECT | (1<<30)),
    SDLK_SLEEP = (SDL_SCANCODE_SLEEP | (1<<30)),
    SDLK_APP1 = (SDL_SCANCODE_APP1 | (1<<30)),
    SDLK_APP2 = (SDL_SCANCODE_APP2 | (1<<30)),

    SDLK_AUDIOREWIND = (SDL_SCANCODE_AUDIOREWIND | (1<<30)),
    SDLK_AUDIOFASTFORWARD = (SDL_SCANCODE_AUDIOFASTFORWARD | (1<<30))
} SDL_KeyCode;




typedef enum
{
    KMOD_NONE = 0x0000,
    KMOD_LSHIFT = 0x0001,
    KMOD_RSHIFT = 0x0002,
    KMOD_LCTRL = 0x0040,
    KMOD_RCTRL = 0x0080,
    KMOD_LALT = 0x0100,
    KMOD_RALT = 0x0200,
    KMOD_LGUI = 0x0400,
    KMOD_RGUI = 0x0800,
    KMOD_NUM = 0x1000,
    KMOD_CAPS = 0x2000,
    KMOD_MODE = 0x4000,
    KMOD_RESERVED = 0x8000
} SDL_Keymod;


typedef struct SDL_Keysym
{
    SDL_Scancode scancode;
    SDL_Keycode sym;
    Uint16 mod;
    Uint32 unused;
} SDL_Keysym;






extern SDL_Window * SDL_GetKeyboardFocus(void);
extern const Uint8 * SDL_GetKeyboardState(int *numkeys);




extern SDL_Keymod SDL_GetModState(void);






extern void SDL_SetModState(SDL_Keymod modstate);
extern SDL_Keycode SDL_GetKeyFromScancode(SDL_Scancode scancode);
extern SDL_Scancode SDL_GetScancodeFromKey(SDL_Keycode key);
extern const char * SDL_GetScancodeName(SDL_Scancode scancode);
extern SDL_Scancode SDL_GetScancodeFromName(const char *name);
extern const char * SDL_GetKeyName(SDL_Keycode key);
extern SDL_Keycode SDL_GetKeyFromName(const char *name);
extern void SDL_StartTextInput(void);







extern SDL_bool SDL_IsTextInputActive(void);
extern void SDL_StopTextInput(void);







extern void SDL_SetTextInputRect(SDL_Rect *rect);
extern SDL_bool SDL_HasScreenKeyboardSupport(void);
extern SDL_bool SDL_IsScreenKeyboardShown(SDL_Window *window);











typedef struct SDL_Cursor SDL_Cursor;




typedef enum
{
    SDL_SYSTEM_CURSOR_ARROW,
    SDL_SYSTEM_CURSOR_IBEAM,
    SDL_SYSTEM_CURSOR_WAIT,
    SDL_SYSTEM_CURSOR_CROSSHAIR,
    SDL_SYSTEM_CURSOR_WAITARROW,
    SDL_SYSTEM_CURSOR_SIZENWSE,
    SDL_SYSTEM_CURSOR_SIZENESW,
    SDL_SYSTEM_CURSOR_SIZEWE,
    SDL_SYSTEM_CURSOR_SIZENS,
    SDL_SYSTEM_CURSOR_SIZEALL,
    SDL_SYSTEM_CURSOR_NO,
    SDL_SYSTEM_CURSOR_HAND,
    SDL_NUM_SYSTEM_CURSORS
} SDL_SystemCursor;




typedef enum
{
    SDL_MOUSEWHEEL_NORMAL,
    SDL_MOUSEWHEEL_FLIPPED
} SDL_MouseWheelDirection;






extern SDL_Window * SDL_GetMouseFocus(void);
extern Uint32 SDL_GetMouseState(int *x, int *y);
extern Uint32 SDL_GetGlobalMouseState(int *x, int *y);
extern Uint32 SDL_GetRelativeMouseState(int *x, int *y);
extern void SDL_WarpMouseInWindow(SDL_Window * window,
                                                   int x, int y);
extern int SDL_WarpMouseGlobal(int x, int y);
extern int SDL_SetRelativeMouseMode(SDL_bool enabled);
extern int SDL_CaptureMouse(SDL_bool enabled);






extern SDL_bool SDL_GetRelativeMouseMode(void);
extern SDL_Cursor * SDL_CreateCursor(const Uint8 * data,
                                                     const Uint8 * mask,
                                                     int w, int h, int hot_x,
                                                     int hot_y);






extern SDL_Cursor * SDL_CreateColorCursor(SDL_Surface *surface,
                                                          int hot_x,
                                                          int hot_y);






extern SDL_Cursor * SDL_CreateSystemCursor(SDL_SystemCursor id);




extern void SDL_SetCursor(SDL_Cursor * cursor);




extern SDL_Cursor * SDL_GetCursor(void);




extern SDL_Cursor * SDL_GetDefaultCursor(void);
extern void SDL_FreeCursor(SDL_Cursor * cursor);
extern int SDL_ShowCursor(int toggle);
struct _SDL_Joystick;
typedef struct _SDL_Joystick SDL_Joystick;


typedef struct {
    Uint8 data[16];
} SDL_JoystickGUID;
typedef Sint32 SDL_JoystickID;

typedef enum
{
    SDL_JOYSTICK_TYPE_UNKNOWN,
    SDL_JOYSTICK_TYPE_GAMECONTROLLER,
    SDL_JOYSTICK_TYPE_WHEEL,
    SDL_JOYSTICK_TYPE_ARCADE_STICK,
    SDL_JOYSTICK_TYPE_FLIGHT_STICK,
    SDL_JOYSTICK_TYPE_DANCE_PAD,
    SDL_JOYSTICK_TYPE_GUITAR,
    SDL_JOYSTICK_TYPE_DRUM_KIT,
    SDL_JOYSTICK_TYPE_ARCADE_PAD,
    SDL_JOYSTICK_TYPE_THROTTLE
} SDL_JoystickType;

typedef enum
{
    SDL_JOYSTICK_POWER_UNKNOWN = -1,
    SDL_JOYSTICK_POWER_EMPTY,
    SDL_JOYSTICK_POWER_LOW,
    SDL_JOYSTICK_POWER_MEDIUM,
    SDL_JOYSTICK_POWER_FULL,
    SDL_JOYSTICK_POWER_WIRED,
    SDL_JOYSTICK_POWER_MAX
} SDL_JoystickPowerLevel;
extern void SDL_LockJoysticks(void);
extern void SDL_UnlockJoysticks(void);




extern int SDL_NumJoysticks(void);






extern const char * SDL_JoystickNameForIndex(int device_index);





extern int SDL_JoystickGetDevicePlayerIndex(int device_index);





extern SDL_JoystickGUID SDL_JoystickGetDeviceGUID(int device_index);






extern Uint16 SDL_JoystickGetDeviceVendor(int device_index);






extern Uint16 SDL_JoystickGetDeviceProduct(int device_index);






extern Uint16 SDL_JoystickGetDeviceProductVersion(int device_index);





extern SDL_JoystickType SDL_JoystickGetDeviceType(int device_index);






extern SDL_JoystickID SDL_JoystickGetDeviceInstanceID(int device_index);
extern SDL_Joystick * SDL_JoystickOpen(int device_index);




extern SDL_Joystick * SDL_JoystickFromInstanceID(SDL_JoystickID instance_id);




extern SDL_Joystick * SDL_JoystickFromPlayerIndex(int player_index);





extern const char * SDL_JoystickName(SDL_Joystick * joystick);






extern int SDL_JoystickGetPlayerIndex(SDL_Joystick * joystick);




extern void SDL_JoystickSetPlayerIndex(SDL_Joystick * joystick, int player_index);




extern SDL_JoystickGUID SDL_JoystickGetGUID(SDL_Joystick * joystick);





extern Uint16 SDL_JoystickGetVendor(SDL_Joystick * joystick);





extern Uint16 SDL_JoystickGetProduct(SDL_Joystick * joystick);





extern Uint16 SDL_JoystickGetProductVersion(SDL_Joystick * joystick);




extern SDL_JoystickType SDL_JoystickGetType(SDL_Joystick * joystick);





extern void SDL_JoystickGetGUIDString(SDL_JoystickGUID guid, char *pszGUID, int cbGUID);




extern SDL_JoystickGUID SDL_JoystickGetGUIDFromString(const char *pchGUID);




extern SDL_bool SDL_JoystickGetAttached(SDL_Joystick * joystick);




extern SDL_JoystickID SDL_JoystickInstanceID(SDL_Joystick * joystick);




extern int SDL_JoystickNumAxes(SDL_Joystick * joystick);







extern int SDL_JoystickNumBalls(SDL_Joystick * joystick);




extern int SDL_JoystickNumHats(SDL_Joystick * joystick);




extern int SDL_JoystickNumButtons(SDL_Joystick * joystick);







extern void SDL_JoystickUpdate(void);
extern int SDL_JoystickEventState(int state);
extern Sint16 SDL_JoystickGetAxis(SDL_Joystick * joystick,
                                                   int axis);
extern SDL_bool SDL_JoystickGetAxisInitialState(SDL_Joystick * joystick,
                                                   int axis, Sint16 *state);
extern Uint8 SDL_JoystickGetHat(SDL_Joystick * joystick,
                                                 int hat);
extern int SDL_JoystickGetBall(SDL_Joystick * joystick,
                                                int ball, int *dx, int *dy);






extern Uint8 SDL_JoystickGetButton(SDL_Joystick * joystick,
                                                    int button);
extern int SDL_JoystickRumble(SDL_Joystick * joystick, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);




extern void SDL_JoystickClose(SDL_Joystick * joystick);




extern SDL_JoystickPowerLevel SDL_JoystickCurrentPowerLevel(SDL_Joystick * joystick);






struct _SDL_GameController;
typedef struct _SDL_GameController SDL_GameController;

typedef enum
{
    SDL_CONTROLLER_TYPE_UNKNOWN = 0,
    SDL_CONTROLLER_TYPE_XBOX360,
    SDL_CONTROLLER_TYPE_XBOXONE,
    SDL_CONTROLLER_TYPE_PS3,
    SDL_CONTROLLER_TYPE_PS4,
    SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO
} SDL_GameControllerType;

typedef enum
{
    SDL_CONTROLLER_BINDTYPE_NONE = 0,
    SDL_CONTROLLER_BINDTYPE_BUTTON,
    SDL_CONTROLLER_BINDTYPE_AXIS,
    SDL_CONTROLLER_BINDTYPE_HAT
} SDL_GameControllerBindType;




typedef struct SDL_GameControllerButtonBind
{
    SDL_GameControllerBindType bindType;
    union
    {
        int button;
        int axis;
        struct {
            int hat;
            int hat_mask;
        } hat;
    } value;

} SDL_GameControllerButtonBind;
extern int SDL_GameControllerAddMappingsFromRW(SDL_RWops * rw, int freerw);
extern int SDL_GameControllerAddMapping(const char* mappingString);






extern int SDL_GameControllerNumMappings(void);






extern char * SDL_GameControllerMappingForIndex(int mapping_index);






extern char * SDL_GameControllerMappingForGUID(SDL_JoystickGUID guid);






extern char * SDL_GameControllerMapping(SDL_GameController * gamecontroller);




extern SDL_bool SDL_IsGameController(int joystick_index);






extern const char * SDL_GameControllerNameForIndex(int joystick_index);





extern SDL_GameControllerType SDL_GameControllerTypeForIndex(int joystick_index);







extern char * SDL_GameControllerMappingForDeviceIndex(int joystick_index);
extern SDL_GameController * SDL_GameControllerOpen(int joystick_index);




extern SDL_GameController * SDL_GameControllerFromInstanceID(SDL_JoystickID joyid);




extern SDL_GameController * SDL_GameControllerFromPlayerIndex(int player_index);




extern const char * SDL_GameControllerName(SDL_GameController *gamecontroller);




extern SDL_GameControllerType SDL_GameControllerGetType(SDL_GameController *gamecontroller);






extern int SDL_GameControllerGetPlayerIndex(SDL_GameController *gamecontroller);




extern void SDL_GameControllerSetPlayerIndex(SDL_GameController *gamecontroller, int player_index);





extern Uint16 SDL_GameControllerGetVendor(SDL_GameController * gamecontroller);





extern Uint16 SDL_GameControllerGetProduct(SDL_GameController * gamecontroller);





extern Uint16 SDL_GameControllerGetProductVersion(SDL_GameController * gamecontroller);





extern SDL_bool SDL_GameControllerGetAttached(SDL_GameController *gamecontroller);




extern SDL_Joystick * SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller);
extern int SDL_GameControllerEventState(int state);







extern void SDL_GameControllerUpdate(void);
typedef enum
{
    SDL_CONTROLLER_AXIS_INVALID = -1,
    SDL_CONTROLLER_AXIS_LEFTX,
    SDL_CONTROLLER_AXIS_LEFTY,
    SDL_CONTROLLER_AXIS_RIGHTX,
    SDL_CONTROLLER_AXIS_RIGHTY,
    SDL_CONTROLLER_AXIS_TRIGGERLEFT,
    SDL_CONTROLLER_AXIS_TRIGGERRIGHT,
    SDL_CONTROLLER_AXIS_MAX
} SDL_GameControllerAxis;




extern SDL_GameControllerAxis SDL_GameControllerGetAxisFromString(const char *pchString);




extern const char* SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis);




extern SDL_GameControllerButtonBind
SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller,
                                 SDL_GameControllerAxis axis);
extern Sint16
SDL_GameControllerGetAxis(SDL_GameController *gamecontroller,
                          SDL_GameControllerAxis axis);




typedef enum
{
    SDL_CONTROLLER_BUTTON_INVALID = -1,
    SDL_CONTROLLER_BUTTON_A,
    SDL_CONTROLLER_BUTTON_B,
    SDL_CONTROLLER_BUTTON_X,
    SDL_CONTROLLER_BUTTON_Y,
    SDL_CONTROLLER_BUTTON_BACK,
    SDL_CONTROLLER_BUTTON_GUIDE,
    SDL_CONTROLLER_BUTTON_START,
    SDL_CONTROLLER_BUTTON_LEFTSTICK,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER,
    SDL_CONTROLLER_BUTTON_DPAD_UP,
    SDL_CONTROLLER_BUTTON_DPAD_DOWN,
    SDL_CONTROLLER_BUTTON_DPAD_LEFT,
    SDL_CONTROLLER_BUTTON_DPAD_RIGHT,
    SDL_CONTROLLER_BUTTON_MAX
} SDL_GameControllerButton;




extern SDL_GameControllerButton SDL_GameControllerGetButtonFromString(const char *pchString);




extern const char* SDL_GameControllerGetStringForButton(SDL_GameControllerButton button);




extern SDL_GameControllerButtonBind
SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller,
                                   SDL_GameControllerButton button);







extern Uint8 SDL_GameControllerGetButton(SDL_GameController *gamecontroller,
                                                          SDL_GameControllerButton button);
extern int SDL_GameControllerRumble(SDL_GameController *gamecontroller, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms);




extern void SDL_GameControllerClose(SDL_GameController *gamecontroller);












typedef Sint64 SDL_TouchID;
typedef Sint64 SDL_FingerID;

typedef enum
{
    SDL_TOUCH_DEVICE_INVALID = -1,
    SDL_TOUCH_DEVICE_DIRECT,
    SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE,
    SDL_TOUCH_DEVICE_INDIRECT_RELATIVE
} SDL_TouchDeviceType;

typedef struct SDL_Finger
{
    SDL_FingerID id;
    float x;
    float y;
    float pressure;
} SDL_Finger;
extern int SDL_GetNumTouchDevices(void);




extern SDL_TouchID SDL_GetTouchDevice(int index);




extern SDL_TouchDeviceType SDL_GetTouchDeviceType(SDL_TouchID touchID);




extern int SDL_GetNumTouchFingers(SDL_TouchID touchID);




extern SDL_Finger * SDL_GetTouchFinger(SDL_TouchID touchID, int index);













typedef Sint64 SDL_GestureID;
extern int SDL_RecordGesture(SDL_TouchID touchId);







extern int SDL_SaveAllDollarTemplates(SDL_RWops *dst);






extern int SDL_SaveDollarTemplate(SDL_GestureID gestureId,SDL_RWops *dst);







extern int SDL_LoadDollarTemplates(SDL_TouchID touchId, SDL_RWops *src);









typedef enum
{
    SDL_FIRSTEVENT = 0,


    SDL_QUIT = 0x100,


    SDL_APP_TERMINATING,



    SDL_APP_LOWMEMORY,



    SDL_APP_WILLENTERBACKGROUND,



    SDL_APP_DIDENTERBACKGROUND,



    SDL_APP_WILLENTERFOREGROUND,



    SDL_APP_DIDENTERFOREGROUND,





    SDL_DISPLAYEVENT = 0x150,


    SDL_WINDOWEVENT = 0x200,
    SDL_SYSWMEVENT,


    SDL_KEYDOWN = 0x300,
    SDL_KEYUP,
    SDL_TEXTEDITING,
    SDL_TEXTINPUT,
    SDL_KEYMAPCHANGED,




    SDL_MOUSEMOTION = 0x400,
    SDL_MOUSEBUTTONDOWN,
    SDL_MOUSEBUTTONUP,
    SDL_MOUSEWHEEL,


    SDL_JOYAXISMOTION = 0x600,
    SDL_JOYBALLMOTION,
    SDL_JOYHATMOTION,
    SDL_JOYBUTTONDOWN,
    SDL_JOYBUTTONUP,
    SDL_JOYDEVICEADDED,
    SDL_JOYDEVICEREMOVED,


    SDL_CONTROLLERAXISMOTION = 0x650,
    SDL_CONTROLLERBUTTONDOWN,
    SDL_CONTROLLERBUTTONUP,
    SDL_CONTROLLERDEVICEADDED,
    SDL_CONTROLLERDEVICEREMOVED,
    SDL_CONTROLLERDEVICEREMAPPED,


    SDL_FINGERDOWN = 0x700,
    SDL_FINGERUP,
    SDL_FINGERMOTION,


    SDL_DOLLARGESTURE = 0x800,
    SDL_DOLLARRECORD,
    SDL_MULTIGESTURE,


    SDL_CLIPBOARDUPDATE = 0x900,


    SDL_DROPFILE = 0x1000,
    SDL_DROPTEXT,
    SDL_DROPBEGIN,
    SDL_DROPCOMPLETE,


    SDL_AUDIODEVICEADDED = 0x1100,
    SDL_AUDIODEVICEREMOVED,


    SDL_SENSORUPDATE = 0x1200,


    SDL_RENDER_TARGETS_RESET = 0x2000,
    SDL_RENDER_DEVICE_RESET,




    SDL_USEREVENT = 0x8000,




    SDL_LASTEVENT = 0xFFFF
} SDL_EventType;




typedef struct SDL_CommonEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_CommonEvent;




typedef struct SDL_DisplayEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 display;
    Uint8 event;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint32 data1;
} SDL_DisplayEvent;




typedef struct SDL_WindowEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint8 event;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint32 data1;
    Sint32 data2;
} SDL_WindowEvent;




typedef struct SDL_KeyboardEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint8 state;
    Uint8 repeat;
    Uint8 padding2;
    Uint8 padding3;
    SDL_Keysym keysym;
} SDL_KeyboardEvent;





typedef struct SDL_TextEditingEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    char text[(32)];
    Sint32 start;
    Sint32 length;
} SDL_TextEditingEvent;






typedef struct SDL_TextInputEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    char text[(32)];
} SDL_TextInputEvent;




typedef struct SDL_MouseMotionEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Uint32 state;
    Sint32 x;
    Sint32 y;
    Sint32 xrel;
    Sint32 yrel;
} SDL_MouseMotionEvent;




typedef struct SDL_MouseButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Uint8 button;
    Uint8 state;
    Uint8 clicks;
    Uint8 padding1;
    Sint32 x;
    Sint32 y;
} SDL_MouseButtonEvent;




typedef struct SDL_MouseWheelEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Uint32 which;
    Sint32 x;
    Sint32 y;
    Uint32 direction;
} SDL_MouseWheelEvent;




typedef struct SDL_JoyAxisEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 axis;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 value;
    Uint16 padding4;
} SDL_JoyAxisEvent;




typedef struct SDL_JoyBallEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 ball;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 xrel;
    Sint16 yrel;
} SDL_JoyBallEvent;




typedef struct SDL_JoyHatEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 hat;
    Uint8 value;






    Uint8 padding1;
    Uint8 padding2;
} SDL_JoyHatEvent;




typedef struct SDL_JoyButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 button;
    Uint8 state;
    Uint8 padding1;
    Uint8 padding2;
} SDL_JoyButtonEvent;




typedef struct SDL_JoyDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Sint32 which;
} SDL_JoyDeviceEvent;





typedef struct SDL_ControllerAxisEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 axis;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
    Sint16 value;
    Uint16 padding4;
} SDL_ControllerAxisEvent;





typedef struct SDL_ControllerButtonEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_JoystickID which;
    Uint8 button;
    Uint8 state;
    Uint8 padding1;
    Uint8 padding2;
} SDL_ControllerButtonEvent;





typedef struct SDL_ControllerDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Sint32 which;
} SDL_ControllerDeviceEvent;




typedef struct SDL_AudioDeviceEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 which;
    Uint8 iscapture;
    Uint8 padding1;
    Uint8 padding2;
    Uint8 padding3;
} SDL_AudioDeviceEvent;





typedef struct SDL_TouchFingerEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    SDL_FingerID fingerId;
    float x;
    float y;
    float dx;
    float dy;
    float pressure;
    Uint32 windowID;
} SDL_TouchFingerEvent;





typedef struct SDL_MultiGestureEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    float dTheta;
    float dDist;
    float x;
    float y;
    Uint16 numFingers;
    Uint16 padding;
} SDL_MultiGestureEvent;





typedef struct SDL_DollarGestureEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_TouchID touchId;
    SDL_GestureID gestureId;
    Uint32 numFingers;
    float error;
    float x;
    float y;
} SDL_DollarGestureEvent;







typedef struct SDL_DropEvent
{
    Uint32 type;
    Uint32 timestamp;
    char *file;
    Uint32 windowID;
} SDL_DropEvent;





typedef struct SDL_SensorEvent
{
    Uint32 type;
    Uint32 timestamp;
    Sint32 which;
    float data[6];
} SDL_SensorEvent;




typedef struct SDL_QuitEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_QuitEvent;




typedef struct SDL_OSEvent
{
    Uint32 type;
    Uint32 timestamp;
} SDL_OSEvent;




typedef struct SDL_UserEvent
{
    Uint32 type;
    Uint32 timestamp;
    Uint32 windowID;
    Sint32 code;
    void *data1;
    void *data2;
} SDL_UserEvent;


struct SDL_SysWMmsg;
typedef struct SDL_SysWMmsg SDL_SysWMmsg;







typedef struct SDL_SysWMEvent
{
    Uint32 type;
    Uint32 timestamp;
    SDL_SysWMmsg *msg;
} SDL_SysWMEvent;




typedef union SDL_Event
{
    Uint32 type;
    SDL_CommonEvent common;
    SDL_DisplayEvent display;
    SDL_WindowEvent window;
    SDL_KeyboardEvent key;
    SDL_TextEditingEvent edit;
    SDL_TextInputEvent text;
    SDL_MouseMotionEvent motion;
    SDL_MouseButtonEvent button;
    SDL_MouseWheelEvent wheel;
    SDL_JoyAxisEvent jaxis;
    SDL_JoyBallEvent jball;
    SDL_JoyHatEvent jhat;
    SDL_JoyButtonEvent jbutton;
    SDL_JoyDeviceEvent jdevice;
    SDL_ControllerAxisEvent caxis;
    SDL_ControllerButtonEvent cbutton;
    SDL_ControllerDeviceEvent cdevice;
    SDL_AudioDeviceEvent adevice;
    SDL_SensorEvent sensor;
    SDL_QuitEvent quit;
    SDL_UserEvent user;
    SDL_SysWMEvent syswm;
    SDL_TouchFingerEvent tfinger;
    SDL_MultiGestureEvent mgesture;
    SDL_DollarGestureEvent dgesture;
    SDL_DropEvent drop;
    Uint8 padding[56];
} SDL_Event;


typedef int SDL_compile_time_assert_SDL_Event[(sizeof(SDL_Event) == 56) * 2 - 1];
extern void SDL_PumpEvents(void);


typedef enum
{
    SDL_ADDEVENT,
    SDL_PEEKEVENT,
    SDL_GETEVENT
} SDL_eventaction;
extern int SDL_PeepEvents(SDL_Event * events, int numevents,
                                           SDL_eventaction action,
                                           Uint32 minType, Uint32 maxType);





extern SDL_bool SDL_HasEvent(Uint32 type);
extern SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType);







extern void SDL_FlushEvent(Uint32 type);
extern void SDL_FlushEvents(Uint32 minType, Uint32 maxType);
extern int SDL_PollEvent(SDL_Event * event);
extern int SDL_WaitEvent(SDL_Event * event);
extern int SDL_WaitEventTimeout(SDL_Event * event,
                                                 int timeout);







extern int SDL_PushEvent(SDL_Event * event);

typedef int ( * SDL_EventFilter) (void *userdata, SDL_Event * event);
extern void SDL_SetEventFilter(SDL_EventFilter filter,
                                                void *userdata);





extern SDL_bool SDL_GetEventFilter(SDL_EventFilter * filter,
                                                    void **userdata);




extern void SDL_AddEventWatch(SDL_EventFilter filter,
                                               void *userdata);




extern void SDL_DelEventWatch(SDL_EventFilter filter,
                                               void *userdata);





extern void SDL_FilterEvents(SDL_EventFilter filter,
                                              void *userdata);
extern Uint8 SDL_EventState(Uint32 type, int state);
extern Uint32 SDL_RegisterEvents(int numevents);






extern char * SDL_GetBasePath(void);
extern char * SDL_GetPrefPath(const char *org, const char *app);







struct _SDL_Haptic;
typedef struct _SDL_Haptic SDL_Haptic;
typedef struct SDL_HapticDirection
{
    Uint8 type;
    Sint32 dir[3];
} SDL_HapticDirection;
typedef struct SDL_HapticConstant
{

    Uint16 type;
    SDL_HapticDirection direction;


    Uint32 length;
    Uint16 delay;


    Uint16 button;
    Uint16 interval;


    Sint16 level;


    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticConstant;
typedef struct SDL_HapticPeriodic
{

    Uint16 type;


    SDL_HapticDirection direction;


    Uint32 length;
    Uint16 delay;


    Uint16 button;
    Uint16 interval;


    Uint16 period;
    Sint16 magnitude;
    Sint16 offset;
    Uint16 phase;


    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticPeriodic;
typedef struct SDL_HapticCondition
{

    Uint16 type;

    SDL_HapticDirection direction;


    Uint32 length;
    Uint16 delay;


    Uint16 button;
    Uint16 interval;


    Uint16 right_sat[3];
    Uint16 left_sat[3];
    Sint16 right_coeff[3];
    Sint16 left_coeff[3];
    Uint16 deadband[3];
    Sint16 center[3];
} SDL_HapticCondition;
typedef struct SDL_HapticRamp
{

    Uint16 type;
    SDL_HapticDirection direction;


    Uint32 length;
    Uint16 delay;


    Uint16 button;
    Uint16 interval;


    Sint16 start;
    Sint16 end;


    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticRamp;
typedef struct SDL_HapticLeftRight
{

    Uint16 type;


    Uint32 length;


    Uint16 large_magnitude;
    Uint16 small_magnitude;
} SDL_HapticLeftRight;
typedef struct SDL_HapticCustom
{

    Uint16 type;
    SDL_HapticDirection direction;


    Uint32 length;
    Uint16 delay;


    Uint16 button;
    Uint16 interval;


    Uint8 channels;
    Uint16 period;
    Uint16 samples;
    Uint16 *data;


    Uint16 attack_length;
    Uint16 attack_level;
    Uint16 fade_length;
    Uint16 fade_level;
} SDL_HapticCustom;
typedef union SDL_HapticEffect
{

    Uint16 type;
    SDL_HapticConstant constant;
    SDL_HapticPeriodic periodic;
    SDL_HapticCondition condition;
    SDL_HapticRamp ramp;
    SDL_HapticLeftRight leftright;
    SDL_HapticCustom custom;
} SDL_HapticEffect;
extern int SDL_NumHaptics(void);
extern const char * SDL_HapticName(int device_index);
extern SDL_Haptic * SDL_HapticOpen(int device_index);
extern int SDL_HapticOpened(int device_index);
extern int SDL_HapticIndex(SDL_Haptic * haptic);
extern int SDL_MouseIsHaptic(void);
extern SDL_Haptic * SDL_HapticOpenFromMouse(void);
extern int SDL_JoystickIsHaptic(SDL_Joystick * joystick);
extern SDL_Haptic * SDL_HapticOpenFromJoystick(SDL_Joystick *
                                                               joystick);






extern void SDL_HapticClose(SDL_Haptic * haptic);
extern int SDL_HapticNumEffects(SDL_Haptic * haptic);
extern int SDL_HapticNumEffectsPlaying(SDL_Haptic * haptic);
extern unsigned int SDL_HapticQuery(SDL_Haptic * haptic);







extern int SDL_HapticNumAxes(SDL_Haptic * haptic);
extern int SDL_HapticEffectSupported(SDL_Haptic * haptic,
                                                      SDL_HapticEffect *
                                                      effect);
extern int SDL_HapticNewEffect(SDL_Haptic * haptic,
                                                SDL_HapticEffect * effect);
extern int SDL_HapticUpdateEffect(SDL_Haptic * haptic,
                                                   int effect,
                                                   SDL_HapticEffect * data);
extern int SDL_HapticRunEffect(SDL_Haptic * haptic,
                                                int effect,
                                                Uint32 iterations);
extern int SDL_HapticStopEffect(SDL_Haptic * haptic,
                                                 int effect);
extern void SDL_HapticDestroyEffect(SDL_Haptic * haptic,
                                                     int effect);
extern int SDL_HapticGetEffectStatus(SDL_Haptic * haptic,
                                                      int effect);
extern int SDL_HapticSetGain(SDL_Haptic * haptic, int gain);
extern int SDL_HapticSetAutocenter(SDL_Haptic * haptic,
                                                    int autocenter);
extern int SDL_HapticPause(SDL_Haptic * haptic);
extern int SDL_HapticUnpause(SDL_Haptic * haptic);







extern int SDL_HapticStopAll(SDL_Haptic * haptic);
extern int SDL_HapticRumbleSupported(SDL_Haptic * haptic);
extern int SDL_HapticRumbleInit(SDL_Haptic * haptic);
extern int SDL_HapticRumblePlay(SDL_Haptic * haptic, float strength, Uint32 length );
extern int SDL_HapticRumbleStop(SDL_Haptic * haptic);






typedef enum
{
    SDL_HINT_DEFAULT,
    SDL_HINT_NORMAL,
    SDL_HINT_OVERRIDE
} SDL_HintPriority;
extern SDL_bool SDL_SetHintWithPriority(const char *name,
                                                         const char *value,
                                                         SDL_HintPriority priority);






extern SDL_bool SDL_SetHint(const char *name,
                                             const char *value);






extern const char * SDL_GetHint(const char *name);






extern SDL_bool SDL_GetHintBoolean(const char *name, SDL_bool default_value);




typedef void ( *SDL_HintCallback)(void *userdata, const char *name, const char *oldValue, const char *newValue);
extern void SDL_AddHintCallback(const char *name,
                                                 SDL_HintCallback callback,
                                                 void *userdata);
extern void SDL_DelHintCallback(const char *name,
                                                 SDL_HintCallback callback,
                                                 void *userdata);






extern void SDL_ClearHints(void);








extern void * SDL_LoadObject(const char *sofile);






extern void * SDL_LoadFunction(void *handle,
                                               const char *name);




extern void SDL_UnloadObject(void *handle);






typedef enum
{
    SDL_LOG_CATEGORY_APPLICATION,
    SDL_LOG_CATEGORY_ERROR,
    SDL_LOG_CATEGORY_ASSERT,
    SDL_LOG_CATEGORY_SYSTEM,
    SDL_LOG_CATEGORY_AUDIO,
    SDL_LOG_CATEGORY_VIDEO,
    SDL_LOG_CATEGORY_RENDER,
    SDL_LOG_CATEGORY_INPUT,
    SDL_LOG_CATEGORY_TEST,


    SDL_LOG_CATEGORY_RESERVED1,
    SDL_LOG_CATEGORY_RESERVED2,
    SDL_LOG_CATEGORY_RESERVED3,
    SDL_LOG_CATEGORY_RESERVED4,
    SDL_LOG_CATEGORY_RESERVED5,
    SDL_LOG_CATEGORY_RESERVED6,
    SDL_LOG_CATEGORY_RESERVED7,
    SDL_LOG_CATEGORY_RESERVED8,
    SDL_LOG_CATEGORY_RESERVED9,
    SDL_LOG_CATEGORY_RESERVED10,
    SDL_LOG_CATEGORY_CUSTOM
} SDL_LogCategory;




typedef enum
{
    SDL_LOG_PRIORITY_VERBOSE = 1,
    SDL_LOG_PRIORITY_DEBUG,
    SDL_LOG_PRIORITY_INFO,
    SDL_LOG_PRIORITY_WARN,
    SDL_LOG_PRIORITY_ERROR,
    SDL_LOG_PRIORITY_CRITICAL,
    SDL_NUM_LOG_PRIORITIES
} SDL_LogPriority;





extern void SDL_LogSetAllPriority(SDL_LogPriority priority);




extern void SDL_LogSetPriority(int category,
                                                SDL_LogPriority priority);




extern SDL_LogPriority SDL_LogGetPriority(int category);






extern void SDL_LogResetPriorities(void);




extern void SDL_Log( const char *fmt, ...) ;




extern void SDL_LogVerbose(int category, const char *fmt, ...) ;




extern void SDL_LogDebug(int category, const char *fmt, ...) ;




extern void SDL_LogInfo(int category, const char *fmt, ...) ;




extern void SDL_LogWarn(int category, const char *fmt, ...) ;




extern void SDL_LogError(int category, const char *fmt, ...) ;




extern void SDL_LogCritical(int category, const char *fmt, ...) ;




extern void SDL_LogMessage(int category,
                                            SDL_LogPriority priority,
                                                                     const char *fmt, ...) ;




extern void SDL_LogMessageV(int category,
                                             SDL_LogPriority priority,
                                             const char *fmt, va_list ap);




typedef void ( *SDL_LogOutputFunction)(void *userdata, int category, SDL_LogPriority priority, const char *message);




extern void SDL_LogGetOutputFunction(SDL_LogOutputFunction *callback, void **userdata);





extern void SDL_LogSetOutputFunction(SDL_LogOutputFunction callback, void *userdata);















typedef enum
{
    SDL_MESSAGEBOX_ERROR = 0x00000010,
    SDL_MESSAGEBOX_WARNING = 0x00000020,
    SDL_MESSAGEBOX_INFORMATION = 0x00000040,
    SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = 0x00000080,
    SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = 0x00000100
} SDL_MessageBoxFlags;




typedef enum
{
    SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001,
    SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
} SDL_MessageBoxButtonFlags;




typedef struct
{
    Uint32 flags;
    int buttonid;
    const char * text;
} SDL_MessageBoxButtonData;




typedef struct
{
    Uint8 r, g, b;
} SDL_MessageBoxColor;

typedef enum
{
    SDL_MESSAGEBOX_COLOR_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_TEXT,
    SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
    SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
    SDL_MESSAGEBOX_COLOR_MAX
} SDL_MessageBoxColorType;




typedef struct
{
    SDL_MessageBoxColor colors[SDL_MESSAGEBOX_COLOR_MAX];
} SDL_MessageBoxColorScheme;




typedef struct
{
    Uint32 flags;
    SDL_Window *window;
    const char *title;
    const char *message;

    int numbuttons;
    const SDL_MessageBoxButtonData *buttons;

    const SDL_MessageBoxColorScheme *colorScheme;
} SDL_MessageBoxData;
extern int SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid);
extern int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title, const char *message, SDL_Window *window);







typedef void *SDL_MetalView;
extern SDL_MetalView SDL_Metal_CreateView(SDL_Window * window);
extern void SDL_Metal_DestroyView(SDL_MetalView view);

















typedef enum
{
    SDL_POWERSTATE_UNKNOWN,
    SDL_POWERSTATE_ON_BATTERY,
    SDL_POWERSTATE_NO_BATTERY,
    SDL_POWERSTATE_CHARGING,
    SDL_POWERSTATE_CHARGED
} SDL_PowerState;
extern SDL_PowerState SDL_GetPowerInfo(int *secs, int *pct);














typedef enum
{
    SDL_RENDERER_SOFTWARE = 0x00000001,
    SDL_RENDERER_ACCELERATED = 0x00000002,

    SDL_RENDERER_PRESENTVSYNC = 0x00000004,

    SDL_RENDERER_TARGETTEXTURE = 0x00000008

} SDL_RendererFlags;




typedef struct SDL_RendererInfo
{
    const char *name;
    Uint32 flags;
    Uint32 num_texture_formats;
    Uint32 texture_formats[16];
    int max_texture_width;
    int max_texture_height;
} SDL_RendererInfo;




typedef enum
{
    SDL_ScaleModeNearest,
    SDL_ScaleModeLinear,
    SDL_ScaleModeBest
} SDL_ScaleMode;




typedef enum
{
    SDL_TEXTUREACCESS_STATIC,
    SDL_TEXTUREACCESS_STREAMING,
    SDL_TEXTUREACCESS_TARGET
} SDL_TextureAccess;




typedef enum
{
    SDL_TEXTUREMODULATE_NONE = 0x00000000,
    SDL_TEXTUREMODULATE_COLOR = 0x00000001,
    SDL_TEXTUREMODULATE_ALPHA = 0x00000002
} SDL_TextureModulate;




typedef enum
{
    SDL_FLIP_NONE = 0x00000000,
    SDL_FLIP_HORIZONTAL = 0x00000001,
    SDL_FLIP_VERTICAL = 0x00000002
} SDL_RendererFlip;




struct SDL_Renderer;
typedef struct SDL_Renderer SDL_Renderer;




struct SDL_Texture;
typedef struct SDL_Texture SDL_Texture;
extern int SDL_GetNumRenderDrivers(void);
extern int SDL_GetRenderDriverInfo(int index,
                                                    SDL_RendererInfo * info);
extern int SDL_CreateWindowAndRenderer(
                                int width, int height, Uint32 window_flags,
                                SDL_Window **window, SDL_Renderer **renderer);
extern SDL_Renderer * SDL_CreateRenderer(SDL_Window * window,
                                               int index, Uint32 flags);
extern SDL_Renderer * SDL_CreateSoftwareRenderer(SDL_Surface * surface);




extern SDL_Renderer * SDL_GetRenderer(SDL_Window * window);




extern int SDL_GetRendererInfo(SDL_Renderer * renderer,
                                                SDL_RendererInfo * info);




extern int SDL_GetRendererOutputSize(SDL_Renderer * renderer,
                                                      int *w, int *h);
extern SDL_Texture * SDL_CreateTexture(SDL_Renderer * renderer,
                                                        Uint32 format,
                                                        int access, int w,
                                                        int h);
extern SDL_Texture * SDL_CreateTextureFromSurface(SDL_Renderer * renderer, SDL_Surface * surface);
extern int SDL_QueryTexture(SDL_Texture * texture,
                                             Uint32 * format, int *access,
                                             int *w, int *h);
extern int SDL_SetTextureColorMod(SDL_Texture * texture,
                                                   Uint8 r, Uint8 g, Uint8 b);
extern int SDL_GetTextureColorMod(SDL_Texture * texture,
                                                   Uint8 * r, Uint8 * g,
                                                   Uint8 * b);
extern int SDL_SetTextureAlphaMod(SDL_Texture * texture,
                                                   Uint8 alpha);
extern int SDL_GetTextureAlphaMod(SDL_Texture * texture,
                                                   Uint8 * alpha);
extern int SDL_SetTextureBlendMode(SDL_Texture * texture,
                                                    SDL_BlendMode blendMode);
extern int SDL_GetTextureBlendMode(SDL_Texture * texture,
                                                    SDL_BlendMode *blendMode);
extern int SDL_SetTextureScaleMode(SDL_Texture * texture,
                                                    SDL_ScaleMode scaleMode);
extern int SDL_GetTextureScaleMode(SDL_Texture * texture,
                                                    SDL_ScaleMode *scaleMode);
extern int SDL_UpdateTexture(SDL_Texture * texture,
                                              const SDL_Rect * rect,
                                              const void *pixels, int pitch);
extern int SDL_UpdateYUVTexture(SDL_Texture * texture,
                                                 const SDL_Rect * rect,
                                                 const Uint8 *Yplane, int Ypitch,
                                                 const Uint8 *Uplane, int Upitch,
                                                 const Uint8 *Vplane, int Vpitch);
extern int SDL_LockTexture(SDL_Texture * texture,
                                            const SDL_Rect * rect,
                                            void **pixels, int *pitch);
extern int SDL_LockTextureToSurface(SDL_Texture *texture,
                                            const SDL_Rect *rect,
                                            SDL_Surface **surface);
extern void SDL_UnlockTexture(SDL_Texture * texture);
extern SDL_bool SDL_RenderTargetSupported(SDL_Renderer *renderer);
extern int SDL_SetRenderTarget(SDL_Renderer *renderer,
                                                SDL_Texture *texture);
extern SDL_Texture * SDL_GetRenderTarget(SDL_Renderer *renderer);
extern int SDL_RenderSetLogicalSize(SDL_Renderer * renderer, int w, int h);
extern void SDL_RenderGetLogicalSize(SDL_Renderer * renderer, int *w, int *h);
extern int SDL_RenderSetIntegerScale(SDL_Renderer * renderer,
                                                      SDL_bool enable);
extern SDL_bool SDL_RenderGetIntegerScale(SDL_Renderer * renderer);
extern int SDL_RenderSetViewport(SDL_Renderer * renderer,
                                                  const SDL_Rect * rect);






extern void SDL_RenderGetViewport(SDL_Renderer * renderer,
                                                   SDL_Rect * rect);
extern int SDL_RenderSetClipRect(SDL_Renderer * renderer,
                                                  const SDL_Rect * rect);
extern void SDL_RenderGetClipRect(SDL_Renderer * renderer,
                                                   SDL_Rect * rect);
extern SDL_bool SDL_RenderIsClipEnabled(SDL_Renderer * renderer);
extern int SDL_RenderSetScale(SDL_Renderer * renderer,
                                               float scaleX, float scaleY);
extern void SDL_RenderGetScale(SDL_Renderer * renderer,
                                               float *scaleX, float *scaleY);
extern int SDL_SetRenderDrawColor(SDL_Renderer * renderer,
                                           Uint8 r, Uint8 g, Uint8 b,
                                           Uint8 a);
extern int SDL_GetRenderDrawColor(SDL_Renderer * renderer,
                                           Uint8 * r, Uint8 * g, Uint8 * b,
                                           Uint8 * a);
extern int SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer,
                                                       SDL_BlendMode blendMode);
extern int SDL_GetRenderDrawBlendMode(SDL_Renderer * renderer,
                                                       SDL_BlendMode *blendMode);
extern int SDL_RenderClear(SDL_Renderer * renderer);
extern int SDL_RenderDrawPoint(SDL_Renderer * renderer,
                                                int x, int y);
extern int SDL_RenderDrawPoints(SDL_Renderer * renderer,
                                                 const SDL_Point * points,
                                                 int count);
extern int SDL_RenderDrawLine(SDL_Renderer * renderer,
                                               int x1, int y1, int x2, int y2);
extern int SDL_RenderDrawLines(SDL_Renderer * renderer,
                                                const SDL_Point * points,
                                                int count);
extern int SDL_RenderDrawRect(SDL_Renderer * renderer,
                                               const SDL_Rect * rect);
extern int SDL_RenderDrawRects(SDL_Renderer * renderer,
                                                const SDL_Rect * rects,
                                                int count);
extern int SDL_RenderFillRect(SDL_Renderer * renderer,
                                               const SDL_Rect * rect);
extern int SDL_RenderFillRects(SDL_Renderer * renderer,
                                                const SDL_Rect * rects,
                                                int count);
extern int SDL_RenderCopy(SDL_Renderer * renderer,
                                           SDL_Texture * texture,
                                           const SDL_Rect * srcrect,
                                           const SDL_Rect * dstrect);
extern int SDL_RenderCopyEx(SDL_Renderer * renderer,
                                           SDL_Texture * texture,
                                           const SDL_Rect * srcrect,
                                           const SDL_Rect * dstrect,
                                           const double angle,
                                           const SDL_Point *center,
                                           const SDL_RendererFlip flip);
extern int SDL_RenderDrawPointF(SDL_Renderer * renderer,
                                                 float x, float y);
extern int SDL_RenderDrawPointsF(SDL_Renderer * renderer,
                                                  const SDL_FPoint * points,
                                                  int count);
extern int SDL_RenderDrawLineF(SDL_Renderer * renderer,
                                                float x1, float y1, float x2, float y2);
extern int SDL_RenderDrawLinesF(SDL_Renderer * renderer,
                                                const SDL_FPoint * points,
                                                int count);
extern int SDL_RenderDrawRectF(SDL_Renderer * renderer,
                                               const SDL_FRect * rect);
extern int SDL_RenderDrawRectsF(SDL_Renderer * renderer,
                                                 const SDL_FRect * rects,
                                                 int count);
extern int SDL_RenderFillRectF(SDL_Renderer * renderer,
                                                const SDL_FRect * rect);
extern int SDL_RenderFillRectsF(SDL_Renderer * renderer,
                                                 const SDL_FRect * rects,
                                                 int count);
extern int SDL_RenderCopyF(SDL_Renderer * renderer,
                                            SDL_Texture * texture,
                                            const SDL_Rect * srcrect,
                                            const SDL_FRect * dstrect);
extern int SDL_RenderCopyExF(SDL_Renderer * renderer,
                                            SDL_Texture * texture,
                                            const SDL_Rect * srcrect,
                                            const SDL_FRect * dstrect,
                                            const double angle,
                                            const SDL_FPoint *center,
                                            const SDL_RendererFlip flip);
extern int SDL_RenderReadPixels(SDL_Renderer * renderer,
                                                 const SDL_Rect * rect,
                                                 Uint32 format,
                                                 void *pixels, int pitch);




extern void SDL_RenderPresent(SDL_Renderer * renderer);







extern void SDL_DestroyTexture(SDL_Texture * texture);







extern void SDL_DestroyRenderer(SDL_Renderer * renderer);
extern int SDL_RenderFlush(SDL_Renderer * renderer);
extern int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh);
extern int SDL_GL_UnbindTexture(SDL_Texture *texture);
extern void * SDL_RenderGetMetalLayer(SDL_Renderer * renderer);
extern void * SDL_RenderGetMetalCommandEncoder(SDL_Renderer * renderer);







struct _SDL_Sensor;
typedef struct _SDL_Sensor SDL_Sensor;







typedef Sint32 SDL_SensorID;
typedef enum
{
    SDL_SENSOR_INVALID = -1,
    SDL_SENSOR_UNKNOWN,
    SDL_SENSOR_ACCEL,
    SDL_SENSOR_GYRO
} SDL_SensorType;
extern int SDL_NumSensors(void);
extern const char * SDL_SensorGetDeviceName(int device_index);
extern SDL_SensorType SDL_SensorGetDeviceType(int device_index);
extern int SDL_SensorGetDeviceNonPortableType(int device_index);
extern SDL_SensorID SDL_SensorGetDeviceInstanceID(int device_index);
extern SDL_Sensor * SDL_SensorOpen(int device_index);




extern SDL_Sensor * SDL_SensorFromInstanceID(SDL_SensorID instance_id);






extern const char * SDL_SensorGetName(SDL_Sensor *sensor);
extern SDL_SensorType SDL_SensorGetType(SDL_Sensor *sensor);
extern int SDL_SensorGetNonPortableType(SDL_Sensor *sensor);
extern SDL_SensorID SDL_SensorGetInstanceID(SDL_Sensor *sensor);
extern int SDL_SensorGetData(SDL_Sensor * sensor, float *data, int num_values);




extern void SDL_SensorClose(SDL_Sensor * sensor);
extern void SDL_SensorUpdate(void);
extern SDL_Window * SDL_CreateShapedWindow(const char *title,unsigned int x,unsigned int y,unsigned int w,unsigned int h,Uint32 flags);
extern SDL_bool SDL_IsShapedWindow(const SDL_Window *window);


typedef enum {

    ShapeModeDefault,

    ShapeModeBinarizeAlpha,

    ShapeModeReverseBinarizeAlpha,

    ShapeModeColorKey
} WindowShapeMode;




typedef union {

    Uint8 binarizationCutoff;
    SDL_Color colorKey;
} SDL_WindowShapeParams;


typedef struct SDL_WindowShapeMode {

    WindowShapeMode mode;

    SDL_WindowShapeParams parameters;
} SDL_WindowShapeMode;
extern int SDL_SetWindowShape(SDL_Window *window,SDL_Surface *shape,SDL_WindowShapeMode *shape_mode);
extern int SDL_GetShapedWindowMode(SDL_Window *window,SDL_WindowShapeMode *shape_mode);






extern SDL_bool SDL_IsTablet(void);


extern void SDL_OnApplicationWillTerminate(void);
extern void SDL_OnApplicationDidReceiveMemoryWarning(void);
extern void SDL_OnApplicationWillResignActive(void);
extern void SDL_OnApplicationDidEnterBackground(void);
extern void SDL_OnApplicationWillEnterForeground(void);
extern void SDL_OnApplicationDidBecomeActive(void);

extern Uint32 SDL_GetTicks(void);
extern Uint64 SDL_GetPerformanceCounter(void);




extern Uint64 SDL_GetPerformanceFrequency(void);




extern void SDL_Delay(Uint32 ms);
typedef Uint32 ( * SDL_TimerCallback) (Uint32 interval, void *param);




typedef int SDL_TimerID;






extern SDL_TimerID SDL_AddTimer(Uint32 interval,
                                                 SDL_TimerCallback callback,
                                                 void *param);
extern SDL_bool SDL_RemoveTimer(SDL_TimerID id);







typedef struct SDL_version
{
    Uint8 major;
    Uint8 minor;
    Uint8 patch;
} SDL_version;
extern void SDL_GetVersion(SDL_version * ver);
extern const char * SDL_GetRevision(void);
extern int SDL_GetRevisionNumber(void);









extern int SDL_Init(Uint32 flags);
extern int SDL_InitSubSystem(Uint32 flags);




extern void SDL_QuitSubSystem(Uint32 flags);







extern Uint32 SDL_WasInit(Uint32 flags);





extern void SDL_Quit(void);






extern const SDL_version * IMG_Linked_Version(void);

typedef enum
{
    IMG_INIT_JPG = 0x00000001,
    IMG_INIT_PNG = 0x00000002,
    IMG_INIT_TIF = 0x00000004,
    IMG_INIT_WEBP = 0x00000008
} IMG_InitFlags;





extern int IMG_Init(int flags);


extern void IMG_Quit(void);
extern SDL_Surface * IMG_LoadTyped_RW(SDL_RWops *src, int freesrc, const char *type);

extern SDL_Surface * IMG_Load(const char *file);
extern SDL_Surface * IMG_Load_RW(SDL_RWops *src, int freesrc);




extern SDL_Texture * IMG_LoadTexture(SDL_Renderer *renderer, const char *file);
extern SDL_Texture * IMG_LoadTexture_RW(SDL_Renderer *renderer, SDL_RWops *src, int freesrc);
extern SDL_Texture * IMG_LoadTextureTyped_RW(SDL_Renderer *renderer, SDL_RWops *src, int freesrc, const char *type);



extern int IMG_isICO(SDL_RWops *src);
extern int IMG_isCUR(SDL_RWops *src);
extern int IMG_isBMP(SDL_RWops *src);
extern int IMG_isGIF(SDL_RWops *src);
extern int IMG_isJPG(SDL_RWops *src);
extern int IMG_isLBM(SDL_RWops *src);
extern int IMG_isPCX(SDL_RWops *src);
extern int IMG_isPNG(SDL_RWops *src);
extern int IMG_isPNM(SDL_RWops *src);
extern int IMG_isSVG(SDL_RWops *src);
extern int IMG_isTIF(SDL_RWops *src);
extern int IMG_isXCF(SDL_RWops *src);
extern int IMG_isXPM(SDL_RWops *src);
extern int IMG_isXV(SDL_RWops *src);
extern int IMG_isWEBP(SDL_RWops *src);


extern SDL_Surface * IMG_LoadICO_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadCUR_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadBMP_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadGIF_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadJPG_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadLBM_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadPCX_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadPNG_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadPNM_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadSVG_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadTGA_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadTIF_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadXCF_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadXPM_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadXV_RW(SDL_RWops *src);
extern SDL_Surface * IMG_LoadWEBP_RW(SDL_RWops *src);

extern SDL_Surface * IMG_ReadXPMFromArray(char **xpm);


extern int IMG_SavePNG(SDL_Surface *surface, const char *file);
extern int IMG_SavePNG_RW(SDL_Surface *surface, SDL_RWops *dst, int freedst);
extern int IMG_SaveJPG(SDL_Surface *surface, const char *file, int quality);
extern int IMG_SaveJPG_RW(SDL_Surface *surface, SDL_RWops *dst, int freedst, int quality);
extern const SDL_version * TTF_Linked_Version(void);
extern void TTF_ByteSwappedUNICODE(int swapped);


typedef struct _TTF_Font TTF_Font;


extern int TTF_Init(void);





extern TTF_Font * TTF_OpenFont(const char *file, int ptsize);
extern TTF_Font * TTF_OpenFontIndex(const char *file, int ptsize, long index);
extern TTF_Font * TTF_OpenFontRW(SDL_RWops *src, int freesrc, int ptsize);
extern TTF_Font * TTF_OpenFontIndexRW(SDL_RWops *src, int freesrc, int ptsize, long index);







extern int TTF_GetFontStyle(const TTF_Font *font);
extern void TTF_SetFontStyle(TTF_Font *font, int style);
extern int TTF_GetFontOutline(const TTF_Font *font);
extern void TTF_SetFontOutline(TTF_Font *font, int outline);






extern int TTF_GetFontHinting(const TTF_Font *font);
extern void TTF_SetFontHinting(TTF_Font *font, int hinting);


extern int TTF_FontHeight(const TTF_Font *font);




extern int TTF_FontAscent(const TTF_Font *font);




extern int TTF_FontDescent(const TTF_Font *font);


extern int TTF_FontLineSkip(const TTF_Font *font);


extern int TTF_GetFontKerning(const TTF_Font *font);
extern void TTF_SetFontKerning(TTF_Font *font, int allowed);


extern long TTF_FontFaces(const TTF_Font *font);


extern int TTF_FontFaceIsFixedWidth(const TTF_Font *font);
extern char * TTF_FontFaceFamilyName(const TTF_Font *font);
extern char * TTF_FontFaceStyleName(const TTF_Font *font);


extern int TTF_GlyphIsProvided(const TTF_Font *font, Uint16 ch);





extern int TTF_GlyphMetrics(TTF_Font *font, Uint16 ch,
                     int *minx, int *maxx,
                                     int *miny, int *maxy, int *advance);


extern int TTF_SizeText(TTF_Font *font, const char *text, int *w, int *h);
extern int TTF_SizeUTF8(TTF_Font *font, const char *text, int *w, int *h);
extern int TTF_SizeUNICODE(TTF_Font *font, const Uint16 *text, int *w, int *h);







extern SDL_Surface * TTF_RenderText_Solid(TTF_Font *font,
                const char *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderUTF8_Solid(TTF_Font *font,
                const char *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderUNICODE_Solid(TTF_Font *font,
                const Uint16 *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderGlyph_Solid(TTF_Font *font,
                    Uint16 ch, SDL_Color fg);






extern SDL_Surface * TTF_RenderText_Shaded(TTF_Font *font,
                const char *text, SDL_Color fg, SDL_Color bg);
extern SDL_Surface * TTF_RenderUTF8_Shaded(TTF_Font *font,
                const char *text, SDL_Color fg, SDL_Color bg);
extern SDL_Surface * TTF_RenderUNICODE_Shaded(TTF_Font *font,
                const Uint16 *text, SDL_Color fg, SDL_Color bg);
extern SDL_Surface * TTF_RenderGlyph_Shaded(TTF_Font *font,
                Uint16 ch, SDL_Color fg, SDL_Color bg);





extern SDL_Surface * TTF_RenderText_Blended(TTF_Font *font,
                const char *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderUTF8_Blended(TTF_Font *font,
                const char *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderUNICODE_Blended(TTF_Font *font,
                const Uint16 *text, SDL_Color fg);
extern SDL_Surface * TTF_RenderText_Blended_Wrapped(TTF_Font *font,
                const char *text, SDL_Color fg, Uint32 wrapLength);
extern SDL_Surface * TTF_RenderUTF8_Blended_Wrapped(TTF_Font *font,
                const char *text, SDL_Color fg, Uint32 wrapLength);
extern SDL_Surface * TTF_RenderUNICODE_Blended_Wrapped(TTF_Font *font,
                const Uint16 *text, SDL_Color fg, Uint32 wrapLength);







extern SDL_Surface * TTF_RenderGlyph_Blended(TTF_Font *font,
                        Uint16 ch, SDL_Color fg);
extern void TTF_CloseFont(TTF_Font *font);


extern void TTF_Quit(void);


extern int TTF_WasInit(void);







extern int TTF_GetFontKerningSize(TTF_Font *font, int prev_index, int index) ;


extern int TTF_GetFontKerningSizeGlyphs(TTF_Font *font, Uint16 previous_ch, Uint16 ch);

