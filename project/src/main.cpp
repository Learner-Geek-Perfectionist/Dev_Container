#include <iostream>

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
    Base* ptr = new Derived(); //未定义行为！
    delete ptr;
}
