require_relative 'Alphabet'

class MSD
  class << self
    def sort(str_arr, alpha, w)
      aux = []
      los = [0]
      his = [str_arr.length - 1]
      for d in 0..w
        l = los.length
        while l > 0
          lo = los.shift
          hi = his.shift
          count = Array.new(alpha.radix + 2){0}
          for i in lo..hi
            if str_arr[i][d] != nil
              index = alpha.to_index(str_arr[i][d]) + 1
            else
              index = 0
            end
            count[index+1] += 1
          end
          for j in 1..count.length - 1
            count[j] += count[j - 1]
          end
          for m in lo..hi
            if str_arr[m][d] != nil
              index = alpha.to_index(str_arr[m][d]) + 1
            else
              index = 0
            end
            aux[count[index]+lo] = str_arr[m]
            count[index] += 1
          end
          for n in lo..hi
            str_arr[n] = aux[n]
          end
          for r in 2..count.length - 1
            next if count[r] - 1 < count[r - 1]
            los << count[r - 1] + lo
            his << count[r] - 1 + lo
          end
          l -= 1
        end
      end
    end
  end
end

