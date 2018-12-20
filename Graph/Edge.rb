class Edge
  attr_reader :v, :w, :weight
  def initialize(v, w, weight)
    @v = v
    @w = w
    @weight = weight
  end

  def other(v)
    if v == @v
      return @w
    elsif v == @w
      return @v
    end
  end

  def compare_to(edge)
    if @weight > edge.weight
      return 1
    elsif @weight < edge.weight
      return -1
    else
      return 0
    end
  end
end