require_relative '../Basic Data Structure/UF'

class KruskalMST
  def initialize(ewgraph)
    @marked = Array.new(ewgraph.vertex){ false }
    @pq = MinPQ.new
    @uf = UF.new(ewgraph.vertex)
    ewgraph.edges.each do |edge|
      @pq.insert(edge)
    end
    @mst = Array.new
    while !@pq.is_empty? && @mst.length < ewgraph.vertex - 1
      e = @pq.delete_min
      if !@uf.connected?(e.v, e.w)
        @uf.union(e.v, e.w)
        @mst << e
        @marked[e.v] = true if !@marked[e.v]
        @marked[e.w] = true if !@marked[e.w]
      end
    end
  end

  def edges
    return @mst
  end

  def weight
    w = 0
    @mst.each do |edge|
      w += edge.weight
    end
    return w.round(2)
  end
end