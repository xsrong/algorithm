class RB_BST
   def initialize
    @root = nil
  end
  
  def _put key, val, node
    return Node.new(key, val) if node == nil
    if key > node.key
      node.right = _put key, val, node.right
    elsif key < node.key
      node.left = _put key, val, node.left
    else
      node.val = val
    end
    node = rotate_left(node) if !is_red?(node.left) && is_red?(node.right)
    node = rotate_right(node) if is_red?(node.left) && is_red?(node.left.left)
    flip_colors(node) if is_red?(node.left) && is_red?(node.right)
    # node.size = size(node.left) + 1 + size(node.right)
    return node
  end

  def put key, val
    @root = _put key, val, @root
    @root.color = Node::BLACK
  end

  def get key, node=@root                               # 通过key值搜索对应的node
    return nil if node == nil
    if key > node.key
      get key, node.right
    elsif key < node.key
      get key, node.left
    else
      return node
    end
  end

  def max node=@root                                    # 搜索树中key值最大的node
    return nil if node == nil
    return node if node.right == nil
    return max node.right
  end

  def _delete_max node
    node = rotate_right(node) if is_red?(node.left)                                    # 如果左链接为红，就进行一次右旋转
    return nil if node.right == nil                                                    # 如果右子树为空，表明当前结点即为树的最大结点，将当前结点重置为空
    node = move_red_right(node) if !is_red?(node.right) && !is_red?(node.right.left)   # 如果当前结点的右子树不为空，且右子结点和右子结点的左子结点均为黑，则执行move_red_right
    node.right = _delete_max(node.right)                                               # 继续沿右子树向下
    return fix_up(node)                                                                # 沿查找路径向上恢复树的有序性
  end

  def delete_max                             # 删除树中key值最大的node
    @root = _delete_max(@root)
    @root.color = Node::BLACK if @root != nil
  end

  def min node=@root                                    # 同max
    return nil if node == nil
    return node if node.left == nil
    return min node.left
  end

  def delete_min node=@root                             # 同delete_max
  end

  def delete key, node=@root                            # 从树中删除key值对应的node
  end

  def floor key, node=@root                             # 从树中选中不大于key值中所有结点中最大的结点
  end

  def ceiling key, node=@root                           # 同floor
  end

  def select index, node=@root
  end

  def rank key, node=@root
  end

  def keys lo, hi, array=[], node=@root
  end

  def size node=@root
    return 0 if node == nil
    # return node.size
    return size(node.left) + 1 + size(node.right)
  end

  def height node=@root
  end

  private

    def is_red?(node)
      return false if node == nil
      return node.color == Node::RED
    end

    def rotate_left h
      x = h.right
      h.right = x.left
      x.left = h
      x.color = h.color
      h.color = Node::RED
      # x.size = h.size
      # h.size = size(h.left) + 1 + size(h.right)
      return x
    end

    def move_red_left h
      flip_colors h
      if is_red?(h.right.left)
        h.right = rotate_right(h.right)
        h = rotate_left(h)
        flip_colors(h)
      end
      return h
    end

    def rotate_right h
      x = h.left
      h.left = x.right
      x.right = h
      x.color = h.color
      h.color = Node::RED
      # x.size = h.size
      # h.size = size(h.left) + 1 + size(h.right)
      return x
    end

    def move_red_right h
      flip_colors(h)
      if is_red?(h.left.left)
        h = rotate_right(h)
        flip_colors(h)
      end
      return h
    end

    def flip_colors h
      h.color = !h.color
      h.right.color = !h.right.color
      h.left.color = !h.left.color
    end

    def fix_up h
      h = rotate_left(h) if is_red?(h.right)
      h = rotate_right(h) if is_red?(h.left) && is_red?(h.left.left)
      flip_colors(h) if is_red?(h.left) && is_red?(h.right)
      return h
    end
end

class Node
  attr_accessor :key, :val, :size, :color, :left, :right
  RED, BLACK = true, false
  def initialize key, val, size=1, color=RED
    @key, @val, @size, @color = key, val, size, color
    @right = @left = nil
  end
end

bst = RB_BST.new
# bst.put(1, 1)
# bst.put(2, 2)
bst.put(6, 6)
# bst.put(3, 3)
# bst.put(4, 4)
bst.delete_max
p bst