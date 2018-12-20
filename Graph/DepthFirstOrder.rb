capture = '..\\Basic Data Structure\\'
require_relative capture + 'Queue'
require_relative capture + 'Stack'

class DepthFirstOrder
  attr_reader :pre, :post, :reverse_post
  def initialize(digraph)
    @marked = []
    @pre = Queue.new
    @post = Queue.new
    @reverse_post = Stack.new
    for i in 0..digraph.vertex - 1
      dfs(digraph, i) if !@marked[i]
    end
  end

  def dfs(digraph, v)
    @pre.enqueue(v)
    @marked[v] = true
    digraph.adj(v).each do |w|
      w = w.to
      dfs(digraph, w) if !@marked[w]
    end
    @post.enqueue(v)
    @reverse_post.push(v)
  end
end