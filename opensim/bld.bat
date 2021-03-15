mkdir opensim_dependencies_build
cd .\opensim_dependencies_build
cmake ..\dependencies^
	-G"Visual Studio 15 2017 Win64"^
	-DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"
cmake --build . --config Release -- /maxcpucount:8
cd .. 

mkdir opensim_build
cd .\opensim_build
cmake ..\^
	-G"Visual Studio 15 2017 Win64"^
	-DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"^
	-DOPENSIM_DEPENDENCIES_DIR="%LIBRARY_PREFIX%"^
	-DBUILD_PYTHON_WRAPPING=ON^
	-DWITH_BTK=ON^
	-DBUILD_TESTING=OFF^
	-DBUILD_API_EXAMPLES=OFF

cmake --build . --target install --config Release -- /maxcpucount:8

copy %LIBRARY_PREFIX%\simbody\bin\simbody-visualizer.exe %PREFIX%\simbody-visualizer.exe
cd %LIBRARY_PREFIX%\sdk\python
python setup.py install
