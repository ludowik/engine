typedef struct ALCdevice_struct ALCdevice;
typedef struct ALCcontext_struct ALCcontext;

typedef char ALCboolean;
typedef char ALCchar;
typedef char ALCbyte;
typedef unsigned char ALCubyte;
typedef short ALCshort;
typedef unsigned short ALCushort;
typedef int ALCint;
typedef unsigned int ALCuint;
typedef int ALCsizei;
typedef int ALCenum;
typedef float ALCfloat;
typedef double ALCdouble;
typedef void ALCvoid;

ALCdevice* alcOpenDevice(const ALCchar *devicename);
ALCdevice* alcGetContextsDevice(ALCcontext* context);
ALCboolean alcCloseDevice(ALCdevice *device);

ALCcontext* alcCreateContext(ALCdevice *device, ALCint *attrlist);
ALCboolean alcMakeContextCurrent(ALCcontext *context);
ALCcontext* alcGetCurrentContext();
void alcDestroyContext(ALCcontext *context);

typedef char ALboolean;
typedef char ALchar;
typedef char ALbyte;
typedef unsigned char ALubyte;
typedef short ALshort;
typedef unsigned short ALushort;
typedef int ALint;
typedef unsigned int ALuint;
typedef int ALsizei;
typedef int ALenum;
typedef float ALfloat;
typedef double ALdouble;
typedef void ALvoid;

#define ALC_TRUE 1
#define ALC_FALSE 0

#define ALC_NO_ERROR ALC_FALSE

#define ALC_INVALID 0
#define ALC_INVALID_CONTEXT 0xA002
#define ALC_INVALID_DEVICE 0xA001
#define ALC_INVALID_ENUM 0xA003
#define ALC_INVALID_VALUE 0xA004

#define AL_INITIAL 0x1011
#define AL_INVALID (-1)
#define AL_INVALID_ENUM 0xA002
#define AL_INVALID_NAME 0xA001
#define AL_INVALID_OPERATION 0xA004
#define AL_INVALID_VALUE 0xA003

#define AL_ILLEGAL_COMMAND AL_INVALID_OPERATION
#define AL_ILLEGAL_ENUM AL_INVALID_ENUM

#define AL_TRUE 1
#define AL_FALSE 0

#define AL_NO_ERROR AL_FALSE

#define AL_BUFFER 0x1009

#define AL_GAIN 0x100A
#define AL_PITCH 0x1003
#define AL_LOOPING 0x1007
#define AL_POSITION 0x1004
#define AL_VELOCITY 0x1006
#define AL_PAUSED 0x1013
#define AL_PENDING 0x2011
#define AL_PLAYING 0x1012
#define AL_PROCESSED 0x2012
#define AL_ORIENTATION 0x100F

#define AL_SOURCE_RELATIVE 0x202
#define AL_SOURCE_STATE 0x1010
#define AL_SOURCE_TYPE 0x1027

#define AL_FORMAT_MONO16 0x1101
#define AL_FORMAT_MONO8 0x1100
#define AL_FORMAT_STEREO16 0x1103
#define AL_FORMAT_STEREO8 0x1102

void* alGetProcAddress(const ALchar* fname);

typedef void* (*PFN_alGetProcAddress)(const ALchar* fname);

typedef ALenum (*PFN_alGetError)(ALvoid);

typedef ALboolean (*PFN_alIsSource)(ALuint source);
typedef void (*PFN_alGenSources)(ALsizei n, ALuint *sources);
typedef void (*PFN_alDeleteSources)(ALsizei n, ALuint *sources);

typedef void (*PFN_alSourcePlay)(ALuint source);
typedef void (*PFN_alSourcePause)(ALuint source);
typedef void (*PFN_alSourceRewind)(ALuint source);
typedef void (*PFN_alSourceStop)(ALuint source);

typedef void (*PFN_alSourcef)(ALuint source, ALenum param, ALfloat value);
typedef void (*PFN_alSourcei)(ALuint source, ALenum param, ALint value);
typedef void (*PFN_alSource3f)(ALuint source, ALenum param, ALfloat v1, ALfloat v2, ALfloat v3);

typedef void (*PFN_alGetSourcef)(ALuint sid, ALenum param, ALfloat* value);
typedef void (*PFN_alGetSourcei)(ALuint sid, ALenum param, ALint* value);

typedef void (*PFN_alListenerf)(ALenum param, ALfloat value );
typedef void (*PFN_alListener3f)(ALenum param, ALfloat value1, ALfloat value2, ALfloat value3);
typedef void (*PFN_alListenerfv)(ALenum param, const ALfloat* values);
typedef void (*PFN_alListeneri)(ALenum param, ALint value);
typedef void (*PFN_alListener3i)(ALenum param, ALint value1, ALint value2, ALint value3);
typedef void (*PFN_alListeneriv)(ALenum param, const ALint* values);

typedef void (*PFN_alGetListenerf)(ALenum param, ALfloat* value );
typedef void (*PFN_alGetListener3f)(ALenum param, ALfloat *value1, ALfloat *value2, ALfloat *value3);
typedef void (*PFN_alGetListenerfv)(ALenum param, ALfloat* values);
typedef void (*PFN_alGetListeneri)(ALenum param, ALint* value);
typedef void (*PFN_alGetListener3i)(ALenum param, ALint *value1, ALint *value2, ALint *value3);
typedef void (*PFN_alGetListeneriv)(ALenum param, ALint* values);

typedef ALboolean (*PFN_alIsBuffer)(ALuint buffer);
typedef void (*PFN_alGenBuffers)(ALsizei n, ALuint* buffers);
typedef void (*PFN_alDeleteBuffers)(ALsizei n, ALuint *buffers);

typedef void ( *PFN_alBufferData)( ALuint bid, ALenum format, const ALvoid* data, ALsizei size, ALsizei freq );
typedef void ( *PFN_ALBUFFERF)( ALuint bid, ALenum param, ALfloat value);
typedef void ( *PFN_ALBUFFER3F)( ALuint bid, ALenum param, ALfloat value1, ALfloat value2, ALfloat value3 );
typedef void ( *PFN_ALBUFFERFV)( ALuint bid, ALenum param, const ALfloat* values );
typedef void ( *PFN_ALBUFFERI)( ALuint bid, ALenum param, ALint value);
typedef void ( *PFN_ALBUFFER3I)( ALuint bid, ALenum param, ALint value1, ALint value2, ALint value3 );
typedef void ( *PFN_ALBUFFERIV)( ALuint bid, ALenum param, const ALint* values );
typedef void ( *PFN_ALGETBUFFERF)( ALuint bid, ALenum param, ALfloat* value );
typedef void ( *PFN_ALGETBUFFER3F)( ALuint bid, ALenum param, ALfloat* value1, ALfloat* value2, ALfloat* value3);
typedef void ( *PFN_ALGETBUFFERFV)( ALuint bid, ALenum param, ALfloat* values );
typedef void ( *PFN_ALGETBUFFERI)( ALuint bid, ALenum param, ALint* value );
typedef void ( *PFN_ALGETBUFFER3I)( ALuint bid, ALenum param, ALint* value1, ALint* value2, ALint* value3);
typedef void ( *PFN_ALGETBUFFERIV)( ALuint bid, ALenum param, ALint* values );

