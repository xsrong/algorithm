require_relative '../Basic Data Structure/MinPQ'

class LazyPrimMST
  def initialize(ewgraph, s=0)
    @marked = Array.new(ewgraph.vertex){ false }
    @mst = []
    @pq = MinPQ.new
    visit(ewgraph, s)
    while !@pq.is_empty?
      edge = @pq.delete_min
      v = edge.v
      w = edge.w
      next if @marked[v] && @marked[w]
      @mst << edge
      visit(ewgraph, v) if !@marked[v]
      visit(ewgraph, w) if !@marked[w]
    end
  end

  def visit(ewgraph, i)
    @marked[i] = true
    ewgraph.adj(i).each do |edge|
      @pq.insert(edge) if !@marked[edge.other(i)]
    end
  end

  def edges
    return @mst
  end

  def weight
    res = 0
    @mst.each do |edge|
      res += edge.weight
    end
    return res
  end
end