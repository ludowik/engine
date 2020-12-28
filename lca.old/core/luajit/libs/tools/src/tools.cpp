#include <stdio.h>
#include <stdlib.h>

#include <string.h>

#include <math.h>

#include <thread>
#include <chrono>

#ifdef _WIN32
    #define EXPORT __declspec(dllexport)
#else
    #define EXPORT 
#endif

extern "C" {
    EXPORT void sleep(unsigned long delay) {
        std::this_thread::sleep_for(std::chrono::milliseconds(delay));
    }
}
