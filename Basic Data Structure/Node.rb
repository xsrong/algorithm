class Node
  attr_accessor :item, :next
  def initialize(item, nExt=nil)
    @item = item
    @next = nExt
  end
end