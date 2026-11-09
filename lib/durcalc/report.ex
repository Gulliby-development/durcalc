defmodule Durcalc.Report do
  @moduledoc false

  def plural(count, one, many) when is_integer(count) do
    if count == 1, do: one, else: many
  end

  def render("compact", secs), do: Durcalc.Duration.compact(secs)
  def render("secs", secs) when is_integer(secs), do: Integer.to_string(secs)
  def render(style, secs), do: Durcalc.Style.render(style, secs)
end
