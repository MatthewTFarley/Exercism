defmodule Username do
  def sanitize(username) do
    Enum.reduce(username, [], fn char, acc ->
      acc ++
        case char do
          ?_ -> '_'
          ?ü -> 'ue'
          ?ä -> 'ae'
          ?ö -> 'oe'
          ?ß -> 'ss'
          char when char in ?a..?z -> [char]
          _ -> ''
        end
    end)
  end
end
