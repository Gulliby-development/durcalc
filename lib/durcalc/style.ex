defmodule Durcalc.Style do
  @moduledoc false

  def render("long", secs) do
    parts = Durcalc.Duration.parts(secs)
    words = Map.new(Durcalc.Names.words(), fn {letter, one, many} -> {letter, {one, many}} end)

    case Enum.reject(parts, fn {_letter, count} -> count == 0 end) do
      [] ->
        "0 " <> Durcalc.Report.plural(0, elem(words["s"], 0), elem(words["s"], 1))

      nonzero ->
        Enum.map_join(nonzero, " ", fn {letter, count} ->
          {one, many} = words[letter]
          "#{count} #{Durcalc.Report.plural(count, one, many)}"
        end)
    end
  end

  def render("clock", secs) do
    parts = Map.new(Durcalc.Duration.parts(secs))
    hours = parts["w"] * 168 + parts["d"] * 24 + parts["h"]

    [hours, parts["m"], parts["s"]]
    |> Enum.map_join(":", &pad/1)
  end

  def render("iso", secs) do
    parts = Map.new(Durcalc.Duration.parts(secs))
    days = parts["w"] * 7 + parts["d"]

    time =
      [{"H", parts["h"]}, {"M", parts["m"]}, {"S", parts["s"]}]
      |> Enum.reject(fn {_unit, count} -> count == 0 end)
      |> Enum.map_join(fn {unit, count} -> "#{count}#{unit}" end)

    day_text = if days == 0, do: "", else: "#{days}D"

    cond do
      days == 0 and time == "" -> "PT0S"
      time == "" -> "P" <> day_text
      true -> "P" <> day_text <> "T" <> time
    end
  end

  defp pad(value), do: value |> Integer.to_string() |> String.pad_leading(2, "0")
end
