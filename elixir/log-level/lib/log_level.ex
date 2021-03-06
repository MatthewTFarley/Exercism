defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 && not legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 && not legacy? -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label == :error -> :ops
      label == :fatal -> :ops
      label == :unknown && legacy? -> :dev1
      label == :unknown && not legacy? -> :dev2
      true -> nil
    end
  end
end
