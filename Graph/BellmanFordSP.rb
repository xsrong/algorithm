require_relative '../Basic Data Structure/Queue'
require_relative 'EdgeWeightedDigraph'
require_relative 'DirectedEdge'
require_relative 'EdgeWeightedCycleFinder'

class BellmanFordSP
  def initialize(ewdigraph, s=0)
    @cost_to = Array.new(ewdigraph.vertex){ nil }
    @cost_to[s] = 0.0
    @edge_to = Array.new(ewdigraph.vertex)
    @on_queue = Array.new(ewdigraph.vertex){ false }
    @queue = Queue.new
    @cost = 0
    @cycle = []
    @queue.enqueue(s)
    @on_queue[s] = true
    while !@queue.is_empty? && !has_negative_cycle?
      v = @queue.dequeue
      @on_queue[v] = false
      relax(ewdigraph, v)
    end
  end

  def relax(ewdigraph, v)
    ewdigraph.adj(v).each do |edge|
      w = edge.to
      if @cost_to[w] == nil || @cost_to[w] > @cost_to[v] + edge.weight
        @cost_to[w] = @cost_to[v] + edge.weight
        @edge_to[w] = edge
        if !@on_queue[w]
          @queue.enqueue(w)
          @on_queue[w] = true
        end
      end
      @cost += 1
      find_negative_cycle if @cost % ewdigraph.vertex == 0
    end
  end

  def cost_to(v)
    return @cost_to[v]
  end

  def has_path_to?(v)
    return @cost_to[v] != nil
  end

  def path_to(v)
    if !has_path_to?(v)
      return nil
    elsif has_negative_cycle?
      puts 'Error: No shortest path because the graph includes a negative cycle: '
      p negative_cycle
      return nil
    else
      path = Array.new
      x = v
      while @edge_to[x] != nil
        path.unshift(x)
        x = @edge_to[x].from
      end
      path.unshift(x)
      return path
    end
  end


  def find_negative_cycle
    v = @edge_to.length
    spt = EdgeWeightedDigraph.new(v)
    @edge_to.each do |edge|
      spt.add_edge(edge) if edge != nil
    end
    cycle_finder = EdgeWeightedCycleFinder.new(spt)
    @cycle = cycle_finder.cycle
  end

  def has_negative_cycle?
    return @cycle.length != 0
  end

  def negative_cycle
    return @cycle
  end
end