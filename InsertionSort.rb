# Insertion Sort
# 只需要将arr[i]与已经有序的arr[0]到arr[i-1]进行比较，如果arr[i]小于其中的arr[j]，即将arr[i]插入到arr[j]和arr[j-1]之间。
# 具体插入时，需要将arr[i]与arr[0]到arr[i-1]比较，只要arr[i]较小都执行一次互换操作。
# 排序轨迹如下：
# 初始数组 = [8, 6, 9, 1, 3, 0, 2, 5, 4, 7]
=begin
[8, 6, 9, 1, 3, 0, 2, 5, 4, 7]  初始数组。此时8视作已经有序。
[6, 8, 9, 1, 3, 0, 2, 5, 4, 7]  6<8，因此将6插入到8之前。此时第二个位置之前的每个位置都比较过了。第一轮结束。此时6,8有序。
[6, 8, 9, 1, 3, 0, 2, 5, 4, 7]  9>6，9的位置不变。
[6, 8, 9, 1, 3, 0, 2, 5, 4, 7]  9>8, 9的位置仍然不变。此时第三个位置与之前的每个位置都比较过了。第二轮结束。此时6,8,9有序。
[1, 8, 9, 6, 3, 0, 2, 5, 4, 7]  1<6, 因此6,1交换。
[1, 6, 9, 8, 3, 0, 2, 5, 4, 7]  8,6交换。
[1, 6, 8, 9, 3, 0, 2, 5, 4, 7]  9,8交换。此时第四个位置也跟前面每个位置都比较过了。第三轮结束。此时1就被正确地插入到了6,8,9之前，1,6,8,9已经有序。
[1, 6, 8, 9, 3, 0, 2, 5, 4, 7]  3>1 所以3的位置不变。
[1, 3, 8, 9, 6, 0, 2, 5, 4, 7]  3<6, 6,3交换。
[1, 3, 6, 9, 8, 0, 2, 5, 4, 7]  8,6交换。
[1, 3, 6, 8, 9, 0, 2, 5, 4, 7]  9,8交换。此时第四轮结束。3被插入到正确的位置。1,3,6,8,9已经有序。
[0, 3, 6, 8, 9, 1, 2, 5, 4, 7]  1>0，1保持不变。
[0, 1, 6, 8, 9, 3, 2, 5, 4, 7]  1<3，3,1交换。
[0, 1, 3, 8, 9, 6, 2, 5, 4, 7]  6,3交换
[0, 1, 3, 6, 9, 8, 2, 5, 4, 7]  8,6交换
[0, 1, 3, 6, 8, 9, 2, 5, 4, 7]  9,8交换。此时第五轮结束。0被插入到正确的位置上
[0, 1, 3, 6, 8, 9, 2, 5, 4, 7]  2>0, 2位置不变
[0, 1, 3, 6, 8, 9, 2, 5, 4, 7]  2>1, 2位置不变
[0, 1, 2, 6, 8, 9, 3, 5, 4, 7]  2<3, 3,2交换
[0, 1, 2, 3, 8, 9, 6, 5, 4, 7]  6,3交换
[0, 1, 2, 3, 6, 9, 8, 5, 4, 7]  8,6交换
[0, 1, 2, 3, 6, 8, 9, 5, 4, 7]  9,8交换。此时第五轮结束。2被插入到正确的位置。接来下以此类推。
[0, 1, 2, 3, 6, 8, 9, 5, 4, 7]  开始执行5的插入操作。
[0, 1, 2, 3, 6, 8, 9, 5, 4, 7]
[0, 1, 2, 3, 6, 8, 9, 5, 4, 7]
[0, 1, 2, 3, 6, 8, 9, 5, 4, 7]
[0, 1, 2, 3, 5, 8, 9, 6, 4, 7]
[0, 1, 2, 3, 5, 6, 9, 8, 4, 7]
[0, 1, 2, 3, 5, 6, 8, 9, 4, 7]  5的插入操作结束。
[0, 1, 2, 3, 5, 6, 8, 9, 4, 7]  开始执行4的插入操作。
[0, 1, 2, 3, 5, 6, 8, 9, 4, 7]
[0, 1, 2, 3, 5, 6, 8, 9, 4, 7]
[0, 1, 2, 3, 5, 6, 8, 9, 4, 7]
[0, 1, 2, 3, 4, 6, 8, 9, 5, 7]
[0, 1, 2, 3, 4, 5, 8, 9, 6, 7]
[0, 1, 2, 3, 4, 5, 6, 9, 8, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]  4的插入操作结束。
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]  开始执行7的插入操作
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 8, 9, 7]
[0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]  当最后一个元素的插入操作结束后，整个排序结束。
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
=end

class InsertionSort
  class << self
    def sort arr
      for i in 1..arr.length - 1
        for j in 0..i - 1
          arr[i], arr[j] = arr[j], arr[i] if arr[j] > arr[i]
        end
      end
    end
  end
end