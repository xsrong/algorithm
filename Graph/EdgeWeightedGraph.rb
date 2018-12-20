require_relative 'Edge'

class EdgeWeightedGraph
  def initialize(num=0)
    @vertex = num
    @edge = 0
    @adj = Array.new(@vertex){ Array.new }
  end

  def load(filename, delim)
    datas = File.readlines(filename)
    @vertex = datas[0].to_i
    @adj = Array.new(@vertex){ Array.new }
    for i in 2..datas.length - 1
      d = datas[i].chomp.split(delim)
      v = d[0].to_i
      w = d[1].to_i
      weight = d[2].to_f
      edge = Edge.new(v, w, weight)
      add_edge(edge)
    end
    return self
  end

  def vertex
    return @vertex
  end

  def edge_count
    return @edge
  end

  def add_edge(edge)
    v = edge.v
    w = edge.w
    @adj[v] << edge
    @adj[w] << edge
    @edge += 1
  end

  def adj(v)
    return @adj[v]
  end

  def edges
    edges_arr = []
    for i in 0..@vertex - 1
      adj(i).each do |edge|
        edges_arr << edge if edge.other(i) > i
      end
    end
    return edges_arr
  end
end