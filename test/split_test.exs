defmodule Durcalc.SplitTest do
  use Durcalc.RowCase

  rows([
    row(["split", "--into", "1"], "1h\n", 0, "1h\n", ""),
    row(["split", "--into", "2"], "1h\n", 0, "30m\n30m\n", ""),
    row(["split", "--into", "3"], "1h\n", 0, "20m\n20m\n20m\n", ""),
    row(["split", "--into", "3"], "10s\n", 0, "4s\n3s\n3s\n", ""),
    row(["split", "--into", "4"], "5s\n", 0, "2s\n1s\n1s\n1s\n", ""),
    row(["split", "--into", "5"], "1s\n", 0, "1s\n0s\n0s\n0s\n0s\n", ""),
    row(["split", "--into", "2", "--style", "long"], "3s\n", 0, "2 seconds\n1 second\n", ""),
    row(["split", "--into", "2", "--style", "secs"], "1m\n1m1s\n", 0, "61\n60\n", ""),
    row(["split", "--into", "3", "--style", "clock"], "1h\n", 0, "00:20:00\n00:20:00\n00:20:00\n", ""),
    row(["split", "--into", "2", "--style", "iso"], "1d\n", 0, "PT12H\nPT12H\n", "")
  ])
end
