defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(edible, eater)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(%LoafOfBread{}, character) do
      {nil, %Character{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(mana_potion = %ManaPotion{}, character) do
      {%EmptyBottle{}, %Character{character | mana: character.mana + mana_potion.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(%Poison{}, character) do
      {%EmptyBottle{}, %Character{character | health: 0}}
    end
  end
end
