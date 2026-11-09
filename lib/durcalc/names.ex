defmodule Durcalc.Names do
  @moduledoc false

  # The English words of the units, for the `long` style: {letter, singular, plural}.
  @words [
    {"w", "week", "weeks"},
    {"d", "day", "days"},
    {"h", "hour", "hours"},
    {"m", "minute", "minutes"},
    {"s", "second", "seconds"}
  ]

  def words, do: @words

  def word(letter, count) do
    {^letter, one, many} = List.keyfind(@words, letter, 0)
    if count == 1, do: one, else: many
  end
end
