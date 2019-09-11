mkdir build
pushd build
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug -G "Visual Studio 16 2019" -A "x64" -Thost=x64 ..
cmake --build . --config debug
popd
