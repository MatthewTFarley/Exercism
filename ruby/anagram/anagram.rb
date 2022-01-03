class Anagram
  attr_reader :gram_to_match

  def initialize(gram_to_match)
    @gram_to_match = gram_to_match
  end

  def match(grams)
    grams
    .reject { |gram| gram.downcase == gram_to_match.downcase }
    .select do |gram|
      gram.downcase.chars.sort.eql?(gram_to_match.downcase.chars.sort)
    end
  end
end
