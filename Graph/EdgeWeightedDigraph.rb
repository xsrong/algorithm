require_relative 'DirectedEdge'

class EdgeWeightedDigraph
  def initialize(num=0)
    @vertex = num
    @adj = Array.new(@vertex){ Array.new }
    @edge = 0
  end

  def load(filename, delim)
    datas = File.readlines(filename).map{ |line| line = line.chomp }
    @vertex = datas[0].to_i
    @adj = Array.new(@vertex){ Array.new }
    for i in 2..datas.length - 1
      d = datas[i].split(delim)
      from = d[0].to_i
      to = d[1].to_i
      weight = d[2].to_f
      edge = DirectedEdge.new(from, to, weight)
      add_edge(edge)
    end
    return self
  end

  def vertex
    return @vertex
  end

  def edges
    e = []
    for i in 0..@vertex - 1
      @adj[i].each do |edge|
        e << edges
      end
    end
    return e 
  end

  def add_edge(edge)
    @adj[edge.from] << edge
    @edge += 1
  end

  def edge_count
    return @edge
  end

  def adj(v)
    return @adj[v]
  end
end