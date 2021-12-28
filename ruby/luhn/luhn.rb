# frozen_string_literal: true

class Luhn
  class << self
    def valid?(string)
      string
      .tr(' ', '')
      .tap { |str| return false unless str.match?(/^\d{2,}$/) }
      .chars
      .reverse
      .then(&sum_digits_with_evey_second_digit_doubled)
      .then(&is_divisible_by_ten?)
    end

    def sum_digits_with_evey_second_digit_doubled
      lambda do |chars|
        chars.each.with_index.sum do |char, index|
          index.even? ?
            char.to_i :
            char.to_i.then(&double).then(&keep_below_ten)
        end
      end
    end

    def double
      ->(num) { num * 2 }
    end

    def keep_below_ten
      ->(num) { num < 10 ? num : num - 9 }
    end

    def is_divisible_by_ten?
      ->(num) { (num % 10).zero? }
    end
  end
end
