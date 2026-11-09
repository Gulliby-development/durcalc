defmodule Durcalc.FmtTest do
  use Durcalc.RowCase

  rows([
    row(["fmt"], "1s\n", 0, "1s\n", ""),
    row(["fmt"], "60s\n3600s\n86400s\n604800s\n", 0, "1m\n1h\n1d\n1w\n", ""),
    row(["fmt"], "100s\n1000s\n", 0, "1m40s\n16m40s\n", ""),
    row(["fmt", "--style", "compact"], "0s\n0d\n", 0, "0s\n0s\n", ""),
    row(["fmt", "--style", "secs"], "1h\n1m1s\n", 0, "3600\n61\n", ""),
    row(["fmt"], "# skipped\n2h\n\n3h\n", 0, "2h\n3h\n", ""),
    row(["fmt", "--style", "secs"], "2w\n", 0, "1209600\n", ""),
    row(["fmt"], "1d1s\n1w1h\n", 0, "1d1s\n1w1h\n", "")
  ])
end
