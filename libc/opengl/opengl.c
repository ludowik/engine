typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long uint64_t;

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
typedef double GLdouble;
typedef double GLclampd;

typedef intptr_t GLintptr;
typedef intptr_t GLsizeiptr;

#define GL_NO_ERROR 0

#define GL_TRUE 1
#define GL_FALSE 0

#define GL_INVALID_ENUM 0x0500
#define GL_INVALID_FRAMEBUFFER_OPERATION 0x0506
#define GL_INVALID_INDEX 0xFFFFFFFFu
#define GL_INVALID_OPERATION 0x0502
#define GL_INVALID_VALUE 0x0501

#define GL_ACTIVE_ATTRIBUTES 0x8B89
#define GL_ACTIVE_ATTRIBUTE_MAX_LENGTH 0x8B8A
#define GL_ACTIVE_PROGRAM 0x8259
#define GL_ACTIVE_SUBROUTINES 0x8DE5
#define GL_ACTIVE_SUBROUTINE_MAX_LENGTH 0x8E48
#define GL_ACTIVE_SUBROUTINE_UNIFORMS 0x8DE6
#define GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS 0x8E47
#define GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH 0x8E49
#define GL_ACTIVE_TEXTURE 0x84E0
#define GL_ACTIVE_UNIFORMS 0x8B86
#define GL_ACTIVE_UNIFORM_BLOCKS 0x8A36
#define GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH 0x8A35
#define GL_ACTIVE_UNIFORM_MAX_LENGTH 0x8B87

#define GL_LINE_SMOOTH 0x0B20
#define GL_LINE_SMOOTH_HINT 0x0C52

#define GL_POLYGON_SMOOTH 0x0B41
#define GL_POLYGON_SMOOTH_HINT 0x0C53

#define GL_MULTISAMPLE 0x809D

#define GL_NEAREST 0x2600
#define GL_NEAREST_MIPMAP_LINEAR 0x2702
#define GL_NEAREST_MIPMAP_NEAREST 0x2700
#define GL_NICEST 0x1102

#define GL_DITHER 0x0BD0

#define GL_STENCIL_TEST 0x0B90

#define GL_VERTEX_SHADER 0x8B31
#define GL_GEOMETRY_SHADER 0x8DD9
#define GL_FRAGMENT_SHADER 0x8B30

#define GL_SHADER_BINARY_FORMATS 0x8DF8
#define GL_SHADER_COMPILER 0x8DFA
#define GL_SHADER_SOURCE_LENGTH 0x8B88
#define GL_SHADER_TYPE 0x8B4F
#define GL_SHADING_LANGUAGE_VERSION 0x8B8C

#define GL_COMPILE_STATUS 0x8B81
#define GL_INFO_LOG_LENGTH 0x8B84

#define GL_LINK_STATUS 0x8B82

#define GL_ARRAY_BUFFER 0x8892
#define GL_ELEMENT_ARRAY_BUFFER 0x8893

#define GL_STATIC_DRAW 0x88E4
#define GL_DYNAMIC_DRAW 0x88E8
#define GL_STREAM_DRAW 0x88E0

#define GL_POINTS 0x0000

#define GL_LINES 0x0001
#define GL_LINES_ADJACENCY 0x000A
#define GL_LINE_LOOP 0x0002
#define GL_LINE_STRIP 0x0003
#define GL_LINE_STRIP_ADJACENCY 0x000B

#define GL_TRIANGLES 0x0004
#define GL_TRIANGLES_ADJACENCY 0x000C
#define GL_TRIANGLE_FAN 0x0006
#define GL_TRIANGLE_STRIP 0x0005
#define GL_TRIANGLE_STRIP_ADJACENCY 0x000D

