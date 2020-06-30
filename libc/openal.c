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
ALCboolean alcCloseDevice(ALCdevice *device);

ALCcontext* alcCreateContext(ALCdevice *device, ALCint *attrlist);
ALCboolean alcMakeContextCurrent(ALCcontext *context);
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

ALenum alGetError(ALvoid);

ALboolean alIsBuffer(ALuint buffer); 
void alGenBuffers(ALsizei n, ALuint *buffers);
void alDeleteBuffers(ALsizei n, ALuint *buffers);

ALboolean alIsSource(ALuint source);
void alGenSources(ALsizei n, ALuint *sources);
void alDeleteSources(ALsizei n, ALuint *sources);

void alSourcePlay(ALuint source);
void alSourcePause(ALuint source);
void alSourceRewind(ALuint source);
void alSourceStop(ALuint source);

void alSourcef(ALuint source, ALenum param, ALfloat value);
void alSourcei(ALuint source, ALenum param, ALint value);
void alSource3f(ALuint source, ALenum param, ALfloat v1, ALfloat v2, ALfloat v3);

#define AL_GAIN 0x100A
#define AL_PITCH 0x1003
#define AL_LOOPING 0x1007
#define AL_POSITION 0x1004
#define AL_VELOCITY 0x1006

#define AL_TRUE 1
#define AL_FALSE 0

#define AL_BUFFER 0x1009
