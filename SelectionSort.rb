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

arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffle
p arr
SelectionSort.sort arr
p arr