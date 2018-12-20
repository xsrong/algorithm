class Alphabet
  attr_reader :radix
  def initialize(s=' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')
    @radix = 0
    @alphabet = []
    @inverse = {}
    for i in 0..s.length - 1
      if !@alphabet.include?(s[i])
        @alphabet[@radix] = s[i]
        @inverse[s[i]] = @radix
        @radix += 1
      end
    end
  end

  def to_char(index)
    if index >=0 && index < @radix
      return @alphabet[index]
    else
      return ''
    end
  end

  def to_index(char)
    if @inverse.has_key?(char)
      return @inverse[char]
    else
      return -1
    end
  end

  def contains?(char)
    return @alphabet.include?(char)
  end
end