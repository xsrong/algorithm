class KeyIndexSort
  class << self
    def sort(arr)
      count = Array.new(arr.length + 1){0}
      res = Array.new(arr.length)
      arr.each do |ele|
        count[ele] += 1
      end
      for i in 1..count.length - 1
        count[i] += count[i - 1]
      end
      for j in 0..arr.length - 1
        res[count[arr[j]] - 1] = arr[j]
        count[arr[j]] += 1
      end
      return res
    end
  end
end