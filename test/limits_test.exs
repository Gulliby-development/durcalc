defmodule Durcalc.LimitsTest do
  use Durcalc.RowCase

  rows([
    row(["check"], "1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n", 0, "ok, 30 durations\n", ""),
    row(["check"], "1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n1s\n", 1, "", "durcalc: input is too long (max 30 lines)\n"),
    row(["check"], "# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n# c\n1s\n", 1, "", "durcalc: input is too long (max 30 lines)\n"),
    row(["check"], "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 1, "", "durcalc: no durations\n"),
    row(["check"], "bad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\nbad\n", 1, "", "durcalc: input is too long (max 30 lines)\n"),
    row(["check"], "165w2d9h46m39s\n", 0, "ok, 1 duration\n", ""),
    row(["check"], "165w2d9h46m40s\n", 1, "", "durcalc: line 1: duration too large 165w2d9h46m40s\n"),
    row(["check"], "165w3d\n", 1, "", "durcalc: line 1: duration too large 165w3d\n"),
    row(["check"], "999999w\n", 1, "", "durcalc: line 1: duration too large 999999w\n"),
    row(["sum", "--style", "secs"], "165w2d\n165w2d\n", 0, "199929600\n", ""),
    row(["avg", "--style", "secs"], "165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n165w2d\n", 0, "99964800\n", ""),
    row(["split", "--into", "100", "--style", "secs"], "100s\n", 0, "1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n1\n", "")
  ])
end
