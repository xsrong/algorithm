# 有序符号表（基于二分查找）

# 本实现不支持重复键，也不支持键的值为空
# 优点：查找效率高（log n)，能在常数时间内完成max, min
# 最大的劣势在于插入和删除操作的耗时为线性级别。

class BinarySearchST
  def initialize                           # 构建符号表，@keys保存所有键，@vals保存所有值，@length表示符号表中键的数量
    @keys = []
    @vals = []
    @length = 0
  end
  
  def put key, val                         # 向符号表中插入一对键和值
    i = rank key                           # 以二分查找确定新加入的值的位置
    if i < @length && @keys[i] == key      # 因为不支持重复键，如果新加入的键已经存在，则直接更改它的值
      @vals[i] = val
    else
      j = @length                          # 为了保持有序，新加入的键值后面的所有元素向后移动一位。再将新加入的键和值插入。
      while j > i
        @keys[j] = @keys[j-1]
        @vals[j] = @vals[j-1]
      end
      @keys[i] = key
      @vals[i] = val
      @length += 1
    end
  end
  
  def get key                              # 查找某个键的值
    return nil if is_empty?                # 表为空则返回空
    i = rank key                           # 以二分查找确定要查找的键的位置
    if i < @length && @keys[i] == key
      return @vals[i]                      # 如果存在这个键则返回对应位置的值
    else
      return nil                           # 如果不存在这个键则返回空
    end
  end
  
  def delete key                           # 删除操作
    if contains? key                       # 确认表中是否含有需要删除的键
      i = rank key                         # 表中含有需要删除的键时，查找键的位置
      for j in i..@keys.length - 2         # 将查找到的键后面的元素都向前移动一位
        @keys[j] = @key[j+1]
        @vals[j] = @vals[j+1]
      end
      @keys[-1] = @vals[-1] = nil          # 将最后一个元素设为空
      @length -= 1
    else
      puts "Error: key not found..."       # 表中不含有需要删除的元素时返回Error
    end
  end
  
  def contains? key                        # 返回表中是否含有某个键
    return get key != nil                  # 能get到的值不为空则存在，为空则不存在
  end
  
  def is_empty?
    return @length == 0
  end
  
  def size
    return @length
  end

  def min
    return @vals[0]
  end
  
  def max
    return @vals[-1]
  end

  def floor key                            # 返回不大于参数值的所有键中最大的键
    i = rank key
    return @keys[i-1]
  end
  
  def ceiling key                          # 返回不小于参数值的所有键中最小的键
    i = rank key
    return @keys[i]
  end
  
  def rank key                             # 以二分查找确定参数值的键在表中的索引
    lo = 0
    hi = @keys.length - 1
    while lo <= hi
      mid = lo + (hi - lo) / 2
      if key < @keys[mid]
        hi = mid - 1
      elsif key > @keys[mid]
        lo = mid + 1
      else
        return mid
      end
    end
    return lo
  end
  
  def select index
    return @keys[index]
  end

  def delete_min
    delete min
  end
  
  def delete_max
    delete max
  end
  
  def keys lo=0, hi=size-1
    q = []
    for i in lo..hi
      q << @keys[i]
    end
    return q
  end
end