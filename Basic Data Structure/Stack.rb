# Stack
# 一种后进先出的数据结构

require_relative 'Node'

class Stack
  def initialize            # 新建一个栈
    @first = nil            # @first表示处理时会被第一个处理的元素。即栈尾的元素。
    @l = 0
  end

  def push item             # 向栈的尾部添加一个元素，给@fisrt赋予新的值，并将@first.next设为原来的@first
    old_first = @first
    @first = Node.new item
    @first.next = old_first
    @l += 1
  end
  
  def pop                   # 删除栈尾部的元素。即把最后一个元素指定为原来倒数第二的那个元素，这样原最后一个元素就成了孤儿，会被回收。
    return nil if @first == nil
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