#define GL_UNSIGNED_BYTE 0x1401
#define GL_SHORT 0x1402
#define GL_UNSIGNED_SHORT 0x1403
#define GL_INT 0x1404
#define GL_UNSIGNED_INT 0x1405
#define GL_FLOAT 0x1406
#define GL_FLOAT_VEC2 0x8B50
#define GL_FLOAT_VEC3 0x8B51
#define GL_FLOAT_VEC4 0x8B52
#define GL_INT_VEC2 0x8B53
#define GL_INT_VEC3 0x8B54
#define GL_INT_VEC4 0x8B55
#define GL_BOOL 0x8B56
#define GL_BOOL_VEC2 0x8B57
#define GL_BOOL_VEC3 0x8B58
#define GL_BOOL_VEC4 0x8B59
#define GL_FLOAT_MAT2 0x8B5A
#define GL_FLOAT_MAT3 0x8B5B
#define GL_FLOAT_MAT4 0x8B5C
#define GL_SAMPLER_1D 0x8B5D
#define GL_SAMPLER_2D 0x8B5E
#define GL_SAMPLER_3D 0x8B5F
#define GL_SAMPLER_CUBE 0x8B60
#define GL_SAMPLER_1D_SHADOW 0x8B61
#define GL_SAMPLER_2D_SHADOW 0x8B62

#define GL_COLOR_BUFFER_BIT 0x00004000
#define GL_DEPTH_BUFFER_BIT 0x00000100

#define GL_TEXTURE_2D 0x0DE1

#define GL_TEXTURE0 0x84C0
#define GL_TEXTURE1 0x84C1

#define GL_TEXTURE_MIN_FILTER 0x2801
#define GL_TEXTURE_MAG_FILTER 0x2800

#define GL_TEXTURE_WRAP_R 0x8072
#define GL_TEXTURE_WRAP_S 0x2802
#define GL_TEXTURE_WRAP_T 0x2803

#define GL_LINEAR 0x2601

#define GL_CLAMP_TO_BORDER 0x812D
#define GL_CLAMP_TO_EDGE 0x812F

#define GL_ALPHA 0x1906

#define GL_RED 0x1903
#define GL_RED_INTEGER 0x8D94

#define GL_RGB 0x1907
#define GL_BGR 0x80E0

#define GL_RGBA 0x1908
#define GL_BGRA 0x80E1

#define GL_RGBA8 0x8058

#define GL_UNPACK_ALIGNMENT 0x0CF5

#define GL_BLEND 0x0BE2
#define GL_FUNC_ADD 0x8006

#define GL_ZERO 0
#define GL_ONE 1

#define GL_DST_ALPHA 0x0304
#define GL_DST_COLOR 0x0306

#define GL_SRC_ALPHA 0x0302
#define GL_ONE_MINUS_SRC_ALPHA 0x0303

#define GL_DEPTH_TEST 0x0B71

#define GL_CULL_FACE 0x0B44
#define GL_CULL_FACE_MODE 0x0B45
#define GL_CW 0x0900
#define GL_CCW 0x0901

#define GL_BACK 0x0405
#define GL_BACK_LEFT 0x0402
#define GL_BACK_RIGHT 0x0403
#define GL_FRONT 0x0404
#define GL_FRONT_AND_BACK 0x0408
#define GL_FRONT_FACE 0x0B46
#define GL_FRONT_LEFT 0x0400
#define GL_FRONT_RIGHT 0x0401

#define GL_EQUAL 0x0202

#define GL_LEQUAL 0x0203
#define GL_LESS 0x0201

#define GL_GEQUAL 0x0206
#define GL_GREATER 0x0204

#define GL_FILL 0x1B02
#define GL_LINE 0x1B01

#define GL_FRAMEBUFFER 0x8D40
#define GL_RENDERBUFFER 0x8D41

#define GL_RENDERBUFFER_ALPHA_SIZE 0x8D53
#define GL_RENDERBUFFER_BINDING 0x8CA7
#define GL_RENDERBUFFER_BLUE_SIZE 0x8D52
#define GL_RENDERBUFFER_DEPTH_SIZE 0x8D54
#define GL_RENDERBUFFER_FREE_MEMORY_ATI 0x87FD
#define GL_RENDERBUFFER_GREEN_SIZE 0x8D51
#define GL_RENDERBUFFER_HEIGHT 0x8D43
#define GL_RENDERBUFFER_INTERNAL_FORMAT 0x8D44
#define GL_RENDERBUFFER_RED_SIZE 0x8D50
#define GL_RENDERBUFFER_SAMPLES 0x8CAB
#define GL_RENDERBUFFER_STENCIL_SIZE 0x8D55
#define GL_RENDERBUFFER_WIDTH 0x8D42

