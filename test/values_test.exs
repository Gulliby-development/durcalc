defmodule Durcalc.ValuesTest do
  use Durcalc.RowCase

  rows([
    row(["sum", "--style", "Compact"], "", 2, "", "durcalc: bad value for --style\n"),
    row(["fmt", "--style", ""], "", 2, "", "durcalc: bad value for --style\n"),
    row(["avg", "--mode", "round"], "", 2, "", "durcalc: bad value for --mode\n"),
    row(["round", "--to", "x", "--mode", "up"], "", 2, "", "durcalc: bad value for --to\n"),
    row(["round", "--to", "H"], "", 2, "", "durcalc: bad value for --to\n"),
    row(["split", "--into", "0"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", "101"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", "007"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", "1000"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", "-1"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", "2.5"], "", 2, "", "durcalc: bad value for --into\n"),
    row(["split", "--into", ""], "", 2, "", "durcalc: bad value for --into\n"),
    row(["round", "--to", "s"], "7s\n", 0, "7s\n", ""),
    row(["round", "--to", "w", "--mode", "nearest"], "2w3d\n2w4d\n", 0, "2w\n3w\n", ""),
    row(["avg", "--mode", "up", "--style", "secs"], "1s\n2s\n", 0, "2\n", "")
  ])
end
