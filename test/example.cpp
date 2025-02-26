#include <iostream>
#include <vector>
#include <memory>

namespace test {

template<typename T>
class TestClass {
private:
    std::vector<T> data_;

public:
    // 智能指针测试
    using Ptr = std::shared_ptr<TestClass<T>>;
    
    // 构造函数
    TestClass() = default;
    
    // 右值引用测试
    void add(T&& value) {
        data_.emplace_back(std::move(value));
    }

    // Lambda表达式测试
    void process() const {
        std::for_each(data_.begin(), data_.end(), 
            [](const auto& item) {
                std::cout << item << std::endl;
            });
    }
};

} // namespace test