#define GL_FRAMEBUFFER_BINDING 0x8CA6
#define GL_FRAMEBUFFER_COMPLETE 0x8CD5
#define GL_FRAMEBUFFER_DEFAULT 0x8218

#define GL_DEPTH_COMPONENT16 0x81A5
#define GL_DEPTH_COMPONENT24 0x81A6
#define GL_DEPTH_COMPONENT32 0x81A7

#define GL_DEPTH_ATTACHMENT 0x8D00

#define GL_COLOR_ATTACHMENT0 0x8CE0
#define GL_COLOR_ATTACHMENT1 0x8CE1
#define GL_COLOR_ATTACHMENT2 0x8CE2
#define GL_COLOR_ATTACHMENT3 0x8CE3
#define GL_COLOR_ATTACHMENT4 0x8CE4
#define GL_COLOR_ATTACHMENT5 0x8CE5
#define GL_COLOR_ATTACHMENT6 0x8CE6
#define GL_COLOR_ATTACHMENT7 0x8CE7
#define GL_COLOR_ATTACHMENT8 0x8CE8
#define GL_COLOR_ATTACHMENT9 0x8CE9

#define GL_SCISSOR_TEST 0x0C11

#define GL_PROGRAM_POINT_SIZE 0x8642
#define GL_VERTEX_PROGRAM_POINT_SIZE 0x8642

GLenum glGetError(void);

const GLubyte* glGetString(GLenum name);

void glGetIntegerv(GLenum pname, GLint *params);

void glEnable(GLenum cap);
void glDisable(GLenum cap);

void glHint(GLenum target, GLenum mode);

GLboolean glIsProgram(GLuint program);
GLuint glCreateProgram(void);
void glDeleteProgram(GLuint program);

