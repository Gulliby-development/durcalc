defmodule Durcalc.Input do
  @moduledoc false

  def read_items(text) when is_binary(text) do
    lines = physical_lines(text)

    if length(lines) > Durcalc.Registry.max_lines() do
      {:error, Durcalc.Failure.new(1, "input is too long (max 30 lines)")}
    else
      parse_lines(lines)
    end
  end

  defp physical_lines(""), do: []

  defp physical_lines(text) do
    lines = String.split(text, "\n", trim: false)
    if String.ends_with?(text, "\n"), do: Enum.drop(lines, -1), else: lines
  end

  defp parse_lines(lines) do
    lines
    |> Enum.with_index(1)
    |> Enum.reduce_while({:ok, []}, fn {line, number}, {:ok, items} ->
      line = strip_terminal_cr(line)
      words = String.split(line, ~r/[ \t]+/, trim: true)

      case words do
        [] -> {:cont, {:ok, items}}
        [first | _] when binary_part(first, 0, 1) == "#" -> {:cont, {:ok, items}}
        [word] -> add_item(word, number, items)
        _ -> {:halt, {:error, Durcalc.Failure.new(1, "line #{number}: expected 1 duration")}}
      end
    end)
    |> case do
      {:ok, []} -> {:error, Durcalc.Failure.new(1, "no durations")}
      {:ok, items} -> {:ok, Enum.reverse(items)}
      error -> error
    end
  end

  defp strip_terminal_cr(line) do
    if String.ends_with?(line, "\r"), do: binary_part(line, 0, byte_size(line) - 1), else: line
  end

  defp add_item(word, number, items) do
    case Durcalc.Duration.parse(word) do
      {:ok, secs} ->
        {:cont, {:ok, [%{line: number, word: word, secs: secs} | items]}}

      {:error, failure} ->
        {:halt, {:error, Durcalc.Failure.new(failure.status, "line #{number}: #{failure.message}")}}
    end
  end
end
