defmodule Durcalc.Commands.Check do
  @moduledoc false

  def run(_options, items) do
    count = length(items)
    noun = Durcalc.Report.plural(count, "duration", "durations")
    {:ok, "ok, #{count} #{noun}\n"}
  end
end
