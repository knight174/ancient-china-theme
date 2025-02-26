<?php
declare(strict_types=1);

namespace Test;

// 特性（Attribute）测试
#[Attribute]
class TestAttribute {
    public function __construct(
        private string $value
    ) {}
}

#[TestAttribute("测试")]
class TestClass
{
    // 构造器属性提升
    public function __construct(
        private string $name,
        protected ?array $data = null
    ) {}

    // 返回类型测试
    public function process(): mixed
    {
        // null合并运算符测试
        return $this->data ?? [];
    }

    // 箭头函数测试
    public function map(): array
    {
        return array_map(
            fn($item) => $item * 2,
            range(1, 5)
        );
    }
}
