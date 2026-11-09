defmodule Durcalc.CliTest do
  use Durcalc.RowCase

  rows([
    row(["check"], "1h30m\n2d\n", 0, "ok, 2 durations\n", ""),
    row(["check"], "90s\n", 0, "ok, 1 duration\n", ""),
    row(["sum"], "# build times\n1h30m\n\n45m\n30s\n", 0, "2h15m30s\n", ""),
    row(["sum", "--style", "secs"], "1m\n2m\n3m\n", 0, "360\n", ""),
    row(["fmt"], "90s\n1d1h\n0s\n", 0, "1m30s\n1d1h\n0s\n", ""),
    row(["round", "--to", "h"], "1h29m\n1h30m\n5h59m\n", 0, "1h\n2h\n6h\n", ""),
    row(["fmt", "--style", "clock"], "26h\n5m\n", 0, "26:00:00\n00:05:00\n", ""),
    row(["fmt", "--style", "long"], "1w2d\n1s\n", 0, "1 week 2 days\n1 second\n", ""),
    row(["avg"], "1h\n2h\n4h\n", 0, "2h20m\n", ""),
    row(["diff"], "1h\n30m\n30m\n2h\n", 0, "-30m\n0s\n+1h30m\n", ""),
    row(["split", "--into", "3"], "10s\n", 0, "4s\n3s\n3s\n", ""),
    row(["split", "--into", "2", "--style", "long"], "1h\n1h1s\n", 0, "1 hour 1 second\n1 hour\n", "")
  ])
end
