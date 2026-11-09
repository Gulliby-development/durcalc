defmodule Durcalc.EdgesTest do
  use Durcalc.RowCase

  rows([
    row(["sum"], "0s\n0m\n", 0, "0s\n", ""),
    row(["check"], "# nothing\n", 1, "", "durcalc: no durations\n"),
    row(["sum", "--style", "secs"], "1w\n1d\n1h\n1m\n1s\n", 0, "694861\n", ""),
    row(["check"], "0s\n", 0, "ok, 1 duration\n", ""),
    row(["fmt"], "0s\n", 0, "0s\n", ""),
    row(["fmt", "--style", "long"], "0s\n", 0, "0 seconds\n", ""),
    row(["fmt", "--style", "clock"], "0s\n", 0, "00:00:00\n", ""),
    row(["fmt", "--style", "iso"], "0s\n", 0, "PT0S\n", ""),
    row(["round", "--to", "m"], "0s\n29s\n30s\n", 0, "0s\n0s\n1m\n", ""),
    row(["avg"], "1s\n2s\n", 0, "1s\n", ""),
    row(["avg", "--mode", "nearest"], "1s\n2s\n", 0, "2s\n", ""),
    row(["avg", "--mode", "up"], "0s\n0s\n1s\n", 0, "1s\n", ""),
    row(["diff"], "1h\n", 0, "", ""),
    row(["diff", "--style", "secs"], "1s\n1s\n", 0, "0\n", ""),
    row(["split", "--into", "1"], "5m\n", 0, "5m\n", ""),
    row(["split", "--into", "5"], "3s\n", 0, "1s\n1s\n1s\n0s\n0s\n", "")
  ])
end
