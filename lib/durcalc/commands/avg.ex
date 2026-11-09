defmodule Durcalc.Commands.Avg do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    total = Enum.reduce(items, 0, fn item, acc -> acc + item.secs end)
    seconds = Durcalc.Duration.divide(total, length(items), options.mode)

    {:ok, Durcalc.Report.render(options.style, seconds) <> "\n"}
  end
end
