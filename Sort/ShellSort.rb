# Shell Sort
# Insertion Sort的升级版，相当于每隔h个元素执行插入操作。每一轮插入完成后缩小h的值，直到h=1.
# 这样可以快速将较小的元素交换到靠前的位置，较大的元素交换到靠后的位置。
# h=1的时候实际上是插入排序。但是因为此时较小元素靠前，较大元素靠后。因此此时比单纯的插入排序效率更高。
# 两个ShellSort的实现分别对应两个插入排序的实现

class ShellSort
  class << self
    def sort arr                                                
      h = 1
      h = h * 3 + 1 while h < arr.length / 3
      while h >= 1
        for i in h..arr.length - 1
          j = 0
          while j < i
            arr[i], arr[j] = arr[j], arr[i] if arr[j] > arr[i]
            j += h
          end
        end
        h /= 3
      end
      return arr
    end

    def sort2 arr
      h = 1
      h = h * 3 + 1 while h < arr.length / 3
      while h >= 1
        for i in h..arr.length - 1
          j = i
          while j >= h
            arr[j], arr[j-h] = arr[j-h], arr[j] if arr[j-h] > arr[j]
            j -= h
#             if arr[j-h] > arr[j]
#               arr[j], arr[j-h] = arr[j-h], arr[j]
#               j -= h
#             else
#               break
#             end
          end
        end
        h /= 3
      end
      return arr
    end
  end
end

str = 'EASYSORT'
p ShellSort.sort(str)
