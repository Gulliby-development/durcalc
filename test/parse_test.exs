defmodule Durcalc.ParseTest do
  use Durcalc.RowCase

  rows([
    row(["sum"], "0s\n", 0, "0s\n", ""),
    row(["sum"], "0w\n", 0, "0s\n", ""),
    row(["sum"], "1s\n", 0, "1s\n", ""),
    row(["sum"], "59s\n", 0, "59s\n", ""),
    row(["sum"], "60s\n", 0, "1m\n", ""),
    row(["sum"], "90m\n", 0, "1h30m\n", ""),
    row(["sum"], "25h\n", 0, "1d1h\n", ""),
    row(["sum"], "8d\n", 0, "1w1d\n", ""),
    row(["sum"], "1w1d1h1m1s\n", 0, "1w1d1h1m1s\n", ""),
    row(["sum"], "999999s\n", 0, "1w4d13h46m39s\n", ""),
    row(["sum"], "0w0d0h0m5s\n", 0, "5s\n", ""),
    row(["sum"], "2d3h\n", 0, "2d3h\n", ""),
    row(["sum"], "1w1s\n", 0, "1w1s\n", ""),
    row(["sum", "--style", "secs"], "1w1d1h1m1s\n", 0, "694861\n", ""),
    row(["check"], "01s\n", 1, "", "durcalc: line 1: bad duration 01s\n"),
    row(["check"], "00s\n", 1, "", "durcalc: line 1: bad duration 00s\n"),
    row(["check"], "1m1h\n", 1, "", "durcalc: line 1: bad duration 1m1h\n"),
    row(["check"], "1h1h\n", 1, "", "durcalc: line 1: bad duration 1h1h\n"),
    row(["check"], "1\n", 1, "", "durcalc: line 1: bad duration 1\n"),
    row(["check"], "h\n", 1, "", "durcalc: line 1: bad duration h\n"),
    row(["check"], "1H\n", 1, "", "durcalc: line 1: bad duration 1H\n"),
    row(["check"], "+1h\n", 1, "", "durcalc: line 1: bad duration +1h\n"),
    row(["check"], "-1h\n", 1, "", "durcalc: line 1: bad duration -1h\n"),
    row(["check"], "1.5h\n", 1, "", "durcalc: line 1: bad duration 1.5h\n"),
    row(["check"], "1h,2m\n", 1, "", "durcalc: line 1: bad duration 1h,2m\n"),
    row(["check"], "1000000s\n", 1, "", "durcalc: line 1: bad duration 1000000s\n"),
    row(["check"], "1hh\n", 1, "", "durcalc: line 1: bad duration 1hh\n"),
    row(["check"], "1ms\n", 1, "", "durcalc: line 1: bad duration 1ms\n"),
    row(["check"], "1h30\n", 1, "", "durcalc: line 1: bad duration 1h30\n"),
    row(["check"], "5h 5m\n", 1, "", "durcalc: line 1: expected 1 duration\n"),
    row(["check"], "1d1w\n", 1, "", "durcalc: line 1: bad duration 1d1w\n")
  ])
end
