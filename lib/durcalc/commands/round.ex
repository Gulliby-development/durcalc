defmodule Durcalc.Commands.Round do
  @moduledoc false

  @spec run(Durcalc.Registry.options(), [Durcalc.Registry.item()]) :: Durcalc.Registry.command_result()
  def run(options, items) do
    {unit, factor} = List.keyfind(Durcalc.Registry.units(), options.to, 0)
    true = unit == options.to

    items
    |> Enum.reduce_while({:ok, []}, fn item, {:ok, output} ->
      rounded = Durcalc.Duration.divide(item.secs, factor, options.mode) * factor

      if rounded > Durcalc.Registry.max_total() do
        failure =
          Durcalc.Failure.new(
            1,
            "line #{item.line}: rounded duration too large #{item.word}"
          )

        {:halt, {:error, failure}}
      else
        {:cont, {:ok, [Durcalc.Duration.compact(rounded) <> "\n" | output]}}
      end
    end)
    |> case do
      {:ok, output} -> {:ok, output |> Enum.reverse() |> Enum.join()}
      {:error, failure} -> {:error, failure}
    end
  end
end
