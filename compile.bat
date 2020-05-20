        set path=%path%;C:/Tools/MinGW/bin;
        gcc.exe -Wmissing-field-initializers -W -Wall -g -fPIC -shared -I "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/include" -o lib/freetype.dll lib/freetype.c "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/win32/freetype.dll"
    