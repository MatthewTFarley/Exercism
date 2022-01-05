class Proverb
  attr_reader :items, :qualifier

  def initialize(*items, qualifier: nil)
    @items = items
    @qualifier = qualifier
  end

  def to_s
    items
    .each_cons(2)
    .map { |a, b| "For want of a #{a} the #{b} was lost." }
    .push("And all for the want of a #{qualified_initial_item}.")
    .join("\n")
  end

  def qualified_initial_item
    qualifier ? "#{qualifier} #{items.first}" : items.first
  end
end
