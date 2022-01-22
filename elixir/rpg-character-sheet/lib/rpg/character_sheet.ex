defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  def ask_name() do
    ask("What is your character's name?")
  end

  def ask_class() do
    ask("What is your character's class?")
  end

  def ask_level() do
    ask("What is your character's level?") |> String.to_integer()
  end

  def run() do
    welcome()
    get_character() |> IO.inspect(label: "Your character")
  end

  defp ask(prompt), do: IO.gets("#{prompt}\n") |> String.trim()

  defp get_character do
    %{
      name: ask_name(),
      class: ask_class(),
      level: ask_level()
    }
  end
end
