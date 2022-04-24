defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    IO.inspect(is_bitstring(calculator))
    # IO.inspect(calculator)
    # IO.inspect(input)

    pid =
      spawn_link(fn ->
        calculator.(input)
      end)

    %{pid: pid, input: input}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, _from, :normal} ->
        Map.get_and_update(results, input, fn val -> {val, :ok} end)

      {:EXIT, _from, _} ->
        Map.get_and_update(results, input, fn val -> {val, :error} end)

      _ ->
        nil
    end
    |> elem(1)
  end

  def reliability_check(calculator, inputs) do
    # Please implement the reliability_check/2 function
  end

  # def correctness_check(calculator, inputs) do
  #   # Please implement the correctness_check/2 function
  # end
end
