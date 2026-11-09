defmodule Durcalc.OptionsTest do
  use Durcalc.RowCase

  rows([
    row(["sum", "extra"], "", 2, "", "durcalc: unexpected argument extra\n"),
    row(["sum", "-"], "", 2, "", "durcalc: unexpected argument -\n"),
    row(["sum", ""], "", 2, "", "durcalc: unexpected argument \n"),
    row(["sum", "--bogus"], "", 2, "", "durcalc: unknown option --bogus\n"),
    row(["check", "--style", "long"], "", 2, "", "durcalc: option --style is not valid for check\n"),
    row(["sum", "--to", "h"], "", 2, "", "durcalc: option --to is not valid for sum\n"),
    row(["sum", "--style", "long", "--style", "long"], "", 2, "", "durcalc: given twice: --style\n"),
    row(["sum", "--style"], "", 2, "", "durcalc: missing value for --style\n"),
    row(["sum", "-x", "--style"], "", 2, "", "durcalc: unknown option -x\n"),
    row(["check", "--style"], "", 2, "", "durcalc: option --style is not valid for check\n"),
    row(["sum", "--style", "x", "--bogus"], "", 2, "", "durcalc: bad value for --style\n"),
    row(["fmt", "--mode", "up"], "", 2, "", "durcalc: option --mode is not valid for fmt\n"),
    row(["avg", "--to", "h"], "", 2, "", "durcalc: option --to is not valid for avg\n"),
    row(["round", "--to", "d", "--mode", "up"], "1d1s\n2d\n", 0, "2d\n2d\n", ""),
    row(["round", "--mode", "down", "--to", "m"], "59s\n1m59s\n", 0, "0s\n1m\n", ""),
    row(["fmt", "--style", "iso"], "45s\n", 0, "PT45S\n", ""),
    row(["split", "--style", "secs", "--into", "2"], "5s\n", 0, "3\n2\n", ""),
    row(["avg", "--mode", "up", "--style", "long"], "1s\n2s\n", 0, "2 seconds\n", ""),
    row(["diff", "--style", "secs"], "1m\n2m\n", 0, "+60\n", "")
  ])
end
