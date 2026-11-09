defmodule Durcalc.LongTest do
  use Durcalc.RowCase

  rows([
    row(["fmt", "--style", "long"], "1s\n", 0, "1 second\n", ""),
    row(["fmt", "--style", "long"], "2s\n", 0, "2 seconds\n", ""),
    row(["fmt", "--style", "long"], "1m\n", 0, "1 minute\n", ""),
    row(["fmt", "--style", "long"], "61s\n", 0, "1 minute 1 second\n", ""),
    row(["fmt", "--style", "long"], "1h\n2h\n", 0, "1 hour\n2 hours\n", ""),
    row(["fmt", "--style", "long"], "1d1h1m1s\n", 0, "1 day 1 hour 1 minute 1 second\n", ""),
    row(["fmt", "--style", "long"], "2w3d4h5m6s\n", 0, "2 weeks 3 days 4 hours 5 minutes 6 seconds\n", ""),
    row(["fmt", "--style", "long"], "1w1s\n", 0, "1 week 1 second\n", ""),
    row(["fmt", "--style", "long"], "25h\n", 0, "1 day 1 hour\n", ""),
    row(["fmt", "--style", "long"], "0s\n1s\n", 0, "0 seconds\n1 second\n", "")
  ])

  totals([
    row(["sum", "--style", "long"], "30m\n30m\n", 0, "1 hour\n", ""),
    row(["sum", "--style", "long"], "1s\n", 0, "1 second\n", ""),
    row(["sum", "--style", "long"], "1w\n1w\n", 0, "2 weeks\n", ""),
    row(["sum", "--style", "long"], "0s\n", 0, "0 seconds\n", "")
  ])
end
