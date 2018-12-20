class CC
  attr_reader :id, :count
  def initialize(graph)
    @marked = Array.new(graph.vertex){ false }
    @id = Array.new(graph.vertex)
    @count = 0
    for v in 0..graph.vertex - 1
      if !@marked[v]
        dfs(graph, v)
        @count += 1
      end
    end
  end

  def dfs(graph, v)
    @marked[v] = true
    @id[v] = @count
    graph.adj(v).each do |w|
      dfs(graph, w) if !@marked[w]
    end
  end

  def is_connected?(v, w)
    return @id[v] == @id[w]
  end
end