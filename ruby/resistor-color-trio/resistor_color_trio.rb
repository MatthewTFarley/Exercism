# frozen_string_literal: true

class ResistorColorTrio
  attr_reader :color_trio

  def initialize(color_trio)
    @color_trio = color_trio
  end

  def label
    "Resistor value: #{value_part}"
  end

  private

  def value_part
    values
    .then { |(v1, v2, v3)| "#{v1}#{v2}#{'0' * v3.to_i}".to_i }
    .then do |number|
      case number
      when 0...1_000                then hundreds(number)
      when 1_000...1_000_000        then kilo(number)
      when 1_000_000..1_000_000_000 then mega(number)
      else                               giga(number)
      end
    end
  end

  def values
    color_trio.map do |color|
      COLOR_CODE[color].tap { |value| raise ArgumentError if value.nil? }
    end
  end

  def hundreds(number)
    number == 1 ? "#{number} ohm" : "#{number} ohms"
  end

  def kilo(number)
    "#{number / 1_000} kiloohms"
  end

  def mega(number)
    "#{number / 1_000_000} megaohms"
  end

  def giga(number)
    "#{number / 1_000_000_000} gigaohms"
  end

  COLOR_CODE = {
    'black' => 0,
    'brown' => 1,
    'red' => 2,
    'orange' => 3,
    'yellow' => 4,
    'green' => 5,
    'blue' => 6,
    'violet' => 7,
    'grey' => 8,
    'white' => 9,
  }.freeze
end
