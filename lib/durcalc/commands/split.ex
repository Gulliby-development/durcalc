defmodule Durcalc.Commands.Split do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    total = Enum.reduce(items, 0, fn item, acc -> acc + item.secs end)
    quotient = div(total, options.into)
    remainder = rem(total, options.into)

    output =
      1..options.into
      |> Enum.map_join(fn index ->
        part = quotient + if(index <= remainder, do: 1, else: 0)
        Durcalc.Report.render(options.style, part) <> "\n"
      end)

    {:ok, output}
  end
end
