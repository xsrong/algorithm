require_relative '../Basic Data Structure/MinPQ'

class PrimMST
  def initialize(ewgraph, s=0)
    @edge_to = Array.new(ewgraph.vertex)
    @marked = Array.new(ewgraph.vertex){ false }
    @cost_to = Array.new(ewgraph.vertex){ nil }
    @pq = MinPQ.new
    visit(ewgraph, s)
    while !@pq.is_empty?
      edge = @pq.delete_min
      v = edge.v
      w = edge.w
      visit(ewgraph, v) if !@marked[v]
      visit(ewgraph, w) if !@marked[w]
    end
  end

  def visit(ewgraph, v)
    @marked[v] = true
    ewgraph.adj(v).each do |edge|
      w = edge.other(v)
      next if @marked[w]
      if @cost_to[w] == nil || @cost_to[w] > edge.weight
        @edge_to[w] = edge
        @cost_to[w] = edge.weight
        if @pq.contains?(w)
          @pq.change(@pq.index(w), @edge_to[w])
        else
          @pq.insert(@edge_to[w])
        end
      end
    end
  end

  def edges
    return @edge_to[1..-1]
  end

  def weight
    sum = 0
    for i in 1..@cost_to.length - 1
      sum += @cost_to[i]
    end
    return sum.round(2)
  end
end