defmodule Durcalc.AvgTest do
  use Durcalc.RowCase

  rows([
    row(["avg"], "1h\n", 0, "1h\n", ""),
    row(["avg"], "1h\n2h\n", 0, "1h30m\n", ""),
    row(["avg"], "1s\n2s\n", 0, "1s\n", ""),
    row(["avg", "--mode", "up"], "1s\n2s\n", 0, "2s\n", ""),
    row(["avg", "--mode", "nearest"], "1s\n2s\n2s\n", 0, "2s\n", ""),
    row(["avg", "--style", "long"], "1h\n1h30m\n", 0, "1 hour 15 minutes\n", ""),
    row(["avg", "--style", "iso", "--mode", "nearest"], "1d\n2d\n2d\n", 0, "P1DT16H\n", ""),
    row(["avg", "--style", "secs"], "10s\n11s\n11s\n", 0, "10\n", ""),
    row(["avg", "--style", "clock"], "1h\n2h\n", 0, "01:30:00\n", ""),
    row(["avg", "--mode", "down"], "0s\n1s\n", 0, "0s\n", "")
  ])
end
