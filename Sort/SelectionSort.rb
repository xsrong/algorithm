# Selection Sort
# 每一轮比较中将最小的元素选出来，并与该轮排序中的首个元素进行交换
# 排序轨迹如下：
# 初始数组 = [9, 6, 1, 2, 8, 7, 3, 0, 5, 4]

=begin
[9, 6, 1, 2, 8, 7, 3, 0, 5, 4]  初始状态
[0, 6, 1, 2, 8, 7, 3, 9, 5, 4]  第一轮交换时，数组里最小的元素为0，将它与数组首个元素9进行交换。交换后0在正确的位置上了，因此不再参加后面的比较。
[0, 1, 6, 2, 8, 7, 3, 9, 5, 4]  第二轮交换时，除不参与比较的0以外，最小的元素为1，又将它与本轮比较的首个元素6进行交换。交换后1不再参与比较。
[0, 1, 2, 6, 8, 7, 3, 9, 5, 4]  第三轮交换时，2最小。将2与本轮首个元素6交换。后面以此类推。             .
[0, 1, 2, 3, 8, 7, 6, 9, 5, 4]                .
[0, 1, 2, 3, 4, 7, 6, 9, 5, 8]                .
[0, 1, 2, 3, 4, 5, 6, 9, 7, 8]                .
[0, 1, 2, 3, 4, 5, 6, 9, 7, 8]                .
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]                .     
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]                .
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  所有元素都经过一次位置交换后排序结束。
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
=end

class SelectionSort
  class << self
    def sort arr
      for i in 0..arr.length - 1
        min = i
        for j in i + 1..arr.length - 1
          min = j if arr[min] > arr[j]
        end
        arr[i], arr[min] = arr[min], arr[i]
      end
    end
  end
end