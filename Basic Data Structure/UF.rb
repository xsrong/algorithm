class UF
  def initialize(num)
    @union = Array.new(num)
    for i in 0..num - 1
      @union[i] = i
    end
    @count = num
  end

  def find(v)
    while v != @union[v]
      v = @union[v]
    end
    return v
  end

  def connected?(v, w)
    return find(v) == find(w)
  end

  def union(v, w)
    v_root = find(v)
    w_root = find(w)
    if v_root != w_root
      @union[v_root] = w_root
      @count -= 1
    end  
  end
end