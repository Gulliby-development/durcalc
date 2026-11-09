defmodule Durcalc.CLI do
  @moduledoc false

  @recognized_options ["--style", "--mode", "--to", "--into"]

  @spec run([String.t()], String.t()) :: {non_neg_integer(), String.t(), String.t()}
  def run([word | _], _text) when word in ["help", "-h", "--help"],
    do: {0, Durcalc.Registry.usage(), ""}

  def run(["--version" | _], _text), do: {0, Durcalc.Registry.version() <> "\n", ""}

  def run([], _text), do: {2, "", Durcalc.Registry.usage()}

  def run(args, text) do
    case validate(args) do
      {:ok, _name, options, command} ->
        case Durcalc.Input.read_items(text) do
          {:ok, items} ->
            case command.(options, items) do
              {:ok, output} -> {0, output, ""}
              {:error, %Durcalc.Failure{} = failure} -> failure_reply(failure)
            end

          {:error, %Durcalc.Failure{} = failure} ->
            failure_reply(failure)
        end

      {:error, %Durcalc.Failure{} = failure} ->
        failure_reply(failure)

      :help ->
        {0, Durcalc.Registry.usage(), ""}

      :version ->
        {0, Durcalc.Registry.version() <> "\n", ""}
    end
  end

  def reads_stdin?(args) do
    match?({:ok, _, _, _}, validate(args))
  end

  defp validate([word | _]) when word in ["help", "-h", "--help"], do: :help
  defp validate(["--version" | _]), do: :version
  defp validate([]), do: {:error, Durcalc.Failure.new(2, Durcalc.Registry.usage())}

  defp validate([name | args]) do
    case Durcalc.Registry.find(name) do
      nil ->
        {:error, cli_error("unknown command #{name}")}

      {allowed, command} ->
        case validate_options(name, allowed, args) do
          {:ok, options} -> {:ok, name, options, command}
          error -> error
        end
    end
  end

  defp validate_options(name, allowed, args) do
    initial = %{style: "compact", mode: Durcalc.Registry.default_mode(name), to: nil, into: nil}

    case parse_options(args, name, allowed, initial, MapSet.new()) do
      {:ok, options} ->
        cond do
          name == "round" and is_nil(options.to) -> {:error, cli_error("missing --to")}
          name == "split" and is_nil(options.into) -> {:error, cli_error("missing --into")}
          true -> {:ok, options}
        end

      error ->
        error
    end
  end

  defp parse_options([], _name, _allowed, options, _seen), do: {:ok, options}

  defp parse_options([word | rest], name, allowed, options, seen) do
    cond do
      not String.starts_with?(word, "-") or word == "" or word == "-" ->
        {:error, cli_error("unexpected argument #{word}")}

      word not in @recognized_options ->
        {:error, cli_error("unknown option #{word}")}

      word not in allowed ->
        {:error, cli_error("option #{word} is not valid for #{name}")}

      MapSet.member?(seen, word) ->
        {:error, cli_error("given twice: #{word}")}

      rest == [] ->
        {:error, cli_error("missing value for #{word}")}

      true ->
        [value | tail] = rest

        case put_value(word, value, options) do
          {:ok, updated} -> parse_options(tail, name, allowed, updated, MapSet.put(seen, word))
          :error -> {:error, cli_error("bad value for #{word}")}
        end
    end
  end

  defp put_value("--style", value, options) do
    if value in Durcalc.Registry.styles(), do: {:ok, %{options | style: value}}, else: :error
  end

  defp put_value("--mode", value, options) do
    if value in Durcalc.Registry.modes(), do: {:ok, %{options | mode: value}}, else: :error
  end

  defp put_value("--to", value, options) do
    if Enum.any?(Durcalc.Registry.units(), fn {unit, _} -> unit == value end),
      do: {:ok, %{options | to: value}},
      else: :error
  end

  defp put_value("--into", value, options) do
    if Regex.match?(~r/\A[1-9][0-9]{0,2}\z/, value) and String.to_integer(value) <= 100,
      do: {:ok, %{options | into: String.to_integer(value)}},
      else: :error
  end

  defp cli_error(message), do: Durcalc.Failure.new(2, message)

  defp failure_reply(%Durcalc.Failure{status: status, message: message}),
    do: {status, "", "durcalc: #{message}\n"}
end
