class DirectedCycle
  attr_reader :cycle
  def initialize(digraph)
    @on_stack = Array.new(digraph.vertex){ false }
    @edge_to = Array.new(digraph.vertex)
    @marked = Array.new(digraph.vertex)
    @cycle = []
    for i in 0..digraph.vertex - 1
      dfs(digraph, i) if !@marked[i]
    end
  end

  def dfs(digraph, v)
    @on_stack[v] = true
    @marked[v] = true
    digraph.adj(v).each do |w|
      if has_cycle?
        return
      elsif !@marked[w]
        @edge_to[w] = v
        dfs(digraph, w)
      elsif @on_stack[w]
        x = v
        while x != w
          @cycle << x
          x = @edge_to[x]
        end
        @cycle << w
        @cycle << v
      end
    end
    @on_stack[v] = false
  end

  def has_cycle?
    return @cycle.length != 0
  end
end