GLboolean glIsShader(GLuint shader);
GLuint glCreateShader(GLenum type);
void glShaderSource(GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length);
void glCompileShader(GLuint shader);
void glGetShaderiv(GLuint shader, GLenum pname, GLint *params);
void glAttachShader(GLuint program, GLuint shader);
void glDetachShader(GLuint shader);
void glDeleteShader(GLuint shader);
void glGetShaderInfoLog(GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
void glLinkProgram(GLuint program);
void glGetProgramiv(	GLuint program, GLenum pname, GLint *params);
void glGetProgramInfoLog(GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
void glUseProgram(GLuint program);

GLboolean glIsBuffer(GLuint buffer);
void glGenBuffers(GLsizei n, GLuint *buffers);
void glDeleteBuffers(GLsizei n, const GLuint *buffers);
void glBindBuffer(GLenum target, GLuint buffer);
void glBufferData(GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
void glBufferSubData(GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);

GLboolean glIsVertexArray(GLuint array);
void glGenVertexArrays(GLsizei n, GLuint *arrays);
void glDeleteVertexArrays(GLsizei n, const GLuint *arrays);
void glBindVertexArray(GLuint array);

GLboolean glIsTexture(GLuint texture);
void glGenTextures(GLsizei n, GLuint *textures);
void glDeleteTextures(GLsizei n, const GLuint *textures);
void glBindTexture(GLenum target, GLuint texture);
void glActiveTexture(GLenum texture);
void glTexImage2D(GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
void glTexSubImage2D(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
void glPixelStorei(GLenum pname, GLint param);
void glTexParameteri(GLenum target, GLenum pname, GLint param);
void glGetTexImage(GLenum target, GLint level, GLenum format, GLenum type, void* pixels);
void glGenFramebuffers(GLsizei n, GLuint *ids);
void glDeleteFramebuffers(GLsizei n, const GLuint *ids);
void glBindFramebuffer(GLenum target, GLuint framebuffer);
void glGenRenderbuffers(GLsizei n, GLuint *renderbuffers);
void glDeleteRenderbuffers(GLsizei n, const GLuint *renderbuffers);
void glBindRenderbuffer(GLenum target, GLuint renderbuffer);
void glRenderbufferStorage(GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
void glFramebufferRenderbuffer(GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
void glFramebufferTexture1D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glFramebufferTexture2D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
void glFramebufferTexture3D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
void glFramebufferTexture(GLenum target, GLenum attachment, GLuint texture, GLint level);
void glDrawBuffer(GLenum buf);
void glDrawBuffers(GLsizei n, const GLenum *bufs);
GLenum glCheckFramebufferStatus(GLenum target);

GLint glGetAttribLocation(GLuint program, const GLchar *name);
void glGetActiveAttrib(GLuint program​, GLuint index​, GLsizei bufSize​, GLsizei *length​, GLint *size​, GLenum *type​, GLchar *name​);

GLint glGetUniformLocation(GLuint program, const GLchar *name);
void glGetActiveUniform(GLuint program​, GLuint index​, GLsizei bufSize​, GLsizei *length​, GLint *size​, GLenum *type​, char *name​);
void glGetActiveUniformName(GLuint program​, GLuint uniformIndex​, GLsizei bufSize​, GLsizei *length​, GLchar *uniformName​);

void glUniform1f(GLint location, GLfloat v0);
void glUniform2f(GLint location, GLfloat v0, GLfloat v1);
void glUniform3f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
void glUniform4f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
void glUniform1i(GLint location, GLint v0);
void glUniform2i(GLint location, GLint v0, GLint v1);
void glUniform3i(GLint location, GLint v0, GLint v1, GLint v2);
void glUniform4i(GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
void glUniform1fv(GLint location, GLsizei count, const GLfloat *value);
void glUniform2fv(GLint location, GLsizei count, const GLfloat *value);
void glUniform3fv(GLint location, GLsizei count, const GLfloat *value);
void glUniform4fv(GLint location, GLsizei count, const GLfloat *value);
void glUniform1iv(GLint location, GLsizei count, const GLint *value);
void glUniform2iv(GLint location, GLsizei count, const GLint *value);
void glUniform3iv(GLint location, GLsizei count, const GLint *value);
void glUniform4iv(GLint location, GLsizei count, const GLint *value);
void glUniformMatrix2fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix3fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
void glUniformMatrix4fv(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);

void glVertexAttribPointer(GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);
void glVertexAttribDivisor(GLuint index, GLuint divisor);

void glEnableVertexAttribArray(GLuint index);
void glDisableVertexAttribArray(GLuint index);

void glViewport(GLint x, GLint y, GLsizei width, GLsizei height);

void glClear(GLbitfield mask);
void glClearColor(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
void glClearStencil(GLint s);
void glClearDepth(GLdouble depth);
void glClearDepthf(GLfloat depth);

void glBlendEquation(GLenum mode);
void glBlendFunc(GLenum sfactor, GLenum dfactor);
void glBlendFuncSeparate(GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);

void glDepthFunc(GLenum func);

void glCullFace(GLenum mode);
void glFrontFace(GLenum mode);

void glLineWidth(GLfloat width);
void glPointSize(GLfloat size);
void glPolygonMode(GLenum face, GLenum mode);

void glDrawArrays(GLenum mode, GLint first, GLsizei count);
void glDrawElements(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);

void glDrawArraysInstanced(GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
void glDrawElementsInstanced(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);

void glScissor(GLint x, GLint y, GLsizei width, GLsizei height);

typedef GLenum (*PFN_glGetError)(void);

typedef const GLubyte *(*PFN_glGetString)(GLenum name);

typedef void (*PFN_glGetIntegerv)(GLenum pname, GLint *params);

typedef void (*PFN_glEnable)(GLenum cap);
typedef void (*PFN_glDisable)(GLenum cap);

typedef void (*PFN_glHint)(GLenum target, GLenum mode);

typedef GLboolean (*PFN_glIsProgram)(GLuint program);
typedef GLuint (*PFN_glCreateProgram)(void);
typedef void (*PFN_glDeleteProgram)(GLuint program);

typedef GLboolean (*PFN_glIsShader)(GLuint shader);
typedef GLuint (*PFN_glCreateShader)(GLenum type);
typedef void (*PFN_glShaderSource)(GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length);
typedef void (*PFN_glCompileShader)(GLuint shader);
typedef void (*PFN_glGetShaderiv)(GLuint shader, GLenum pname, GLint *params);
typedef void (*PFN_glAttachShader)(GLuint program, GLuint shader);
typedef void (*PFN_glDetachShader)(GLuint program, GLuint shader);
typedef void (*PFN_glDeleteShader)(GLuint shader);
typedef void (*PFN_glGetShaderInfoLog)(GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (*PFN_glLinkProgram)(GLuint program);
typedef void (*PFN_glGetProgramiv)(GLuint program, GLenum pname, GLint *params);
typedef void (*PFN_glGetProgramInfoLog)(GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog);
typedef void (*PFN_glUseProgram)(GLuint program);

typedef GLboolean (*PFN_glIsBuffer)(GLuint buffer);
typedef void (*PFN_glGenBuffers)(GLsizei n, GLuint *buffers);
typedef void (*PFN_glDeleteBuffers)(GLsizei n, const GLuint *buffers);
typedef void (*PFN_glBindBuffer)(GLenum target, GLuint buffer);
typedef void (*PFN_glBufferData)(GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
typedef void (*PFN_glBufferSubData)(GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);

typedef GLboolean (*PFN_glIsVertexArray)(GLuint array);
typedef void (*PFN_glGenVertexArrays)(GLsizei n, GLuint *arrays);
typedef void (*PFN_glDeleteVertexArrays)(GLsizei n, const GLuint *arrays);
typedef void (*PFN_glBindVertexArray)(GLuint array);

typedef GLboolean (*PFN_glIsTexture)(GLuint texture);
typedef void (*PFN_glGenTextures)(GLsizei n, GLuint *textures);
typedef void (*PFN_glDeleteTextures)(GLsizei n, const GLuint *textures);
typedef void (*PFN_glBindTexture)(GLenum target, GLuint texture);
typedef void (*PFN_glActiveTexture)(GLenum texture);
typedef void (*PFN_glTexImage2D)(GLenum target, GLint level, GLint internalformat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid *pixels);
typedef void (*PFN_glTexSubImage2D)(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLsizei width, GLsizei height, GLenum format, GLenum type, const void *pixels);
typedef void (*PFN_glPixelStorei)(GLenum pname, GLint param);
typedef void (*PFN_glTexParameteri)(GLenum target, GLenum pname, GLint param);
typedef void (*PFN_glGetTexImage)(GLenum target, GLint level, GLenum format, GLenum type, void* pixels);
typedef void (*PFN_glGenFramebuffers)(GLsizei n, GLuint *ids);
typedef void (*PFN_glDeleteFramebuffers)(GLsizei n, const GLuint *ids);
typedef void (*PFN_glBindFramebuffer)(GLenum target, GLuint framebuffer);
typedef void (*PFN_glGenRenderbuffers)(GLsizei n, GLuint *renderbuffers);
typedef void (*PFN_glDeleteRenderbuffers)(GLsizei n, GLuint *renderbuffers);
typedef void (*PFN_glBindRenderbuffer)(GLenum target, GLuint renderbuffer);
typedef void (*PFN_glRenderbufferStorage)(GLenum target, GLenum internalformat, GLsizei width, GLsizei height);
typedef void (*PFN_glFramebufferRenderbuffer)(GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer);
typedef void (*PFN_glFramebufferTexture1D)(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (*PFN_glFramebufferTexture2D)(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level);
typedef void (*PFN_glFramebufferTexture3D)(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset);
typedef void (*PFN_glFramebufferTexture)(GLenum target, GLenum attachment, GLuint texture, GLint level);
typedef void (*PFN_glDrawBuffer)(GLenum buf);
typedef void (*PFN_glDrawBuffers)(GLsizei n, const GLenum *bufs);
typedef GLenum (*PFN_glCheckFramebufferStatus)(GLenum target);

typedef GLint (*PFN_glGetAttribLocation)(GLuint program, const GLchar *name);
typedef void (*PFN_glGetActiveAttrib)(GLuint program​, GLuint index​, GLsizei bufSize​, GLsizei *length​, GLint *size​, GLenum *type​, GLchar *name​);

typedef GLint (*PFN_glGetUniformLocation)(GLuint program, const GLchar *name);
typedef void (*PFN_glGetActiveUniform)(GLuint program​, GLuint index​, GLsizei bufSize​, GLsizei *length​, GLint *size​, GLenum *type​, char *name​);
typedef void (*PFN_glGetActiveUniformName)(GLuint program​, GLuint uniformIndex​, GLsizei bufSize​, GLsizei *length​, GLchar *uniformName​);

typedef void (*PFN_glUniform1f)(GLint location, GLfloat v0);
typedef void (*PFN_glUniform2f)(GLint location, GLfloat v0, GLfloat v1);
typedef void (*PFN_glUniform3f)(GLint location, GLfloat v0, GLfloat v1, GLfloat v2);
typedef void (*PFN_glUniform4f)(GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);
typedef void (*PFN_glUniform1i)(GLint location, GLint v0);
typedef void (*PFN_glUniform2i)(GLint location, GLint v0, GLint v1);
typedef void (*PFN_glUniform3i)(GLint location, GLint v0, GLint v1, GLint v2);
typedef void (*PFN_glUniform4i)(GLint location, GLint v0, GLint v1, GLint v2, GLint v3);
typedef void (*PFN_glUniform1fv)(GLint location, GLsizei count, const GLfloat *value);
typedef void (*PFN_glUniform2fv)(GLint location, GLsizei count, const GLfloat *value);
typedef void (*PFN_glUniform3fv)(GLint location, GLsizei count, const GLfloat *value);
typedef void (*PFN_glUniform4fv)(GLint location, GLsizei count, const GLfloat *value);
typedef void (*PFN_glUniform1iv)(GLint location, GLsizei count, const GLint *value);
typedef void (*PFN_glUniform2iv)(GLint location, GLsizei count, const GLint *value);
typedef void (*PFN_glUniform3iv)(GLint location, GLsizei count, const GLint *value);
typedef void (*PFN_glUniform4iv)(GLint location, GLsizei count, const GLint *value);
typedef void (*PFN_glUniformMatrix2fv)(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (*PFN_glUniformMatrix3fv)(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);
typedef void (*PFN_glUniformMatrix4fv)(GLint location, GLsizei count, GLboolean transpose, const GLfloat *value);

typedef void (*PFN_glVertexAttribPointer)(GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer);
typedef void (*PFN_glVertexAttribDivisor)(GLuint index, GLuint divisor);

typedef void (*PFN_glEnableVertexAttribArray)(GLuint index);
typedef void (*PFN_glDisableVertexAttribArray)(GLuint index);

typedef void (*PFN_glViewport)(GLint x, GLint y, GLsizei width, GLsizei height);

typedef void (*PFN_glClear)(GLbitfield mask);
typedef void (*PFN_glClearColor)(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);
typedef void (*PFN_glClearStencil)(GLint s);
typedef void (*PFN_glClearDepth)(GLdouble depth);
typedef void (*PFN_glClearDepthf)(GLfloat depth);

typedef void (*PFN_glBlendEquation)(GLenum mode);
typedef void (*PFN_glBlendFunc)(GLenum sfactor, GLenum dfactor);
typedef void (*PFN_glBlendFuncSeparate)(GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha);

typedef void (*PFN_glDepthFunc)(GLenum func);

typedef void (*PFN_glCullFace)(GLenum mode);
typedef void (*PFN_glFrontFace)(GLenum mode);

typedef void (*PFN_glLineWidth)(GLfloat width);
typedef void (*PFN_glPointSize)(GLfloat size);
typedef void (*PFN_glPolygonMode)(GLenum face, GLenum mode);

typedef void (*PFN_glDrawArrays)(GLenum mode, GLint first, GLsizei count);
typedef void (*PFN_glDrawElements)(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices);

typedef void (*PFN_glDrawArraysInstanced)(GLenum mode, GLint first, GLsizei count, GLsizei instancecount);
typedef void (*PFN_glDrawElementsInstanced)(GLenum mode, GLsizei count, GLenum type, const GLvoid *indices, GLsizei instancecount);

typedef void (*PFN_glScissor)(GLint x, GLint y, GLsizei width, GLsizei height);
