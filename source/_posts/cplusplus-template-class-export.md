---
title: c++ template class export
date: 2020-03-29 21:20:46
categories:
  - [c/c++]
---
# c++ template class export

c++ 模板类导出


``` c++
template<typename T>
class __declspec(dllexport) Hello3 {

public:
	Hello3(std::string&& name) {
		this->name = name;
	}

	void Say(T v) {
		std::cout << name << ": " << v << std::endl;
	}

private:
	std::string name;
};

//Explicit instantiation
template class Hello3<std::string>;
template class __declspec(dllexport) Hello3<int>;
//__declspec(dllexport) can be written on the CLASS or here
//__declspec(dllexport) 可以写在 CLASS 上或在这里

```
The focus is on `Explicit instantiation`

重点是 `Explicit instantiation`

<!--more-->

## template function export

模板函数导出

``` c++
//__declspec(dllexport) cannot be written here
//这里不能写 __declspec(dllexport)
template<typename T>
T Echo(T&& v) {
	std::cout << "Echo: " << v << std::endl;
	return v;
}

//Explicit instantiation
template __declspec(dllexport) int Echo(int&&);
template __declspec(dllexport) double Echo(double&&);
```

## class export

类导出

``` c++
class __declspec(dllexport) Hello {

public:
	Hello(std::string&& name) {
		this->name = name;
	}

	void Say(std::string&& s) {
		std::cout << name << ": " << s << std::endl;
	}

private:
	std::string name;
};

class Hello2 {

public:
	__declspec(dllexport)	Hello2(std::string&& name) {
		this->name = name;
	}
	__declspec(dllexport) ~Hello2() {

	}

	__declspec(dllexport) void Say(std::string&& s) {
		std::cout << name << ": " << s << std::endl;
	}

private:
	std::string name;
};
```

## warning C4251

https://docs.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-1-c4251?view=vs-2019

The implementation version may be inconsistent, such `std::string` 

可能实现版本不一致, 比如 `std::string` 

``` c++
// C4251.cpp
// compile with: /EHsc /MTd /W2 /c
#include <vector>
using namespace std;
class Node;
class __declspec(dllexport) VecWrapper : vector<Node *> {};   // C4251
```
The solution have

解决方式有

Export the used template classes, and also export the dependencies

把用到的模板类也导出，依赖也要导出

Yourself Instantiate in the constructor

在构造函数中自己实例化

like this: 
``` c++
class EXPORT Hello4 {

public:
	Hello4(const char* name) {
		this->name = new std::string(name);
	}
	~Hello4() {
		delete this->name;
	}

private:
	std::string* name;
};
```

## demo

https://github.com/aphage/demo/tree/master/c-cplusplus/cplusplus-class-export

``` c++

#include <iostream>
#include <string>

#ifdef MAKEDLL
#  define EXPORT __declspec(dllexport)
#else
#  define EXPORT __declspec(dllimport)
#endif


class EXPORT Hello {

public:
	Hello(std::string&& name);

	void Say(std::string&& s);

private:
	std::string name;
};

class Hello2 {

public:
	EXPORT	Hello2(std::string&& name);
	EXPORT ~Hello2();

	EXPORT void Say(std::string&& s);

private:
	std::string name;
};

template<typename T>
class EXPORT Hello3 {

public:
	Hello3(std::string&& name);

	void Say(T v);

private:
	std::string name;
};

template<typename T>
EXPORT T Echo(T&& v);


class EXPORT Hello4 {

public:
	Hello4(const char* name);
	~Hello4();

	void Say(const char* s);

private:
	std::string* name;
};

#pragma comment(lib,"./../Debug/hello-aphage.lib")

int main() {
	Hello hello("aphage");
	hello.Say("aqua suki");

	Hello2 hello2("aphage");
	hello2.Say("alice suki,alice foo foo~");

	Hello3<std::string> hello3("aphage");
	hello3.Say("aqua suki");

	Hello3<int> hello31("aphage");
	hello31.Say(1);

	//error, No explicit instantiation
	//Hello3<char> hello31("aphage");
	//hello31.Say(1);

	Echo<int>(2233);

	Hello4 hello4("aphage");
	hello4.Say("aqua suki");

	//https://docs.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-1-c4251?view=vs-2019

	return 0;
}
```

![I am a image](/images/TIM20200425162533.png)

https://github.com/aphage/demo/tree/master/c-cplusplus/cplusplus-class-export