class RB_BST2
  def initialize
    @root = nil
  end

  def get(key)
    return _get(@root, key)
  end

  def insert(key, val)
    @root = _insert(key, val, @root)
    @root.color = Node::BLACK
  end

  def get_max
    return _get_max(@root)
  end

  def get_min
    return _get_min(@root)
  end

  def delete_max
    @root = _delete_max(@root)
    @root.color = Node::BLACK if @root != nil
  end

  def delete_min
    @root = _delete_min(@root)
    @root.color = Node::BLACK if @root != nil
  end

  def delete(key)
    @root.color = Node::RED if !is_red?(root.left) && !is_red?(root.right)
    @root = _delete(@root, key)
    @root.color = Node::BLACK if @root != nil
  end

  def show(node=@root)
    return if node == nil
    print node.key
    show(node.left)
    show(node.right)
  end

  private

    def _get(node, key)
      return nil if node == nil
      if key > node.key
        _get(node.right, key)
      elsif key < node.key
        _get(node.left, key)
      else
        return node.val
      end
    end

    def _get_max(node)
      return nil node == nil
      return node if node.right == nil
      return _get_max(node.right)
    end

    def _get_min(node)
      return nil if node == nil
      return node if node.left == nil
      return _get_min(node.left)
    end

    def _insert(key, val, node)
      return Node.new(key, val) if node == nil
      if key > node.key
        node.right = _insert(key, val, node.right)
      elsif key < node.key
        node.left = _insert(key, val, node.left)
      else
        node.val = val
      end
      return fix_up(node)
    end

    def _delete_max(node)
      node = rotate_right(node) if is_red?(node.left)
      return nil if node.right == nil
      node = move_red_right(node) if !is_red?(node.right) && !is_red?(node.right.left)
      node.right = _delete_max(node.right)
      return fix_up(node)
    end

    def _delete_min(node)
      return nil if node.left == nil
      node = move_red_left(node) if is_red?(node.left) && is_red?(node.left.left)
      node.left = _delete_min(node.left)
      return fix_up(node)
    end

    def _delete(node, key)
      if key < node.key
        node = move_red_left(node) if !is_red?(node.left) && !is_red?(node.left.left)
        node.left = _delete(node.left, key)
      else
        node = rotate_right(node) if is_red?(node.left)
        return nil if key == node.key && node.right == nil
        node = move_red_right(node) if !is_red?(node.right) && is_red?(node.right.left)
        if key == node.key
          node.val = _get(node.right, min(node.right).key)
          node.key = min(node.right).key
          node.right = delete_min(node.right)
        else
          node.right = _delete(node.right, key)
        end
      end
      return fix_up(node)
    end

    def rotate_left(h)
      x = h.right
      h.right = x.left
      x.left = h
      x.color = h.color
      h.color = Node::RED
      x.size = h.size
      h.size = size(h.left) + 1 + size(h.right)
      return x
    end

    def rotate_right(h)
      x = h.left
      h.left = x.right
      x.right = h
      x.color = h.color
      h.color = Node::RED
      x.size = h.size
      h.size = size(h.left) + 1 + size(h.right)
      return x
    end

    def move_red_left(h)
      flip_color(h)
      if is_red?(h.right.left)
        h.right = rotate_right(h.right)
    end

    def move_red_right(h)
      flip_color(h)
      if is_red?(h.left.left)
        h = rotate_right(h)
        flip_color(h)
      end
      return h
    end
    
    def flip_color(h)
      h.color = !h.color
      h.left.color = !h.left.color
      h.right.color = !h.right.color
    end

    def is_red?(h)
      return false if h == nil
      return h.color
    end

    def fix_up(h)
      h = rotate_left(h) if is_red?(h.right)
      h = rotate_right(h) if is_red?(h.left) && is_red?(h.left.left)
      flip_color(h) if is_red?(h.left) && is_red?(h.right)
      h.size = size(h.left) + 1 + size(h.right)
      return h
    end

    def size(h)
      return 0 if h == nil
      return h.size
    end
end

class Node
  attr_accessor :key, :val, :left, :right, :color, :size
  RED, BLACK = true, false
  def initialize(key, val, left=nil, right=nil, size=1, color=RED)
    @key, @val, @size, @color = key, val, size, color
    @left = @right = nil
  end
end

rbt = RB_BST2.new
arr = [10, 30, 4, 3, 2, 1, 0, 5, 7, 6, 8]
arr.each do |num|
  rbt.insert(num, num)
end
rbt.show