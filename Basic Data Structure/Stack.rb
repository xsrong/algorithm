# Stack
# 一种后进先出的数据结构

require_relative 'Node'

class Stack
  def initialize            # 新建一个栈
    @first = nil
    @l = 0
  end

  def push item             # 向一个栈的尾部添加一个元素
    old_first = @first
    @first = Node.new item
    @first.next = old_first
    @l += 1
  end
  
  def pop                   # 删除栈尾部的元素
    item = @first.item
    @first = @first.next
    @l -= 1
    return item
  end

  def first                 # 返回栈尾元素
    return @first
  end
  
  def size                  # 返回栈里包含的元素个数
    return @l
  end

  def each                  # 遍历栈
    e = @first
    while e != nil
      yield e
      e = e.next
    end
  end
  
  def is_empty?             # 检查栈是否为空
    return @l == 0
  end
end