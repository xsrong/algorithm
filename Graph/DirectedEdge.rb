class DirectedEdge
  attr_reader :from, :to, :weight
  def initialize(from, to, weight)
    @from = from
    @to = to
    @weight = weight
  end

  def compare_to(e)
    if @weight > e.weight
      return 1
    elsif @weight < e.weight
      return -1
    else
      return 0
    end
  end
end