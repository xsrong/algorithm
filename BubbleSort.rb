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

arr = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].shuffle
p arr
BubbleSrot.sort arr
p arr