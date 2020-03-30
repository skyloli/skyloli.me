---
title: boost build for vs2019 
date: 2020-03-29 21:20:46
categories:
  - [c/c++, boost]
---
Download for boost

下载 boost

Open the link: https://www.boost.org/

打开链接：https://www.boost.org/

Download page: https://www.boost.org/users/download/

下载页面：https://www.boost.org/users/download/

<!--more-->

Now, boost version is 1.72.0

现在的boost版本是1.72.0

Download file: https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.zip

下载文件：https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.zip

Tip: Forbidden!

提示：Forbidden!

Previously boost was saved on sourceforge

以前boost是保存在上sourceforge的

![I am a image](/images/TIM20200329221932.png)

Open the this link

打开这个连接

Open the boost directory

打开 boost 目录

Find the required version and download

找到需要的版本然后下载

Tip: The boost-binaries directory is a compiled boost version

提示：boost-binaries目录是已经编译过的boost版本

Unzip it now

现在解压它

Open x64 Native Tools Command Prompt for VS 2019

打开 x64 Native Tools Command Prompt for VS 2019

Tip: `x86_x64 Cross Tools Command Prompt for VS 2019` Can compile 64-bit programs on x86

提示: `x86_x64 Cross Tools Command Prompt for VS 2019` 可以让x86编译出x64程序

![I am a image](/images/TIM20200330113811.png)

Enter the boost directory and run `bootstrap.bat`

进入 boost 目录然后运行 `bootstrap.bat`

Get a `b2.exe`

获得一个 `b2.exe`

run

``` bash
b2 --help
```

```
Boost.Build 4.0-git

Project-specific help:

  Project has jamfile at Jamroot

Usage:

  b2 [options] [properties] [install|stage]

  Builds and installs Boost.

Targets and Related Options:

  install                 Install headers and compiled library files to the
  =======                 configured locations (below).

  --prefix=<PREFIX>       Install architecture independent files here.
                          Default: C:\Boost on Windows
                          Default: /usr/local on Unix, Linux, etc.

  --exec-prefix=<EPREFIX> Install architecture dependent files here.
                          Default: <PREFIX>

  --libdir=<LIBDIR>       Install library files here.
                          Default: <EPREFIX>/lib

  --includedir=<HDRDIR>   Install header files here.
                          Default: <PREFIX>/include

  --cmakedir=<CMAKEDIR>   Install CMake configuration files here.
                          Default: <LIBDIR>/cmake

  --no-cmake-config       Do not install CMake configuration files.

  stage                   Build and install only compiled library files to the
  =====                   stage directory.

  --stagedir=<STAGEDIR>   Install library files here
                          Default: ./stage

Other Options:

  --build-type=<type>     Build the specified pre-defined set of variations of
                          the libraries. Note, that which variants get built
                          depends on what each library supports.

                              -- minimal -- (default) Builds a minimal set of
                              variants. On Windows, these are static
                              multithreaded libraries in debug and release
                              modes, using shared runtime. On Linux, these are
                              static and shared multithreaded libraries in
                              release mode.

                              -- complete -- Build all possible variations.

  --build-dir=DIR         Build in this location instead of building within
                          the distribution tree. Recommended!

  --show-libraries        Display the list of Boost libraries that require
                          build and installation steps, and then exit.

  --layout=<layout>       Determine whether to choose library names and header
                          locations such that multiple versions of Boost or
                          multiple compilers can be used on the same system.

                              -- versioned -- Names of boost binaries include
                              the Boost version number, name and version of
                              the compiler and encoded build properties. Boost
                              headers are installed in a subdirectory of
                              <HDRDIR> whose name contains the Boost version
                              number.

                              -- tagged -- Names of boost binaries include the
                              encoded build properties such as variant and
                              threading, but do not including compiler name
                              and version, or Boost version. This option is
                              useful if you build several variants of Boost,
                              using the same compiler.

                              -- system -- Binaries names do not include the
                              Boost version number or the name and version
                              number of the compiler. Boost headers are
                              installed directly into <HDRDIR>. This option is
                              intended for system integrators building
                              distribution packages.

                          The default value is 'versioned' on Windows, and
                          'system' on Unix.

  --buildid=ID            Add the specified ID to the name of built libraries.
                          The default is to not add anything.

  --python-buildid=ID     Add the specified ID to the name of built libraries
                          that depend on Python. The default is to not add
                          anything. This ID is added in addition to --buildid.

  --help                  This message.

  --with-<library>        Build and install the specified <library>. If this
                          option is used, only libraries specified using this
                          option will be built.

  --without-<library>     Do not build, stage, or install the specified
                          <library>. By default, all libraries are built.

Properties:

  toolset=toolset         Indicate the toolset to build with.

  variant=debug|release   Select the build variant

  link=static|shared      Whether to build static or shared libraries

  threading=single|multi  Whether to build single or multithreaded binaries

  runtime-link=static|shared
                          Whether to link to static or shared C and C++
                          runtime.


General command line usage:

    b2 [options] [properties] [targets]

  Options, properties and targets can be specified in any order.

Important Options:

  * --clean Remove targets instead of building
  * -a Rebuild everything
  * -n Don't execute the commands, only print them
  * -d+2 Show commands as they are executed
  * -d0 Suppress all informational messages
  * -q Stop at first error
  * --reconfigure Rerun all configuration checks
  * --debug-configuration Diagnose configuration
  * --debug-building Report which targets are built with what properties
  * --debug-generator Diagnose generator search/execution

Further Help:

  The following options can be used to obtain additional documentation.

  * --help-options Print more obscure command line options.
  * --help-internal Boost.Build implementation details.
  * --help-doc-options Implementation details doc formatting.

...found 1 target...
```

