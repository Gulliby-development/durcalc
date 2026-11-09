defmodule Durcalc.Registry do
  @moduledoc false

  # The version, the limits, the usage text, the units, the styles, the modes and the command
  # table.
  #
  # Options are a map `%{style: String.t(), mode: String.t(), to: String.t() | nil,
  # into: pos_integer | nil}`: the value of `--style` ("compact" when absent), of `--mode` (the
  # default of the command when absent, see `default_mode/1`), of `--to` (a unit letter, nil when
  # absent) and of `--into` (nil when absent).
  # An item is one duration of the input, a map `%{line: pos_integer, word: String.t(),
  # secs: non_neg_integer}`: the line number (counted from 1, skipped lines included), the word as
  # written and its value in seconds.
  # A command is a function `run(options, items)` that returns `{:ok, output}` with the whole
  # standard output text or `{:error, %Durcalc.Failure{}}`.

  @type options :: %{
          style: String.t(),
          mode: String.t(),
          to: String.t() | nil,
          into: pos_integer | nil
        }
  @type item :: %{line: pos_integer, word: String.t(), secs: non_neg_integer}
  @type command_result :: {:ok, String.t()} | {:error, Durcalc.Failure.t()}

  def version, do: "durcalc 0.1.0"
  def max_lines, do: 30
  def max_total, do: 99_999_999

  def units, do: [{"w", 604_800}, {"d", 86_400}, {"h", 3_600}, {"m", 60}, {"s", 1}]
  def styles, do: ["compact", "long", "clock", "iso", "secs"]
  def modes, do: ["down", "up", "nearest"]

  def usage do
    "usage: durcalc check\n" <>
      "       durcalc sum [--style STYLE]\n" <>
      "       durcalc fmt [--style STYLE]\n" <>
      "       durcalc round --to UNIT [--mode MODE]\n" <>
      "       durcalc avg [--style STYLE] [--mode MODE]\n" <>
      "       durcalc diff [--style STYLE]\n" <>
      "       durcalc split --into N [--style STYLE]\n"
  end

  def default_mode("round"), do: "nearest"
  def default_mode(_name), do: "down"

  def commands do
    [
      {"check", [], &Durcalc.Commands.Check.run/2},
      {"sum", ["--style"], &Durcalc.Commands.Sum.run/2},
      {"fmt", ["--style"], &Durcalc.Commands.Fmt.run/2},
      {"round", ["--to", "--mode"], &Durcalc.Commands.Round.run/2},
      {"avg", ["--style", "--mode"], &Durcalc.Commands.Avg.run/2},
      {"diff", ["--style"], &Durcalc.Commands.Diff.run/2},
      {"split", ["--into", "--style"], &Durcalc.Commands.Split.run/2}
    ]
  end

  def find(name) do
    case List.keyfind(commands(), name, 0) do
      {^name, allowed, run} -> {allowed, run}
      nil -> nil
    end
  end
end
