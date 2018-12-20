require_relative '../Basic Data Structure/MinPQ'

class DijkstraSP
  def initialize(ewdigraph, s)
    @cost_to = Array.new(ewdigraph.vertex){ nil }
    @edge_to = Array.new(ewdigraph.vertex)
    @cost_to[s] = 0.0
    @pq = MinPQ.new
    relax(ewdigraph, s)
    while !@pq.is_empty?
      edge = @pq.delete_min
      to = edge.to
      relax(ewdigraph, to)
    end
  end

  def relax(ewdigraph, v)
    ewdigraph.adj(v).each do |e|
      to = e.to
      if @cost_to[to] == nil || @cost_to[to] > @cost_to[v] + e.weight
        @cost_to[to] = @cost_to[v] + e.weight
        @edge_to[to] = e
        if @pq.contains?(e.to)
          @pq.change(e)
        else
          @pq.insert(e)
        end
      end
    end
  end

  def cost_to(v)
    return @cost_to[v]
  end

  def has_path_to(v)
    return @cost_to[v] != nil
  end

  def path_to(v)
    if !has_path_to(v)
      return nil
    else
      path = []
      e = @edge_to[v]
      while e != nil
        path.unshift(e)
        e = @edge_to[e.from]
      end
      return path
    end
  end
end