defmodule LanguageList do
  defdelegate remove(list), to: Kernel, as: :tl
  defdelegate first(list), to: Kernel, as: :hd
  defdelegate count(list), to: Kernel, as: :length
  def new, do: []
  def add(list, language), do: [language | list]
  def exciting_list?(list), do: "Elixir" in list
end
