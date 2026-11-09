defmodule Durcalc.IsoTest do
  use Durcalc.RowCase

  rows([
    row(["fmt", "--style", "iso"], "1s\n", 0, "PT1S\n", ""),
    row(["fmt", "--style", "iso"], "1m\n", 0, "PT1M\n", ""),
    row(["fmt", "--style", "iso"], "1h\n", 0, "PT1H\n", ""),
    row(["fmt", "--style", "iso"], "1h30m\n", 0, "PT1H30M\n", ""),
    row(["fmt", "--style", "iso"], "1d\n", 0, "P1D\n", ""),
    row(["fmt", "--style", "iso"], "1w\n", 0, "P7D\n", ""),
    row(["fmt", "--style", "iso"], "1d1s\n", 0, "P1DT1S\n", ""),
    row(["fmt", "--style", "iso"], "1w2d3h4m5s\n", 0, "P9DT3H4M5S\n", ""),
    row(["fmt", "--style", "iso"], "90s\n0s\n", 0, "PT1M30S\nPT0S\n", ""),
    row(["fmt", "--style", "iso"], "60s\n3600s\n", 0, "PT1M\nPT1H\n", "")
  ])

  totals([
    row(["sum", "--style", "iso"], "12h\n12h\n", 0, "P1D\n", ""),
    row(["sum", "--style", "iso"], "30s\n30s\n", 0, "PT1M\n", ""),
    row(["sum", "--style", "iso"], "2w\n", 0, "P14D\n", ""),
    row(["sum", "--style", "iso"], "0s\n", 0, "PT0S\n", "")
  ])
end
