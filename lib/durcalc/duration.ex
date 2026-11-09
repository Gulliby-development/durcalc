defmodule Durcalc.Duration do
  @moduledoc false

  @piece ~r/(0|[1-9][0-9]{0,5})([wdhms])/

  def parse(word) when is_binary(word) do
    pieces = Regex.scan(@piece, word)

    if valid_pieces?(pieces, word) do
      seconds =
        Enum.reduce(pieces, 0, fn [_, number, unit], total ->
          {^unit, factor} = List.keyfind(Durcalc.Registry.units(), unit, 0)
          total + String.to_integer(number) * factor
        end)

      if seconds <= Durcalc.Registry.max_total() do
        {:ok, seconds}
      else
        {:error, Durcalc.Failure.new(1, "duration too large #{word}")}
      end
    else
      {:error, Durcalc.Failure.new(1, "bad duration #{word}")}
    end
  end

  def parts(secs) when is_integer(secs) and secs >= 0 do
    {parts, _remaining} =
      Enum.map_reduce(Durcalc.Registry.units(), secs, fn {letter, factor}, remaining ->
        {div(remaining, factor), rem(remaining, factor)}
        |> then(fn {count, rest} -> {{letter, count}, rest} end)
      end)

    parts
  end

  def compact(secs) when is_integer(secs) and secs >= 0 do
    case Enum.reject(parts(secs), fn {_unit, count} -> count == 0 end) do
      [] -> "0s"
      nonzero -> Enum.map_join(nonzero, fn {unit, count} -> "#{count}#{unit}" end)
    end
  end

  def divide(num, den, mode)
      when is_integer(num) and num >= 0 and is_integer(den) and den > 0 do
    quotient = div(num, den)
    remainder = rem(num, den)

    case mode do
      "down" -> quotient
      "up" -> if(remainder == 0, do: quotient, else: quotient + 1)
      "nearest" -> if(remainder * 2 >= den, do: quotient + 1, else: quotient)
    end
  end

  defp valid_pieces?(pieces, word) do
    joined = Enum.map_join(pieces, fn [whole, _, _] -> whole end)

    ordered? =
      pieces
      |> Enum.map(fn [_, _, unit] -> unit_index(unit) end)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.all?(fn [left, right] -> left < right end)

    pieces != [] and joined == word and ordered?
  end

  defp unit_index(unit) do
    Enum.find_index(Durcalc.Registry.units(), fn {letter, _factor} -> letter == unit end)
  end
end
