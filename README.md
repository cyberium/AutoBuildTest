# AutoBuildTest
Using VCPKG to handle our dependency

```
$ git clone https://github.com/cyberium/AutoBuildTest.git
$ cd AutoBuildTest
$ cmake -S . -B build
$ cmake --build build --config Release
$ build/Release/test_auto_vcpkg.exe
```
->
```
OpenSSL 1.1.1h  22 Sep 2020(Library: OpenSSL 1.1.1h  22 Sep 2020)
Using Boost: 1_74
Using MySQL: 8.0.20
Using ZLib: 1.2.11
Git revision: dd5b918ad51ea8c93068bc12723b38ebde2a70f1
Project built: 2020-12-20T17:57:45+01:00
Project version: 1.0b
BZip2 is detected
```