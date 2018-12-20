class MinPQ
  def initialize(num=0)
    @length = 0
    @pq = Array.new(num + 1)
    @pq[0] = nil
  end

  def insert(element)
    @pq[@length + 1] = element
    swim(@length + 1)
    @length += 1
  end

  def delete_min
    min = @pq[1]
    exchange(1, @length)
    @pq[@length] = nil
    sink(1)
    @length -= 1
    return min
  end

  def min
    return @pq[1]
  end

  def swim(n)
    while n > 1 && less?(n, n / 2)
      exchange(n, n / 2)
      n /= 2
    end
  end

  def sink(n)
    while n * 2 < @length - 1
      i = n * 2
      if i < @length
        i += 1 if less?(i + 1, i)
        break if less?(n, i)
        exchange(n, i)
        n = i
      end
    end
  end

  def exchange(i, j)
    @pq[i], @pq[j] = @pq[j], @pq[i]
  end

  def less?(i, j)
    if @pq[i].is_a?(Fixnum) && @pq[j].is_a?(Fixnum)
      return @pq[i] < @pq[j]
    else
      return @pq[i].compare_to(@pq[j]) < 0
    end
  end

  def is_empty?
    return @length == 0
  end

  def contains?(w)
    # for i in 1..@pq.length - 1
    #   return true if @pq[i] != nil && (@pq[i].w == w || @pq[i].v == w)
    # end
    for i in 1..@pq.length - 1
      return true if @pq[i] != nil && @pq[i].to == w
    end
    return false
  end

  def index(w)
    edge = nil
    for i in 1..@pq.length - 1
      edge = @pq[i] if @pq[i] != nil && (@pq[i].w == w || @pq[i].v == w)
    end
    return @pq.index(edge) if edge != nil
    return nil
  end

  def [](num)
    return @pq[num]
  end

  def []=(num, ele)
    @pq[num] = ele
  end

  def change(w, edge)
    @pq[w] = edge
    swim(w)
    sink(w)
  end

end