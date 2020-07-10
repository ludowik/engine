call "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Auxiliary\Build\vcvars32.bat"

set path=%path%;C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.24.28314\bin\Hostx32\x32

@rem call nmake -F make/makefile.win clean
@rem nmake -F make/makefile.win
cl /EHsc /MDd -I "C:\Users\lmilhau\Documents\Persos\Mes Projets Persos\Libraries\box2d-master\include" -I "C:\Users\lmilhau\Documents\Persos\Mes Projets Persos\Libraries\box2d-master\box2d\box2d" -I "C:\Users\lmilhau\Documents\Persos\Mes Projets Persos\Libraries\box2d-master\box2d" -I "C:\Users\lmilhau\Documents\Persos\Mes Projets Persos\Libraries\box2d-master\include\box2d" /EHsc /Fe..\bin\win\box2d.dll /Fo..\bin\win\ src\box2d.cpp /link "lib\win\box2d.lib"
