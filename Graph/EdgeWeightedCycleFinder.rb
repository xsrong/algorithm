class EdgeWeightedCycleFinder
  attr_reader :cycle
  def initialize(ewdigraph)
    @cycle = []
    @on_stack = Array.new(ewdigraph.vertex){ false }
    @marked = Array.new(ewdigraph.vertex){ false }
    @edge_to = Array.new(ewdigraph.vertex)
    for i in 0..ewdigraph.vertex - 1
      dfs(ewdigraph, i) if !@marked[i]
    end
  end

  def dfs(ewdigraph, v)
    @on_stack[v] = true
    @marked[v] = true
    ewdigraph.adj(v).each do |edge|
      w = edge.to
      if has_negative_cycle?
        return
      elsif !@marked[w]
        @edge_to[w] = edge
        dfs(ewdigraph, w)
      elsif @on_stack[w]
        x = v
        while x != w
          @cycle.unshift(x)
          x = @edge_to[x].from
        end
        @cycle.unshift(x)
        @cycle.unshift(v)
        return
      end
    end
    @on_stack[v] = false
  end

  def has_negative_cycle?
    return @cycle.length != 0
  end
end