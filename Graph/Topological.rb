require_relative 'DirectedCycle'
require_relative 'DepthFirstOrder'
require_relative 'EdgeWeightedCycleFinder'

class Topological
  attr_reader :order
  def initialize(digraph)
    if digraph.is_a?(Digraph)
      cycle_finder = DirectedCycle.new(digraph)
      if !cycle_finder.has_cycle?
        dfs = DepthFirstOrder.new(digraph)
        @order = dfs.reverse_post
      end
    elsif digraph.is_a?(EdgeWeightedDigraph)
      cycle_finder = EdgeWeightedCycleFinder.new(digraph)
      if !cycle_finder.has_cycle?
        dfs = DepthFirstOrder.new(digraph)
        @order = dfs.reverse_post
      end
    end
  end

  def is_DAG?
    return !@order.nil?
  end
end