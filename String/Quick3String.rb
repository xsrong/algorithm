require_relative 'Alphabet'

class Quick3String
  class << self
    def sort(str_arr, alpha, lo=0, hi=str_arr.length-1, d=0)
      return if hi <= lo
      left_mark = lo
      right_mark = hi
      v = alpha.to_index(str_arr[lo][d])
      i = lo + 1
      while i <= right_mark
        t = alpha.to_index(str_arr[i][d])
        if t < v
          str_arr[i], str_arr[left_mark] = str_arr[left_mark], str_arr[i]
          i += 1
          left_mark += 1
        elsif t > v
          str_arr[i], str_arr[right_mark] = str_arr[right_mark], str_arr[i]
          right_mark -= 1
        else
          i += 1
        end
      end
      sort(str_arr, alpha, lo, left_mark - 1, d)
      sort(str_arr, alpha, left_mark, right_mark, d+1) if v >= 0
      sort(str_arr, alpha, right_mark + 1, hi, d)
    end
  end
end