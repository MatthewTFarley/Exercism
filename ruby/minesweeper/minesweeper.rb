# frozen_string_literal: true

class Board
  ADJACENT_COORDS = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0], [0,  0], [1,  0],
    [-1,  1], [0,  1], [1,  1],
  ]

  class << self
    def transform(board)
      raise ArgumentError if invalid?(board)

      board.map.with_index do |row, y|
        row.chars.map.with_index do |cell, x|
          next cell unless cell == ' '

          ADJACENT_COORDS
          .sum(&adjacent_mine(board, x, y))
          .then(&mark_cell)
        end.join
      end
    end

    def adjacent_mine(board, x, y)
      lambda { |(x1, y1)| board[y + y1][x + x1] == '*' ? 1 : 0 }
    end

    def mark_cell
      ->(sum) { sum.zero? ? ' ' : sum.to_s }
    end

    def invalid?(board)
      contains_invalid_chars?(board) ||
      columns_not_equal_lengths?(board) ||
      faulty_borders?(board)
    end

    def contains_invalid_chars?(board)
      board.flatten.join.match?(/[^+\-|* ]/)
    end

    def columns_not_equal_lengths?(board)
      board.map(&:length).uniq.count != 1
    end

    def faulty_borders?(board)
      !board.all? do |row|
        first, last = [row[0], row[-1]]
        [first, last].all? { |cell| cell == '+' } ||
        [first, last].all? { |cell| cell == '|' }
      end
    end
  end
end
