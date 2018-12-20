class Graph
  def initialize(num=0)
    @v = num
    @adj = Array.new(num){Array.new}
    @e = 0
  end

  def load(filename)
    datas = File.readlines(filename)
    @v = datas[0].to_i
    @e = 0
    @adj = Array.new(@v){Array.new}
    for i in 2..datas.length - 1
      d = datas[i].split(" ")
      v = d[0].to_i
      w = d[1].to_i
      add_edge(v, w)
    end
    return self
  end

  def vertex    # 返回图中顶点的数量
    return @v
  end

  def edge      # 返回图中边的数量
    return @e
  end

  def add_edge(v, w)      # 添加一条连接顶点v和w的边
    @adj[v] << w
    @adj[w] << v
    @e += 1
  end

  def adj(v)    # 返回图中所有与顶点v相邻的顶点
    return @adj[v]
  end
end