# Quick Sort
# 快速排序的思路是选定一个基准值（本例中选择的是最末尾一个元素的值），将数组整理为比基准值小 + 基准值 + 比基准值大的三部分
# 然后递归地将比基准值小的部分和比基准值大的部分再进行快速排序。最后成功得到有序的数组。
# 具体实现方法：
# 如果空间复杂度不受限制，可以另外生成left数组和right数组来保存元素，递归后再通过 left + pivot + right 得到结果
# 原地快速排序可以设置left，right两个标记。left首先向右移动，arr[left]大于arr[pivot]时停止。然后right向左移动，arr[right]小于arr[pivot]时停止。
# 两个标记都停止移动后交换arr[left]和arr[right]。
# left向右移动时如遇到right标记可以不停止，但轮到right时如果已经被left超过，或者right移动过程中遇到left，就停止移动。
# 此时将arr[left]和arr[pivot]交换，即可成功将数组拆分为比基准值小 + 基准值 + 比基准值大三个部分
# 排序轨迹

=begin
[3, 2, 8, 1, 7, 9, 6, 4, 0, 5]     l标记会移动到元素8那里停止。r标记不会移动。
 ↑                       ↑  ↑
 l                       r  p

[3, 2, 0, 1, 7, 9, 6, 4, 8, 5]     交换arr[l]和arr[r]，然后l标记会继续移动到7的位置。r标记会移动到元素4的位置
       ↑                 ↑  ↑
       l                 r  p

[3, 2, 0, 1, 4, 9, 6, 7, 8, 5]     继续交换arr[l]和arr[r]，然后l标记会继续移动到9的位置。r移动到9时与l相遇，也停止。
             ↑        ↑     ↑
             l        r     p

[3, 2, 0, 1, 4, 5, 6, 7, 8, 9]     此时交换arr[l]和arr[p]
                ↑           ↑
                lr          p

[3, 2, 0, 1, 4, 5, 6, 7, 8, 9]     交换后递归。此时l1会直接移动到4的位置。r1开始移动时已经被l1超过，所以不移动。因为l1 = p1，所以本轮实际上没有任何元素交换。
 ↑        ↑  ↑     ↑     ↑  ↑
 l1       r1 p1    l2    r2 p2 

[0, 2, 3, 1, 4, 5, 6, 7, 8, 9]     此时l3原本指向3，r3原本指向0，而p3为1，满足交换条件，所以进行了交换。然后l3向右移动到2停止，r3也向左移动到2停止。
 ↑     ↑  ↑        ↑     ↑  ↑
 l3    r3 p3       l2    r2 p2

[0, 1, 3, 2, 4, 5, 6, 7, 8, 9]     交换arr[l3]和arr[p3] 
    ↑     ↑        ↑     ↑  ↑
   l3r3   p3       l2    r2 p2

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]     再次递归后前面一个子数组只有1个元素。后面子数组有两个元素。1个元素的视作已排序，两个元素的按照规则交换。交换后再递归的子数组只剩一个元素，也视作已排序。
 ↑     ↑  ↑        ↑     ↑  ↑
l4r4p4 l5r5 p5     l2    r2 p2

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                         ↑  ↑
                        r2 l2p2

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                   ↑  ↑  ↑
                  l6  r6 p6

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                      ↑  ↑
                      r6 l6p6

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                   ↑  ↑
                 l7r7 p7

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                   ↑  ↑
                  r7 l7p7

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  排序结果
=end


class QuickSort
  class << self
    def sort arr, lo, hi
      return if lo >= hi
      povit = hi
      left_mark = lo
      right_mark = hi - 1
      loop do 
        while left_mark < hi
          break if arr[left_mark] > arr[povit]
          left_mark += 1
        end
        while right_mark > left_mark 
          break if arr[right_mark] < arr[povit]
          right_mark -= 1
        end
        if left_mark >= right_mark
          arr[povit], arr[left_mark] = arr[left_mark], arr[povit]
          break
        end
        arr[left_mark], arr[right_mark] = arr[right_mark], arr[left_mark]
      end
      sort arr, lo, left_mark - 1
      sort arr, left_mark + 1, hi
    end

    def sort2(arr)                          # 不使用递归的快速排序
      left_mark_temp = [1]
      right_mark_temp = [arr.length - 1]
      while right_mark_temp.length != 0
        left = left_mark_temp.pop
        right = right_mark_temp.pop
        pivot = left - 1
        last = right
        while last > pivot
          while right > pivot
            break if arr[right] < arr[pivot]
            right -= 1
          end
          while left < right
            break if arr[left] > arr[pivot]
            left += 1
          end
          if left >= right
            arr[pivot], arr[right] = arr[right], arr[pivot]
            left_mark_temp << pivot + 1
            left_mark_temp << right + 2
            right_mark_temp << right - 1
            right_mark_temp << last
            break
          end
          arr[left], arr[right] = arr[right], arr[left]
        end
      end
    end
  end
end

[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                      ↑           
                     l r