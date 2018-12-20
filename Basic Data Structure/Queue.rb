# Queue
# 先进先出的数据结构

require_relative 'Node'

class Queue
  def initialize
    @first = nil                    # 保存队列首个元素
    @last = nil                     # 保存队列最后一个元素
    @l = 0                          # 保存队列长度
  end
  
  def enqueue item                  # 向队列尾部添加一个元素
    if is_empty?                    # 队列为空时新增一个元素并将@first和@last都指向新增的元素
      @first = Node.new item
      @last = @first
    else
      @last.next = Node.new item    # 队列不为空时，头部不变，尾部新增一个元素并将@last指向新增的元素
      @last = @last.next
    end
    @l += 1
  end
  
  def dequeue                       # 删除队列头部元素
    return nil if @first == nil     # 队列为空时什么都不做
    item = @first.item
    @first = @first.next            # 队列不为空时将@first指向原队列第二个元素。此时原队列首个元素成为孤儿被回收。
    @l -= 1
    @last = nil if is_empty?
    return item
  end
  
  def first                         # 返回队列头部元素
    return @first
  end
  
  def each                          # 遍历队列
    e = @first
    while e != nil
      yield e
      e = e.next
    end
  end
  
  def size                          # 返回队列长度
    return @l
  end
  
  def is_empty?                     # 判断队列是否为空
    return @l == 0
  end
end
