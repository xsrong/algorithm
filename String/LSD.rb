require_relative 'Alphabet'

class LSD
  class << self
    def sort(str_arr, alpha, w)
      d = w
      aux = []
      while d >= 0
        count = Array.new(alpha.radix + 1){0}
        str_arr.each do |str|
          if str[d] != nil
            char = str[d]
          else
            char = ' '
          end
          index = alpha.to_index(char)
          count[index + 1] += 1
        end
        for i in 1..count.length - 1
          count[i] += count[i - 1]
        end
        str_arr.each do |str|
          if str[d] != nil
            char = str[d]
          else
            char = ' '
          end
          index = count[alpha.to_index(char)]
          aux[index] = str
          count[alpha.to_index(char)] += 1
        end
        str_arr.replace(aux)
        d -= 1
      end
      return str_arr
    end
  end
end
