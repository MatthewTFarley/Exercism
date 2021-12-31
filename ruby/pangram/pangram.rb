class Pangram
  class << self
    def pangram?(sentence)
      sentence
      .gsub(/[^a-zA-Z]/, '')
      .chars
      .map(&:downcase)
      .tally
      .count
      .eql?(26)
    end
  end
end
