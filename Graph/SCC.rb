require_relative 'DepthFirstOrder'

class KosarajuSCC
  attr_reader :id, :count
  def initialize(digraph)
    @marked = Array.new(digraph.vertex){ false }
    @id = Array.new(digraph.vertex)
    order = DepthFirstOrder.new(digraph.reverse)
    @count = 0
    order.reverse_post.each do |i|
      if !@marked[i]
        dfs(digraph, i) 
        @count += 1
      end
    end
  end

  def dfs(digraph, v)
    @marked[v] = true
    @id[v] = @count
    digraph.adj(v).each do |w|
      dfs(digraph, w) if !@marked[w]
    end
  end

  def is_strongly_connected?(v, w)
    return @id[v] == @id[w]
  end
end