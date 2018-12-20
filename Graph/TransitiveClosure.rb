require_relative 'DepthFirstSearch'

class TransitiveClosure
  def initialize(digraph)
    @all = []
    for i in 0..digraph.vertex - 1
      @all[i] = DepthFirstSearch.new(digraph, i)
    end
  end

  def is_reachable?(from, to)
    return @all[from].has_path_to?(to)
  end
end