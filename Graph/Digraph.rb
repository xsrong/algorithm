class Digraph
  def initialize(num=0)
    @v = num
    @adj = Array.new(num){ Array.new }
    @e = 0
  end

  def load(filename, delim)
    datas = File.readlines(filename)
    @v = datas[0].to_i
    @adj = Array.new(@v){ Array.new }
    @e = 0
    for i in 2..datas.length - 1
      v = datas[i].split(delim)[0].to_i
      w = datas[i].split(delim)[1].to_i
      add_edge(v, w)
    end
    return self
  end

  def vertex
    return @v
  end

  def edge
    return @e
  end

  def add_edge(v, w)
    @adj[v] << w
    @e += 1
  end

  def adj(v)
    return @adj[v]
  end

  def reverse
    digraph = Digraph.new(@v)
    for i in 0..digraph.vertex
      adj(i).each do |w|
        digraph.add_edge(w, v)
      end
    end
    return digraph
  end
end