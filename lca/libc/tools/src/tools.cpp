#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

extern "C" {
    EXPORT double getValue(double dt) {
        return dt;
    }
    
    EXPORT int main(int, char**) {
        return 0;
    }
}
