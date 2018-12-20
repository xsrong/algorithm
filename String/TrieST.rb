require_relative 'Alphabet'

class Node
  attr_accessor :key, :val, :next
  def initialize
    @key = nil
    @val = nil
    @next = []
  end
end

class TrieST
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
    _collect(node, pre, all_keys)
    return all_keys
  end

  def keys_that_match(pat)
    all_keys = []
    _collect2(@root, '', pat, all_keys)
    return all_keys
  end

  def longest_prefix(str)
    d = search_longest_prefix(@root, str, 0, 0)
    return d == 0 ? '' : str[0..d - 1]
  end

  private

    def _insert(node, key, val, d)
      node = Node.new if node == nil
      if d == key.length
        node.val = val
        return node
      end
      char = key[d]
      node.next[@alpha.to_index(char)] = _insert(node.next[@alpha.to_index(char)], key, val, d+1)
      node.next[@alpha.to_index(char)].key = char
      return node
    end

    def _search(node, key, d)
      return nil if node == nil
      return node if d == key.length
      char = key[d]
      return _search(node.next[@alpha.to_index(char)], key, d+1)
    end

    def _delete(node, key, d)
      return nil if node == nil
      if d == key.length
        node.val = nil
      else
        char = key[d]
        node.next[@alpha.to_index(char)] = _delete(node.next[@alpha.to_index(char)], key, d+1)
      end
      return node if node.val != nil
      for i in 0..@alpha.radix - 1
        return node if node.next[i] != nil
      end
      return nil
    end

    def _collect(node, pre, arr)
      return if node == nil
      arr << pre if node.val != nil
      for i in 0..@alpha.radix - 1
        _collect(node.next[i], pre + @alpha.to_char(i), arr)
      end
    end

    def _collect2(node, pre, pat, arr)
      d = pre.length
      return if node == nil
      arr << pre if node.val != nil && d == pat.length
      return if d == pat.length
      char = pat[d]
      for i in 0..@alpha.radix - 1
        _collect2(node.next[i], pre + @alpha.to_char(i), pat, arr) if char == '.' || char == @alpha.to_char(i)
      end
    end

    def _search_longest_prefix(node, str, d, length)
      return length if node == nil
      length = d if node.val != nil
      return length if d == str.length
      char = str[d]
      return _search_longest_prefix(node.next[@alpha.to_index(char), str, d+1, length])
    end
end

class TrieST2
  attr_reader :root
  def initialize
    @alpha = Alphabet.new
    @root = nil
  end

  def insert(key, val)
    @root = Node.new if @root == nil
    node = @root
    for i in 0..key.length - 1
      char = key[i]
      node.next[@alpha.to_index(char)] = Node.new if node.next[@alpha.to_index(char)] == nil
      node.next[@alpha.to_index(char)].key = char
      node = node.next[@alpha.to_index(char)]
    end
    node.val = val
  end

  def search(key)
    return nil if @root == nil
    node = @root
    for i in 0..key.length - 1
      char = key[i]
      return nil if node.next[@alpha.to_index(char)] == nil
      node = node.next[@alpha.to_index(char)]
    end
    return node
  end

  def delete(key)
    node = @root
    nodes_stack = []
    nodes_stack << node
    return @root if node == nil
    for i in 0..key.length - 1
      char = key[i]
      return @root if node.next[@alpha.to_index(char)] == nil
      nodes_stack << node.next[@alpha.to_index(char)]
      node = node.next[@alpha.to_index(char)]
    end
    node.val = nil
    temp_node = node
    while nodes_stack.length != 0
      node1 = nodes_stack.pop
      node2 = nodes_stack[-1]
      node1.next.each do |ns|
        return @root if node1.val != nil || ns != nil
      end
      node2.next[node2.next.index(node1)] = nil
    end
    return @root
  end

  def keys
    return collect(@root, '')
  end

  def keys_with_prefix(pre)
    node = search(pre)
    return collect(node, pre)
  end

  def keys_that_match(pat)
    return collect2(@root, pat, '')
  end

  def longest_perfix(str)
    node = @root
    length = 0
    for i in 0..str.length - 1
      char = str[i]
      next_node = node.next[@alpha.to_index(char)]
      if next_node == nil
        break
      elsif next_node.val != nil
        length = i
      end
      node = next_node
    end
    return length == 0 ? '' : str[0..length]
  end

  def collect2(node, pat, key)
    return [] if node == nil
    nodes_stack = []
    keys_stack = []
    indexs_stack = []
    res = []
    nodes_stack << node
    keys_stack << key
    indexs_stack << 0
    while nodes_stack.length != 0
      ns = nodes_stack.pop
      k = keys_stack.pop
      index = indexs_stack.pop
      ns.next.each do |n|
        if n == nil || (pat[index] != '.' && n.key != pat[index])
          next
        elsif n.val == nil && (n.key == pat[index] || pat[index] == '.')
          key2 = k + n.key
          keys_stack << key2
          nodes_stack << n
          indexs_stack << index + 1
        else
          key2 = k + n.key
          keys_stack << key2
          indexs_stack << index + 1
          nodes_stack << n
          res << key2 if key2.length == pat.length
        end
      end
    end
    return res
  end

  def collect(node, key)
    return [] if node == nil
    res = []
    keys_stack = []
    nodes_stack = []
    keys_stack << key
    nodes_stack << node
    while nodes_stack.length != 0
      ns = nodes_stack.pop
      k = keys_stack.pop
      ns.next.each do |n|
        if n == nil
          next
        elsif n.val == nil
          key2 = k + n.key
          keys_stack << key2
          nodes_stack << n
        else
          key2 = k + n.key
          keys_stack << key2
          nodes_stack << n
          res << key2
        end
      end
    end
    return res
  end
end