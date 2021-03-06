defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    {:ok, operation.(stack)}
  rescue
    _ -> :error
  end

  def calculate_verbose(stack, operation) do
    {:ok, operation.(stack)}
  rescue
    error -> {:error, error.message}
  end
end
