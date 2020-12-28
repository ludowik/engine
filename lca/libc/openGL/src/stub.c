    #define GL3_PROTOTYPES 1

    #define GL_GLEXT_PROTOTYPES 1

    #include <openGL/gl3.h>

    #ifndef GL_VBO_FREE_MEMORY_ATI
        #define GL_VBO_FREE_MEMORY_ATI          0x87FB
        #define GL_TEXTURE_FREE_MEMORY_ATI      0x87FC
        #define GL_RENDERBUFFER_FREE_MEMORY_ATI 0x87FD
    #endif

    #define GL_GPU_MEMORY_INFO_DEDICATED_VIDMEM_NVX          0x9047
    #define GL_GPU_MEMORY_INFO_TOTAL_AVAILABLE_MEMORY_NVX    0x9048
    #define GL_GPU_MEMORY_INFO_CURRENT_AVAILABLE_VIDMEM_NVX  0x9049
    #define GL_GPU_MEMORY_INFO_EVICTION_COUNT_NVX            0x904A
    #define GL_GPU_MEMORY_INFO_EVICTED_MEMORY_NVX            0x904B
