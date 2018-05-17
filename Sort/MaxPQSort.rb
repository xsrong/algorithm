# MaxPQSort
#
# 将数组的元素放到堆中，通过堆的特性，每次取出最大的元素放到数组末尾

class MaxPQSort
  class << self
    def sort arr
      pq = MaxPQ.new
      arr.each {|e| pq.insert(e)}
      i = arr.length - 1
      while i >= 0
        arr[i] = pq.delete_max
        i -= 1
      end
    end
  end
end

# 构建堆
# 必须满足每个元素都不小于它的两个子元素，且不大于它的父元素。即pq[i] >= pq[i*2] && pq[i] >= pq[i*2+1] && pq[i] <= pq[i/2]
# 当然也可以构建较小值在上，较大值在下的堆。

class MaxPQ
  def initialize
    @pq = []
    @l = 0
  end
  
  def insert(item)                    # 堆的插入操作：将元素先插入到堆的末尾，再将元素上浮至合适位置
    @pq[@l + 1] = item
    swim(@l + 1)
    @l += 1
  end

  def delete_max                      # 堆的删除操作：将堆的头尾交换，将尾元素指定为空，再将头元素下沉至合适位置
    max = @pq[1]
    @pq[1], @pq[@l] = @pq[@l], @pq[1]
    @pq[@l] = nil
    @l -= 1
    sink(1)
    return max
  end
  
  def is_empty?
    return @l == 0
  end
  
  def size
    return @l
  end
  
  def swim(i)                              # 上浮操作：当子元素大于父元素时，将它们的位置互相交换。即子元素上浮。
    while i >= 2 && @pq[i] > @pq[i/2]
      @pq[i], @pq[i/2] = @pq[i/2], @pq[i]
      i /= 2
    end
  end
  
  def sink(i)                              # 下沉操作：当父元素小于某一个子元素时，将父元素与该子元素交换。如父元素比两个子元素都小时，则与较大的那个子元素交换。
    while i * 2 <= @l
      j = i * 2                             # 寻找子元素
      j += 1 if j < @l && @pq[j] < @pq[j+1] # 将两个子元素进行比较，取较大的那个子元素。
      break if @pq[i] >= @pq[j]             # 如果父元素比较大的子元素还大，说明父元素比两个子元素都大，因此不需再下沉
      @pq[i], @pq[j] = @pq[j], @pq[i]       # 只将父元素与较大的子元素交换。
      i = j
    end
  end
end
