# frozen_string_literal: true

require 'ostruct'

class TwelveDays
  class << self
    def song
      1.upto(12).map(&verse).join("\n\n").concat("\n")
    end

    def verse
      lambda do |number|
        Day.new(number)
        .then { |day| [day.nth, day.gift] }
        .then do |(nth, gift)|
          "On the #{nth} day of Christmas my true love gave to me: #{gift}."
        end
      end
    end
  end

  class Day
    attr_reader :number

    def initialize(number)
      @number = number
      @values = index[number]
    end

    def nth
      values.nth
    end

    def gift
      number > 2 ?
        "#{unique_gift}, #{previous_middle_day_unique_gifts}, and #{first_gift}" :
        values.gift
    end

    def unique_gift
      values.unique_gift
    end

    def previous_middle_day_unique_gifts
      index.values.slice(1..number.pred.pred).reverse.map(&:unique_gift).join(', ')
    end

    def first_gift
      index[1].unique_gift
    end

    private

    attr_reader :values

    FIRST_DAY_GIFT  = 'a Partridge in a Pear Tree'
    SECOND_DAY_GIFT = 'two Turtle Doves'

    def index
      @index ||= {
        1  => OpenStruct.new(nth: 'first',    unique_gift: FIRST_DAY_GIFT, gift: FIRST_DAY_GIFT),
        2  => OpenStruct.new(nth: 'second',   unique_gift: SECOND_DAY_GIFT, gift: "#{SECOND_DAY_GIFT}, and #{FIRST_DAY_GIFT}"),
        3  => OpenStruct.new(nth: 'third',    unique_gift: 'three French Hens'),
        4  => OpenStruct.new(nth: 'fourth',   unique_gift: 'four Calling Birds'),
        5  => OpenStruct.new(nth: 'fifth',    unique_gift: 'five Gold Rings'),
        6  => OpenStruct.new(nth: 'sixth',    unique_gift: 'six Geese-a-Laying'),
        7  => OpenStruct.new(nth: 'seventh',  unique_gift: 'seven Swans-a-Swimming'),
        8  => OpenStruct.new(nth: 'eighth',   unique_gift: 'eight Maids-a-Milking'),
        9  => OpenStruct.new(nth: 'ninth',    unique_gift: 'nine Ladies Dancing'),
        10 => OpenStruct.new(nth: 'tenth',    unique_gift: 'ten Lords-a-Leaping'),
        11 => OpenStruct.new(nth: 'eleventh', unique_gift: 'eleven Pipers Piping'),
        12 => OpenStruct.new(nth: 'twelfth',  unique_gift: 'twelve Drummers Drumming'),
      }.freeze
    end
  end
end
