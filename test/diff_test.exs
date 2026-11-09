defmodule Durcalc.DiffTest do
  use Durcalc.RowCase

  rows([
    row(["diff"], "1h\n", 0, "", ""),
    row(["diff"], "1h\n2h\n", 0, "+1h\n", ""),
    row(["diff"], "2h\n1h\n", 0, "-1h\n", ""),
    row(["diff"], "1h\n1h\n", 0, "0s\n", ""),
    row(["diff"], "1h\n90m\n1h\n1h\n", 0, "+30m\n-30m\n0s\n", ""),
    row(["diff", "--style", "long"], "1m\n1h\n", 0, "+59 minutes\n", ""),
    row(["diff", "--style", "secs"], "5s\n2s\n9s\n", 0, "-3\n+7\n", ""),
    row(["diff", "--style", "iso"], "1d\n2d1h\n0s\n", 0, "+P1DT1H\n-P2DT1H\n", ""),
    row(["diff", "--style", "clock"], "1h\n26h\n", 0, "+25:00:00\n", ""),
    row(["diff"], "# c\n1m\n\n2m\n5m\n", 0, "+1m\n+3m\n", "")
  ])
end
