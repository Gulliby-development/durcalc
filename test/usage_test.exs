defmodule Durcalc.UsageTest do
  use Durcalc.RowCase

  rows([
    row(["help"], "", 0, "usage: durcalc check\n       durcalc sum [--style STYLE]\n       durcalc fmt [--style STYLE]\n       durcalc round --to UNIT [--mode MODE]\n       durcalc avg [--style STYLE] [--mode MODE]\n       durcalc diff [--style STYLE]\n       durcalc split --into N [--style STYLE]\n", ""),
    row(["-h"], "", 0, "usage: durcalc check\n       durcalc sum [--style STYLE]\n       durcalc fmt [--style STYLE]\n       durcalc round --to UNIT [--mode MODE]\n       durcalc avg [--style STYLE] [--mode MODE]\n       durcalc diff [--style STYLE]\n       durcalc split --into N [--style STYLE]\n", ""),
    row(["--help", "--bogus"], "", 0, "usage: durcalc check\n       durcalc sum [--style STYLE]\n       durcalc fmt [--style STYLE]\n       durcalc round --to UNIT [--mode MODE]\n       durcalc avg [--style STYLE] [--mode MODE]\n       durcalc diff [--style STYLE]\n       durcalc split --into N [--style STYLE]\n", ""),
    row([], "", 2, "", "usage: durcalc check\n       durcalc sum [--style STYLE]\n       durcalc fmt [--style STYLE]\n       durcalc round --to UNIT [--mode MODE]\n       durcalc avg [--style STYLE] [--mode MODE]\n       durcalc diff [--style STYLE]\n       durcalc split --into N [--style STYLE]\n"),
    row(["--version"], "", 0, "durcalc 0.1.0\n", ""),
    row(["--version", "x"], "", 0, "durcalc 0.1.0\n", ""),
    row(["frob"], "", 2, "", "durcalc: unknown command frob\n"),
    row([""], "", 2, "", "durcalc: unknown command \n"),
    row(["Check"], "", 2, "", "durcalc: unknown command Check\n"),
    row(["-H"], "", 2, "", "durcalc: unknown command -H\n")
  ])
end