I want the full version, `--build-type = complete` means build all versions

我想要全部版本，`--build-type=complete` 表示编译所有版本

``` bash
b2 --toolset=msvc-16.5.1 --build-type=complete stage
```

`--toolset=msvc-16.5.1` Set the compiled version, which can be found in the menu about in vs

`--toolset=msvc-16.5.1` 设置编译版本，可以在vs中的菜单关于中找到

It takes a long time to compile, you can specify the date_time to compile

编译全部时间比较久，可以先指定编译 date_time 体验一下

``` bash
b2 --toolset=msvc-16.5.1 --build-type=complete  --with-date_time stage
```

``` text
  stage                   Build and install only compiled library files to the
  =====                   stage directory.
  
  --stagedir=<STAGEDIR>   Install library files here
                          Default: ./stage
```

Follow the prompts to know the default compiled files are in the ./stage directory

根据提示知道默认编译后的文件在./stage目录

![I am a image](/images/TIM20200330121151.png)

link= static ： 静态库。 生成的库文件名称以 “lib”开头

link= shared ： 动态库。生成的库文件名称无“lib”开头

threading= mult : 支持多线程。 生成的库文件名称中包含 “-mt”

variant=release  生成的库文件名称不包含 “-gd”

variant= debug  生成的库文件名称包含 “-gd”

runtime-link= static  生成的库文件名称包含 “-s”

runtime-link= shared  生成的库文件名称不包含 “-s”

``` text
  --without-<library>     Do not build, stage, or install the specified
                          <library>. By default, all libraries are built.
```

We can also use `without` to exclude libraries to be compiled

我们也可以使用 `without` 排除要编译的库

![I am a image](/images/TIM20200330121459.png)

`bin.v2` is an intermediate file generated by compilation, which can be deleted after compilation

`bin.v2` 是编译产生的中间文件，编译完后可以删除

You can also use `--build-dir = DIR` to specify the output directory

也可以使用 `--build-dir=DIR` 指定输出目录

编译特定版本，使用的参数

``` text
  toolset=toolset         Indicate the toolset to build with.

  variant=debug|release   Select the build variant

  link=static|shared      Whether to build static or shared libraries

  threading=single|multi  Whether to build single or multithreaded binaries

  runtime-link=static|shared
                          Whether to link to static or shared C and C++
                          runtime.
```

address-model: Add `address-model=64` to compile 64-bit version
			   添加 `address-model=64` 来编译64位版本