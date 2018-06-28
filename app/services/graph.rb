class Graph
  def add_edge(node_a, node_b)
    node_a.friends << node_b
    node_b.friends << node_a
  end
end
