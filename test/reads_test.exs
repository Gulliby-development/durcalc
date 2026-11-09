defmodule Durcalc.ReadsTest do
  use Durcalc.RowCase

  rows([
    reads(["check"], true),
    reads(["sum"], true),
    reads(["fmt"], true),
    reads(["round", "--to", "h"], true),
    reads(["avg"], true),
    reads(["diff"], true),
    reads(["split", "--into", "2"], true),
    reads(["sum", "--style", "long"], true),
    reads(["help"], false),
    reads(["--help"], false),
    reads(["--version"], false),
    reads([], false),
    reads(["frob"], false),
    reads(["sum", "extra"], false),
    reads(["round"], false),
    reads(["split"], false),
    reads(["check", "--style", "long"], false),
    reads(["sum", "--style"], false),
    reads(["sum", "--style", "bad"], false),
    reads(["avg", "--mode", "up", "--style", "iso"], true),
    reads(["round", "--mode", "up"], false),
    reads(["split", "--into", "101"], false),
    reads(["sum", "--style", "iso", "--style", "iso"], false),
    reads(["fmt", "-"], false),
    reads(["diff", "--to", "h"], false)
  ])
end
