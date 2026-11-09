defmodule Durcalc.Commands.Fmt do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    output =
      items
      |> Enum.map(fn item -> Durcalc.Report.render(options.style, item.secs) <> "\n" end)
      |> Enum.join()

    {:ok, output}
  end
end
