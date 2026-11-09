defmodule Durcalc.ClockTest do
  use Durcalc.RowCase

  rows([
    row(["fmt", "--style", "clock"], "1s\n", 0, "00:00:01\n", ""),
    row(["fmt", "--style", "clock"], "59s\n60s\n", 0, "00:00:59\n00:01:00\n", ""),
    row(["fmt", "--style", "clock"], "1h\n", 0, "01:00:00\n", ""),
    row(["fmt", "--style", "clock"], "9h9m9s\n", 0, "09:09:09\n", ""),
    row(["fmt", "--style", "clock"], "1d\n", 0, "24:00:00\n", ""),
    row(["fmt", "--style", "clock"], "4d4h\n", 0, "100:00:00\n", ""),
    row(["fmt", "--style", "clock"], "1w\n", 0, "168:00:00\n", ""),
    row(["fmt", "--style", "clock"], "99h59m59s\n", 0, "99:59:59\n", ""),
    row(["fmt", "--style", "clock"], "100h\n", 0, "100:00:00\n", ""),
    row(["fmt", "--style", "clock"], "165w2d\n", 0, "27768:00:00\n", "")
  ])

  totals([
    row(["sum", "--style", "clock"], "1h30m\n1h30m\n", 0, "03:00:00\n", ""),
    row(["sum", "--style", "clock"], "30s\n30s\n", 0, "00:01:00\n", ""),
    row(["sum", "--style", "clock"], "4d\n5d\n", 0, "216:00:00\n", ""),
    row(["sum", "--style", "clock"], "0s\n", 0, "00:00:00\n", "")
  ])
end
