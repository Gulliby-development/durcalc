defmodule Durcalc.SumTest do
  use Durcalc.RowCase

  rows([
    row(["sum"], "1h\n", 0, "1h\n", ""),
    row(["sum"], "1h\n1h\n", 0, "2h\n", ""),
    row(["sum"], "30m\n45m\n15m\n", 0, "1h30m\n", ""),
    row(["sum"], "1d\n23h59m60s\n", 0, "2d\n", ""),
    row(["sum", "--style", "secs"], "1h\n30m\n", 0, "5400\n", ""),
    row(["sum", "--style", "compact"], "1w\n1w\n1d\n", 0, "2w1d\n", ""),
    row(["sum"], "59s\n1s\n", 0, "1m\n", ""),
    row(["sum", "--style", "secs"], "0s\n", 0, "0\n", ""),
    row(["sum"], "# a\n1m\n# b\n1m\n", 0, "2m\n", "")
  ])
end
