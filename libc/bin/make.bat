            set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\Llvm\bin;%PATH%;
            clang++.exe -Wall -shared -I "C:/Users/lmilhau/Documents/#Persos/Mes Projets Persos/Libraries/FreeType/include" -o libc/bin/ft.dll libc/freetype/freetype.cpp -L "C:/Users/lmilhau/Documents/#Persos/Mes Projets Persos/Libraries/FreeType/win32" -l FreeType