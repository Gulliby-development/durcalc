defmodule Durcalc.RoundTest do
  use Durcalc.RowCase

  rows([
    row(["round", "--to", "h"], "1h29m59s\n", 0, "1h\n", ""),
    row(["round", "--to", "h"], "1h30m\n", 0, "2h\n", ""),
    row(["round", "--to", "h", "--mode", "down"], "1h59m59s\n", 0, "1h\n", ""),
    row(["round", "--to", "h", "--mode", "up"], "1h1s\n", 0, "2h\n", ""),
    row(["round", "--to", "h", "--mode", "up"], "2h\n", 0, "2h\n", ""),
    row(["round", "--to", "m", "--mode", "nearest"], "29s\n30s\n89s\n90s\n", 0, "0s\n1m\n1m\n2m\n", ""),
    row(["round", "--to", "d", "--mode", "down"], "47h59m\n", 0, "1d\n", ""),
    row(["round", "--to", "w"], "3d12h\n3d11h59m59s\n1w\n", 0, "1w\n0s\n1w\n", ""),
    row(["round", "--to", "s"], "1m1s\n", 0, "1m1s\n", ""),
    row(["round", "--to", "d", "--mode", "up"], "0s\n1s\n", 0, "0s\n1d\n", "")
  ])

  refusals([
    row(["round", "--to", "w", "--mode", "up"], "165w2d\n", 1, "", "durcalc: line 1: rounded duration too large 165w2d\n"),
    row(["round", "--to", "w", "--mode", "up"], "1w\n165w1s\n2w\n", 1, "", "durcalc: line 2: rounded duration too large 165w1s\n"),
    row(["round", "--to", "w"], "165w2d\n", 0, "165w\n", ""),
    row(["round", "--to", "d", "--mode", "up"], "1157d\n", 0, "165w2d\n", ""),
    row(["round", "--to", "d", "--mode", "up"], "1157d1s\n", 1, "", "durcalc: line 1: rounded duration too large 1157d1s\n")
  ])
end
