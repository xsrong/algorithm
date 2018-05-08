# 将数组内元素依次两两比较，将值较大的元素向后移。每一轮移动都能将本轮最大的元素移到本轮排序的最后一位。
# 具体排序时的移动轨迹如下：
# 
# 初始数组 = [4, 8, 7, 2, 6, 5, 3, 0, 9, 1]

=begin
[4, 8, 7, 2, 6, 5, 3, 0, 9, 1]  将4和8比较，4<8 因此不用交换位置
[4, 7, 8, 2, 6, 5, 3, 0, 9, 1]  将8和7比较，8>7，需要将两个元素位置交换。
[4, 7, 2, 8, 6, 5, 3, 0, 9, 1]  将8和2比较，8>2，8继续向后移动
[4, 7, 2, 6, 8, 5, 3, 0, 9, 1]  同上
[4, 7, 2, 6, 5, 8, 3, 0, 9, 1]  同上
[4, 7, 2, 6, 5, 3, 8, 0, 9, 1]  同上
[4, 7, 2, 6, 5, 3, 0, 8, 9, 1]  同上
[4, 7, 2, 6, 5, 3, 0, 8, 9, 1]  这里 8>9，8不再移动。
[4, 7, 2, 6, 5, 3, 0, 8, 1, 9]  9>1，9向后移动。此时数组中每个元素都被比较过至少一次了，所以第一轮比较结束。9被放到了正确的位置上，因此9不再参与后面的比较。
[4, 7, 2, 6, 5, 3, 0, 8, 1, 9]  第二轮开始。跟第一轮一样两两比较
[4, 2, 7, 6, 5, 3, 0, 8, 1, 9]
[4, 2, 6, 7, 5, 3, 0, 8, 1, 9]
[4, 2, 6, 5, 7, 3, 0, 8, 1, 9]
[4, 2, 6, 5, 3, 7, 0, 8, 1, 9]
[4, 2, 6, 5, 3, 0, 7, 8, 1, 9]  元素7一直在冒泡，从arr[1]升到了arr[6]。
[4, 2, 6, 5, 3, 0, 7, 8, 1, 9] 
[4, 2, 6, 5, 3, 0, 7, 1, 8, 9]  除不参与比较的9以外的所有元素都参与过至少一次比较了，第二轮比较结束。8被放到了正确的位置上,同样也不再参与比较。
[2, 4, 6, 5, 3, 0, 7, 1, 8, 9]  第三轮开始
[2, 4, 6, 5, 3, 0, 7, 1, 8, 9]
[2, 4, 5, 6, 3, 0, 7, 1, 8, 9]
[2, 4, 5, 3, 6, 0, 7, 1, 8, 9]
[2, 4, 5, 3, 0, 6, 7, 1, 8, 9]
[2, 4, 5, 3, 0, 6, 7, 1, 8, 9]
[2, 4, 5, 3, 0, 6, 1, 7, 8, 9]  第三轮结束。7被放到正确位置。
[2, 4, 5, 3, 0, 6, 1, 7, 8, 9]  第四轮开始。
[2, 4, 5, 3, 0, 6, 1, 7, 8, 9]
[2, 4, 3, 5, 0, 6, 1, 7, 8, 9]
[2, 4, 3, 0, 5, 6, 1, 7, 8, 9]
[2, 4, 3, 0, 5, 6, 1, 7, 8, 9]
[2, 4, 3, 0, 5, 1, 6, 7, 8, 9]  第四轮结束。6被放到正确位置。
[2, 4, 3, 0, 5, 1, 6, 7, 8, 9]  第五轮开始。
[2, 3, 4, 0, 5, 1, 6, 7, 8, 9]
[2, 3, 0, 4, 5, 1, 6, 7, 8, 9]
[2, 3, 0, 4, 5, 1, 6, 7, 8, 9]
[2, 3, 0, 4, 1, 5, 6, 7, 8, 9]  第五轮结束。5被放到正确位置。
[2, 3, 0, 4, 1, 5, 6, 7, 8, 9]
[2, 0, 3, 4, 1, 5, 6, 7, 8, 9]
[2, 0, 3, 4, 1, 5, 6, 7, 8, 9]
[2, 0, 3, 1, 4, 5, 6, 7, 8, 9]  第六轮结束。4被放到正确位置。
[0, 2, 3, 1, 4, 5, 6, 7, 8, 9]
[0, 2, 3, 1, 4, 5, 6, 7, 8, 9]
[0, 2, 1, 3, 4, 5, 6, 7, 8, 9]  第七轮结束。3被放到正确位置。
[0, 2, 1, 3, 4, 5, 6, 7, 8, 9]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  第八轮结束。2在正确位置。
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  第九轮结束。0，1在正确位置。
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  排序结果
=end

class BubbleSrot
  class << self
    def sort arr
      j = arr.length - 1
      while j > 0
        for i in 0..j - 1
          arr[i], arr[i + 1] = arr[i + 1], arr[i] if arr[i] > arr[i + 1]
        end
        j -= 1
      end
    end
  end
end
