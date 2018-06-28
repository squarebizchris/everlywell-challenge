class SearchAPI
  def initialize(source_id, destination_id)
    @source_id = source_id
    @destination_id = destination_id
  end

  def search
    graph_data = collect_graph
    path = Search.new(graph_data[:graph], graph_data[:nodes][@source_id]).shortest_path_to(graph_data[:nodes][@destination_id])
    return path
  end

  def collect_graph
    source_member = Member.find(@source_id)
    friend_list = [@source_id]
    searched = friend_list
    nodes = {}
    graph = Graph.new
    nodes[@source_id] = Node.new(source_member.name)
    total_friends = Friendship.all.map(&:friend_id).uniq
    until total_friends.length == searched.length
      friends = Friendship.where(member_id: friend_list).where.not(friend_id: searched).includes(:friend)
      friends.each do |f|
        nodes[f.friend_id] = Node.new(f.friend.name)
        graph.add_edge(nodes[f.member_id], nodes[f.friend_id])
      end
      friend_list = friends.map(&:friend_id).uniq
      searched = searched + friend_list
      searched.uniq!
    end
    return { graph: graph, nodes: nodes}
  end

end
