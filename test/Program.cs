using System;
using System.Linq;
using System.Threading.Tasks;

namespace TestNamespace
{
    public class Program
    {
        // 属性测试
        public string Name { get; set; } = "测试";

        // 异步方法测试
        public async Task<int> ProcessAsync()
        {
            var numbers = Enumerable.Range(1, 10);
            
            // LINQ测试
            var result = from n in numbers
                        where n % 2 == 0
                        select n * n;

            await Task.Delay(100);
            return result.Sum();
        }

        // 模式匹配测试
        public string TypeTest(object obj) => obj switch
        {
            int i => $"数字: {i}",
            string s => $"字符串: {s}",
            _ => "未知类型"
        };
    }
}
