defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(value) do
      cond do
        is_bitstring(value) ->
          %StackUnderflowError{message: "stack underflow occurred, context: #{value}"}

        true ->
          %StackUnderflowError{}
      end
    end
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_]), do: raise(StackUnderflowError, "when dividing")
  def divide([0 | _]), do: raise(DivisionByZeroError)
  def divide([denominator, numerator | _]), do: numerator / denominator
end
