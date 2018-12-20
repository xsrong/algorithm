require_relative 'Alphabet'

class Node
  attr_accessor :char, :val, :left, :mid, :right
  def initialize
    @char = nil
    @left = @mid = @right = nil
    @val = nil
  end
end

class TST
  attr_reader :root
  def initialize
    @alpha = Alphabet.new
    @root = nil
  end

  def insert(key, val)
    @root = _insert(@root, key, val, 0)
  end

  def search(key)
    return _search(@root, key, 0)
  end

  def delete(key)
    @root = _delete(@root, key, 0)
  end

  def keys
    all_keys = []
    _collect(@root, '', all_keys)
    return all_keys
  end

  def keys_with_prefix(pre)
    all_keys = []
    node = _search(@root, pre, 0)
    return all_keys if node == nil
    all_keys << pre if node.val != nil
    _collect(node.mid, pre, all_keys)
    return all_keys
  end

  def keys_that_match(pat)
    all_keys = []
    _collect2(@root, '', 0, pat, all_keys)
    return all_keys
  end

  def longest_prefix(str)
    d = _search_longest_prefix(@root, str, 0, 0)
    return d == 0 ? '' : str[0..d - 1]
  end

  private
    def _insert(node, key, val, d)
      char = key[d]
      char = '' if char == nil
      if node == nil
        node = Node.new
        node.char = char
      end
      if @alpha.to_index(node.char) > @alpha.to_index(char)
        node.left = _insert(node.left, key, val, d)
      elsif @alpha.to_index(node.char) < @alpha.to_index(char)
        node.right = _insert(node.right, key, val, d)
      elsif d < key.length - 1
        node.mid = _insert(node.mid, key, val, d+1)
      else
        node.val = val
      end
      return node
    end

    def _search(node, key, d)
      return nil if node == nil
      char = key[d]
      if @alpha.to_index(node.char) > @alpha.to_index(char)
        return _search(node.left, key, d)
      elsif @alpha.to_index(node.char) < @alpha.to_index(char)
        return _search(node.right, key, d)
      elsif d < key.length - 1
        return _search(node.mid, key, d+1)
      else
        return node
      end
    end

    def _delete(node, key, d)
      return nil if node == nil
      char = key[d]
      if @alpha.to_index(node.char) > @alpha.to_index(char)
        node.left = _delete(node.left, key, d)
      elsif @alpha.to_index(node.char) < @alpha.to_index(char)
        node.right = _delete(node.right, key, d)
      elsif d < key.length - 1
        node.mid = _delete(node.mid, key, d+1)
      else
        node.val = nil
      end
      if node.val != nil
        return node
      elsif node.mid == nil
        if node.right == nil
          return node.left
        elsif node.left == nil
          return node.right
        else node.right != nil && node.left == nil
          temp_node = node
          node = _min(node.right)
          node.right = _delete_min(temp_node.right)
          node.left = temp_node.left
          return node
        end
      else
        return node
      end
    end

    def _delete_min(node)
      return nil if node == nil
      return node.right if node.left == nil
      node.left = _delete_min(node.left)
      return node
    end

    def _min(node)
      return nil if node == nil
      return node if node.left == nil
      return _min(node.left)
    end

    def _collect(node, key, arr)
      return if node == nil
      _collect(node.left, key, arr)
      arr << key + node.char if node.val != nil
      _collect(node.mid, key + node.char, arr)
      _collect(node.right, key, arr)
    end

    def _collect2(node, pre, i, pat, arr)
      return if node == nil
      char = pat[i]
      _collect2(node.left, pre, i, pat, arr) if char == '.' || @alpha.to_index(char) < @alpha.to_index(node.char)
      if char == '.' || @alpha.to_index(char) == @alpha.to_index(node.char)
        if i == pat.length - 1 && node.val != nil
          arr << pre + node.char
        elsif i < pat.length - 1
          _collect2(node.mid, pre + node.char, i + 1, pat, arr)
        end
      end
      _collect2(node.right, pre, i, pat, arr) if char == '.' || @alpha.to_index(char) > @alpha.to_index(node.char)
    end

    def _search_longest_prefix(node, str, d, length)
      return length if node == nil
      if @alpha.to_index(node.char) > @alpha.to_index(str[d])
        length = _search_longest_prefix(node.left, str, d, length)
      elsif @alpha.to_index(node.char) < @alpha.to_index(str[d])
        length = _search_longest_prefix(node.right, str, d, length)
      elsif @alpha.to_index(node.char) == @alpha.to_index(str[d])
        d += 1
        length = d if node.val != nil
        length = _search_longest_prefix(node.mid, str, d, length)
      end
    end

end