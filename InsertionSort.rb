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