require_relative 'Topological'

class AcyclicSP
  def initialize(ewdigraph, s)
    @cost_to = Array.new(ewdigraph.vertex){ nil }
    @edge_to = Array.new(ewdigraph.vertex)
    topo = Topological.new(ewdigraph)
    @cost_to[topo.order.first.item] = 0.0
    topo.order.each do |v|
      relax(ewdigraph, v.item)
    end
  end

  def relax(ewdigraph, v)
    ewdigraph.adj(v).each do |e|
      to = e.to
      if @cost_to[to] == nil || @cost_to[to] > @cost_to[v] + e.weight
        @cost_to[to] = @cost_to[v] + e.weight
        @edge_to[to] = e
      end
    end
  end

  def has_path_to?(v)
    return @cost_to[v] != nil 
  end

  def cost_to(v)
    return @cost_to[v]
  end

  def path_to(v)
    if !has_path_to?(v)
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