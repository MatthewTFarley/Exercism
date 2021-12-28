# frozen_string_literal: true

class Queens
  def initialize(white:, black: [])
    raise ArgumentError if [*white, *black].any? { |coord| !(0..7).include?(coord) }

    @white = white
    @black = black
  end

  def attack?
    same_rank? || same_file? || same_diagonal?
  end

  private

  attr_reader :white, :black

  def same_rank?
    white.zip(black).first.uniq.length == 1
  end

  def same_file?
    white.zip(black).last.uniq.length == 1
  end

  def same_diagonal?
    white.zip(black).map { |x, y| (x - y).abs }.uniq.length == 1
  end
end
