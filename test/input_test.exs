defmodule Durcalc.InputTest do
  use Durcalc.RowCase

  rows([
    row(["check"], "", 1, "", "durcalc: no durations\n"),
    row(["check"], "\n", 1, "", "durcalc: no durations\n"),
    row(["check"], "# only\n\n   \n", 1, "", "durcalc: no durations\n"),
    row(["check"], "1h", 0, "ok, 1 duration\n", ""),
    row(["check"], "1h\n2h", 0, "ok, 2 durations\n", ""),
    row(["check"], "1h\r\n2h\r\n", 0, "ok, 2 durations\n", ""),
    row(["check"], "1h\n1h 2m\n", 1, "", "durcalc: line 2: expected 1 duration\n"),
    row(["check"], "\n# c\n1h\n30 m\n", 1, "", "durcalc: line 4: expected 1 duration\n"),
    row(["check"], "  1h  \n\t2h\t\n", 0, "ok, 2 durations\n", ""),
    row(["check"], "1h\n   # note\n2h\n#3h\n", 0, "ok, 2 durations\n", ""),
    row(["check"], "1h\nfrob\n2h\nbad\n", 1, "", "durcalc: line 2: bad duration frob\n"),
    row(["check"], "1h\nx\n1h 2m\n", 1, "", "durcalc: line 2: bad duration x\n"),
    row(["check"], "1h\n1h #c\n", 1, "", "durcalc: line 2: expected 1 duration\n"),
    row(["check"], "1h\n\n\n1x\n", 1, "", "durcalc: line 4: bad duration 1x\n"),
    row(["sum"], "1h\n\t\n", 0, "1h\n", "")
  ])
end
