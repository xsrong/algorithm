# 二叉查找树（二叉搜索树）

# 本实现不支持重复键，也不支持键的值为空
# 优点：查找效率高,最佳可达log n。支持有序性操作。
# 劣势在于需要输入的数据本身具有随机性。二叉查找树最佳情况是树的高度为log n。但如果输入的数据是有序的，那么树的高度将变成n，此时操作的最坏情况耗时也会变为线性。

class BST
  attr_accessor :root
  def initialize
    @root = nil
  end
  
  def put key, val, node=@root                          # 向树中插入一对键值
    node = Node.new(key, val) if node == nil            # 当前结点为空时，将键值对存入结点中
    node.val = val if node.key == key                   # 当前结点的key值等于插入的key值是，更改当前结点的val值（不允许重复key）
    if key > node.key
      node.right = put(key, val, node.right)            # 插入的key值大于当前结点key值时，将新的键值对插入到当前结点的右子树中
    elsif key < node.key
      node.left = put(key, val, node.left)              # 插入的key值小于当前结点key值时，将新的键值对插入到当前结点的左子树中
    end
    node.size = size(node.left) + 1 + size(node.right)
    @root = node
  end

  def get key, node=@root                               # 通过key值搜索对应的node
    return nil if node == nil                           # 当前node为空的时候返回空
    return node if node.key == key                      # 当前node的key值与搜索的key值相等时，返回当前node
    if key > node.key
      return get(key, node.right)                       # 搜索的key值大于当前node的key值时，在当前node的右子树中继续搜索
    elsif key < node.key
      return get(key, node.left)                        # 搜索的key值小于当前node的key值时，在当前node的左子树中继续搜索
    end
  end

  def max node=@root                                    # 搜索树中key值最大的node
    return nil if node == nil                           # 当前node为空时返回空
    return node if node.right == nil                    # 当前node不再有右子树时则返回当前node
    return max(node.right)                              # 当前node存在右子树时继续搜索其右子树
  end

  def delete_max node=@root                             # 删除树中key值最大的node
    return node.left if node.right == nil               # 当前node不存在右子树时，则返回其左子树（此时表明当前node已经是最大值）
    node.right = delete_max(node.right)                 # 当前node存在右子树时，则继续搜索其右子树
    node.size = size(node.left) + 1 + size(node.right)
    return node
  end

  def min node=@root                                    # 同max
    return nil if node == nil
    return node if node.left == nil
    return min(node.left)
  end

  def delete_min node=@root                             # 同delete_max
    return node.right if node.left == nil
    node.left = delete_min node.left
    node.size = size(node.left) + 1 + size(node.right)
    return node
  end

  def delete key, node=@root                            # 从树中删除key值对应的node
    return nil if node == nil                           # 当前node为空时返回空
    if key > node.key
      node.right = delete key, node.right               # 删除的key值大于当前node的key值时，在当前node的右子树中搜索
    elsif key < node.key
      node.left = delete key, node.left                 # 删除的key值小于当前node的key值时，在当前node的左子树中搜索
    else                                                # 删除的key值等于当前node的key值时，需要分情况处理
      if node.right == nil
        return @root = node.left                        # 如果当前node只存在左子树，那么当前node的父结点的左子树或者右子树（取决于key和父结点key的大小）就等于当前node的左子树。
      elsif node.left == nil
        return @root = node.right                       # 如果当前结点只存在右子树，那么当前结点的父结点的左子树或者右子树（取决于key和父结点key的大小）就等于当前结点的右子树。
      else
        temp_node = node                                # 如果当前结点同时存在左右子树，则用当前结点右子树中的最小结点代替当前结点
        node = min node.right                           # 选择当前结点的右子树中的最小结点
        node.right = delete_min(temp_node.right)        # 将选择的右子树中的最小结点的右子树设置为原当前节点的右子树，并删去该右子树当中的最小节点
        node.left = temp_node.left                      # 将选择的右子树中的最小结点的左子树设置为原当前节点的左子树
      end
    end
    node.size = size(node.left) + 1 + size(node.right)
    @root = node
  end

  def floor key, node=@root                             # 从树中选中不大于key值中所有结点中最大的结点
    return nil if node == nil
    return node if node.key == key
    if key < node.key
      return floor(key, node.left)                      # 当搜索的key值小于当前结点的key值时，在当前结点的左子树中继续搜索
    elsif key > node.key
      temp_node = floor(key, node.right)                # 当搜索的key值大于当前结点的key值时，保存当前结点，并在当前结点的右子树中继续搜索。
      if temp_node != nil                               # 如果在右子树中能搜索到对应key值的结点，则返回该节点
        return temp_node
      else
        return node                                     # 如果不能搜索到对应key值的结点，则返回之前保存的结点
      end
    end
  end

  def ceiling key, node=@root                           # 同floor
    return nil if node ==  nil
    return node if node.key == key
    if key > node.key
      return ceiling(key, node.right)
    elsif key < node.key
      temp_node = ceiling(key, node.left)
      if temp_node != nil
        return temp_node
      else
        return node
      end
    end
  end

  def select index, node=@root
    return nil if node == nil
    if index < size(node.left)                         
      return select(index, node.left)
    elsif index > size(node.left)                        
      return select(index - size(node.left) - 1, node.right)
    else
      return node
    end
  end

  def rank key, node=@root
    return 0 if node == nil
    if key > node.key
      return size(key.left) + 1 + rank(node.right)
    elsif key < node.key
      return rank(node.left)
    else
      return size(node.left)
    end
  end

  def keys lo, hi, array=[], node=@root
    return if node == nil
    keys(lo, hi, array, node.left) if lo < node.key
    array << node.key if lo <= node.key && hi >= node.key
    keys(lo, hi, array, node.right) if hi > node.key
    return array
  end

  def size node=@root
    return 0 if node == nil
    return node.size
  end

  def height node=@root
    return 0 if node == nil
    left_height = height(node.left)
    right_height = height(node.right)
    if left_height > right_height
      return left_height + 1
    else
      return right_height + 1
    end
  end
end

class Node
  attr_accessor :key, :val, :right, :left, :size
  def initialize(key, val)
    @key = key
    @val = val
    @right = @left = nil
    @size = 1
  end
end

bst = BST.new
bst.put(5, 5)
bst.put(3, 3)
bst.put(4, 4)
bst.put(8, 8)
bst.put(10, 10)
bst.put(6, 6)
bst.put(7, 7)
p bst.size