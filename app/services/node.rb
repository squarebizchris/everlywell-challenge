require "set"

class Node
  attr_accessor :name, :friends
  def initialize(name)
    @friends = Set.new
    @name = name
  end

  def to_s
    @name
  end
end
