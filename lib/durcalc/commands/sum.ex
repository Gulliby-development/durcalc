defmodule Durcalc.Commands.Sum do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    total = Enum.reduce(items, 0, fn item, acc -> acc + item.secs end)
    {:ok, Durcalc.Report.render(options.style, total) <> "\n"}
  end
end
