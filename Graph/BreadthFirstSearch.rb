class BreadthFirstSearch
  def initialize(graph, s)
    @marked = Array.new(graph.vertex){ false }
    @edge_to = []
    @start = s
    @count = 0
    bfs(graph, @start)
  end

  def bfs(graph, s)
    queue = []
    @marked[s] = true
    queue << s
    while queue.length != 0
      v = queue.shift
      graph.adj(v).each do |w|
        if !@marked[w]
          @edge_to[w] = v
          @marked[w] = true
          queue << w
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
  end
end