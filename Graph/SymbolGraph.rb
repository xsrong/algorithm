require_relative 'Digraph'

class SymbolGraph
  def initialize(filename, delim)
    @names = []
    datas = File.readlines(filename)
    datas.each do |d|
      d.split(delim).each do |n|
        @names << n.chomp if !@names.include?(n.chomp)
      end
    end
    @graph = Digraph.new(@names.length)
    datas.each do |d|
      all = d.chomp.split(delim)
      for v in 1..all.length - 1
        @graph.add_edge(index(all[0]), index(all[v]))
      end
    end
  end

  def contains?(key)
    return @names.include?(key)
  end

  def index(key)
    return @names.index(key)
  end

  def name(v)
    return @names[v]
  end

  def graph
    return @graph
  end

  def path_to(s, t)
    bfs = BreadthFirstSearch.new(graph, index(s))
    path = bfs.path_to(index(t))
    for i in 0..path.length - 1
      path[i] = name(path[i])
    end
    return path
  end
end