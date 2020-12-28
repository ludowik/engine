#define GL3_PROTOTYPES 1
#define GL_GLEXT_PROTOTYPES 1

#include <SDL_opengl.h>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

extern "C" {
    void test() {
        GLint location = -1;
        GLsizei count = 1;
        
        GLfloat v[1] = {0};
        
        glUniform1fv(location, count, v);
    }
    
    EXPORT int main(int, char**) {
        return 0;
    }
}
