// #include <iostream>
// using namespace std;

// void test_func(void)
// {
//     int a[6] = {0};
//     int b = a[6]; // 栈缓冲区溢出
// }

// int main(int argc, char** argv)
// {
//     cout <<1231231231<<endl;
//     test_func();
//     return 0;
// }
#include <iostream>
#include <ostream>

class Base
{
public:
    virtual void foo()
    {
    }

    // 析构函数
    ~Base()
    {
        std::cout << "Base destructor called" << std::endl;
    }
};

class Derived : public Base
{
private:
    int* data;

public:
    Derived(): data(new int[10])
    {
    }

    ~Derived()
    {
        std::cout << "Derived destructor called" << std::endl;
        delete[] data;
    }
};

int main()
{
    Base* ptr = new Derived();//未定义行为！
    delete ptr;
}

 