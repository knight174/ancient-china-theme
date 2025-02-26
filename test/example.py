from typing import List, Optional
import asyncio

class TestClass:
    """文档字符串测试
    多行文档
    """
    def __init__(self, name: str):
        self.name = name
        self._private = None

    @property
    def value(self) -> Optional[str]:
        return self._private

    async def async_method(self) -> List[int]:
        return [i ** 2 for i in range(10)]

    def __str__(self) -> str:
        return f"TestClass(name={self.name})"

if __name__ == "__main__":
    test = TestClass("测试")
    print(f"{test!r}")
