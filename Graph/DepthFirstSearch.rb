class DepthFirstSearch
  def initialize(graph, s)
    @marked = Array.new(graph.vertex){ false }
    @edge_to = []
    @count = 0
    @start = s
    dfs(graph, @start)
  end

  def dfs(graph, v)
    @marked[v] = true
    @count += 1
    graph.adj(v).each do |w|
      if !@marked[w]
        @edge_to[w] = v
        dfs(graph, w) 
      end
    end
  end

  def has_path_to?(v)
    return @marked[v]
  end

  def path_to(v)
    path = []
    while v != @start
      path.unshift(v)
      v = @edge_to[v]
    end
    path.unshift(v)
    return path
  end

  def count
    return @count
  end
end