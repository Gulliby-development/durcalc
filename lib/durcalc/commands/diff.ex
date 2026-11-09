defmodule Durcalc.Commands.Diff do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    output =
      items
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map_join(fn [previous, next] ->
        difference = next.secs - previous.secs
        sign = sign(difference)
        magnitude = abs(difference)

        sign <> Durcalc.Report.render(options.style, magnitude) <> "\n"
      end)

    {:ok, output}
  end

  defp sign(difference) when difference > 0, do: "+"
  defp sign(difference) when difference < 0, do: "-"
  defp sign(_difference), do: ""
end
