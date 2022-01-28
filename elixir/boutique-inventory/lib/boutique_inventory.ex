defmodule BoutiqueInventory do
  def sort_by_price([]), do: []

  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price([]), do: []

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1.price))
  end

  def increase_quantity(item, count) do
    Enum.into(item.quantity_by_size, %{}, fn {size, quantity} -> {size, quantity + count} end)
    |> then(fn new_sizes -> %{item | quantity_by_size: new_sizes} end)
  end

  def total_quantity(item) do
    Enum.reduce(
      item.quantity_by_size,
      0,
      fn {_size, value}, acc -> acc + value end
    )
  end
end
