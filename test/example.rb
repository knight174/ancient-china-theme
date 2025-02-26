module TestModule
  extend self

  # 多行注释测试
  =begin 
  这是Ruby的多行注释
  用于测试语法高亮
  =end

  class TestClass
    attr_accessor :name
    attr_reader :created_at

    def initialize(name)
      @name = name
      @created_at = Time.now
    end

    # 符号和字符串插值测试
    def to_s
      "#{@name}: #{:test_symbol}"
    end
  end

  private

  def method_missing(method_name, *args, &block)
    puts "Called: #{method_name}"
  end
end
