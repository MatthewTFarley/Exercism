defmodule TopSecret do
  def to_ast(string) do
    case Code.string_to_quoted(string) do
      {:ok, ast} -> ast
      {:error, _} -> nil
    end
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      # Public function with guard clause
      {:def, _, [{:when, _, [{name, _, args} | _]} | _]} ->
        {name, args, acc}

      # Private function with guard clause
      {:defp, _, [{:when, _, [{name, _, args} | _]} | _]} ->
        {name, args, acc}

      # Public function without guard clause
      {:def, _, [{name, _, args} | _]} ->
        {name, args, acc}

      # Private function without guard clause
      {:defp, _, [{name, _, args} | _]} ->
        {name, args, acc}

      _ ->
        {ast, acc}
    end
    |> case do
      {name, args, acc} -> {ast, prepend_to_acc(name, args, acc)}
      unchanged -> unchanged
    end
  end

  def decode_secret_message(string) do
    string
    |> TopSecret.to_ast()
    |> case do
      # Single-public-function module
      {:defmodule, _, [_, [do: func_ast = {:def, _, _}]]} ->
        [func_ast]

      # Single-private-function module
      {:defmodule, _, [_, [do: func_ast = {:defp, _, _}]]} ->
        [func_ast]

      # Multi-function module
      {:defmodule, _, [_, [do: {:__block__, _, func_asts}]]} ->
        func_asts

      # top level multi-public function
      {:__block__, _, func_asts = [{:def, _, _} | _]} ->
        func_asts

      # top level multi-private function
      {:__block__, _, func_asts = [{:defp, _, _} | _]} ->
        func_asts

      # multi-module block
      {:__block__, _, module_asts = [{:defmodule, _, _} | _]} ->
        Enum.reduce(module_asts, [], fn module_ast, memo ->
          case module_ast do
            # Single-public-function module
            {:defmodule, _, [_, [do: func_ast = {:def, _, _}]]} ->
              memo ++ [func_ast]

            # Single-private-function module
            {:defmodule, _, [_, [do: func_ast = {:defp, _, _}]]} ->
              memo ++ [func_ast]

            # Multi-function module
            {:defmodule, _, [_, [do: {:__block__, _, func_asts}]]} ->
              memo ++ func_asts
          end
        end)

      unchanged ->
        unchanged
    end
    |> Enum.reverse()
    |> Enum.reduce([], &(TopSecret.decode_secret_message_part(&1, &2) |> elem(1)))
    |> Enum.join()
  end

  defp prepend_to_acc(name, args, acc) do
    cond do
      is_nil(args) || Enum.empty?(args) ->
        ""

      true ->
        name
        |> to_string()
        |> String.to_charlist()
        |> Enum.take(Enum.count(args))
        |> List.to_string()
    end
    |> then(&[&1 | acc])
  end
end
