                set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%PATH%;
                clang.exe -Wall -shared  -o libc/bin/surface.dll libc/bin/surface.c 