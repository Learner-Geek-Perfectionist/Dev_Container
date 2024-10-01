#include <iostream>

#include <vector>

// using namespace std;

template <typename T, typename U>
constexpr bool is_same_v = false; // 主模版

template <typename T>
constexpr bool is_same_v<T, T> = true; // 偏特化模版

template <typename T, typename SFINAE= typename std::enable_if<is_same_v<T, int>>::type>
void f(T t)
{
    puts("123");
}

int main()
{
    f(1);
    // f(1u);
}