defmodule Lasagna do
  @expected_minutes_in_oven 40

  def expected_minutes_in_oven do
    @expected_minutes_in_oven
  end

  def remaining_minutes_in_oven(minutes) do
    expected_minutes_in_oven() - minutes
  end

  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  def total_time_in_minutes(layers, minutes) do
    preparation_time_in_minutes(layers) + minutes
  end

  def alarm do
    "Ding!"
  end
end
