        set path=%path%;C:/Tools/MinGW/bin;
        gcc.exe -shared -I "C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/include" -o lib/ft.dll lib/freetype.c -L"C:/Users/lmilhau/Documents/Persos/Mes Projets Persos/Libraries/freetype/win32" -lfreetype
    