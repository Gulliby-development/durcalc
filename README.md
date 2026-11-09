<p align="center"><img src="docs/logo.svg" width="96" alt="" /></p>

# durcalc

[![CI](https://github.com/Gulliby-development/durcalc/actions/workflows/ci.yml/badge.svg)](https://github.com/Gulliby-development/durcalc/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

durcalc is a small offline command-line tool for adding, formatting, rounding, averaging, comparing, and splitting lists of durations. It is for people working in a terminal, scripts, or CI—for example with build times, time sheets, or timeout lists. It uses only the Elixir standard library and integer arithmetic; it needs no network or clock.

It runs with Elixir 1.15 or newer on Windows, macOS, and Linux. The shell function used in the examples below is POSIX-shell syntax and assumes the repository directory as the current directory.

## Usage

Build the escript from the repository directory and run a command:

```sh
mix escript.build
escript durcalc COMMAND
```

Alternatively, run the entry point directly:

```sh
mix run -e 'Durcalc.main(["COMMAND"])'
```

Replace `COMMAND` with one of the commands below. Each command reads durations from standard input.

```text
usage: durcalc check
       durcalc sum [--style STYLE]
       durcalc fmt [--style STYLE]
       durcalc round --to UNIT [--mode MODE]
       durcalc avg [--style STYLE] [--mode MODE]
       durcalc diff [--style STYLE]
       durcalc split --into N [--style STYLE]
```

`sum`, `fmt`, and `diff` accept `--style`; `round` accepts `--to` and `--mode`; `avg` accepts `--style` and `--mode`; `split` accepts `--into` and `--style`; `check` accepts no options. Styles are `compact`, `long`, `clock`, `iso`, and `secs`. Modes are `down`, `up`, and `nearest`; units are `w`, `d`, `h`, `m`, and `s`. Style defaults to `compact`; mode defaults to `nearest` for `round` and `down` for `avg`.

`round` requires `--to UNIT`, and `split` requires `--into N`. N is a decimal whole number from 1 through 100, written with one to three digits and no leading zero. Option names and values are case-sensitive. There is no `--option=value` form: give each option and its value as separate words. Each option takes the next word as its value, even if that word begins with a hyphen. Repeating an option is an error. Command-line words are checked from left to right: an empty word, a lone `-`, or any word not starting with `-` is an unexpected argument; a hyphen-prefixed word that is not one of `--style`, `--mode`, `--to`, and `--into` is an unknown option.

As the first word, `help`, `-h`, or `--help` prints usage; `--version` prints the version. These special words ignore any following words and do not read standard input. With no command, usage is written to standard error. Other first words are unknown commands.

## Durations

Input is a list with one duration per line. Lines are separated by LF; a final line without LF still counts, while empty input contains no lines. One CR at the end of each line is removed. Lines containing only spaces and tabs, and lines whose first word begins with `#`, are skipped. On other lines, spaces and tabs at the ends are ignored and spaces or tabs separate words. Exactly one word must remain: comments are not permitted after a duration on the same line. Line numbers include skipped lines. At most 30 lines are allowed, including blank and comment lines.

A duration consists of one or more adjacent number-and-unit pieces, in descending unit order, with each unit used at most once:

- `w`: week, 604800 seconds
- `d`: day, 86400 seconds
- `h`: hour, 3600 seconds
- `m`: minute, 60 seconds
- `s`: second, 1 second

For example, `1h30m`, `2d3h`, and `90s` are valid. Unit letters are lowercase. A number is `0`, or one to six decimal digits without a leading zero or sign. The value is the sum of the pieces. Each duration may be at most 99999999 seconds, represented by `165w2d9h46m39s`; a syntactically valid larger value is rejected. For example, `165w2d9h46m40s` is too large. Invalid syntax includes a missing number or unit, repeated or out-of-order units, uppercase units, signs, decimal points, commas, and numbers without units.

## Styles

A style controls how a number of seconds is written. Compact and long styles show non-zero parts from largest to smallest; zero has a special representation in each style.

- `compact`: adjacent number-and-letter parts, such as `1h30m`, `1w2d`, or `5m`. Zero is `0s`. Thus 90 seconds is `1m30s`, and 25 hours is `1d1h`.
- `secs`: the whole number of seconds, such as `5400`. Zero is `0`.
- `long`: number and English unit word separated by a space, with parts separated by spaces, such as `1 hour 30 minutes` or `2 weeks 3 days`. Unit names are singular for 1 and plural otherwise. Zero is `0 seconds`.
- `clock`: `HH:MM:SS`, with at least two digits in each field. Hours include whole days and weeks and are not capped at 24 (for example, 26 hours is `26:00:00`). Zero is `00:00:00`.
- `iso`: `P`, followed by total whole days (including weeks as seven days) and `D` when nonzero, then `T` and nonzero hours, minutes, and seconds with `H`, `M`, and `S` suffixes when there is a remainder within a day. Examples include `PT1H30M`, `P1D`, `P1DT1H`, and `P7D`. Zero is `PT0S`.

## Output

A successful command writes its result to standard output and nothing to standard error. Output lines end in LF. A failure writes no standard output and writes one error line, ending in LF, to standard error.

- `check` validates the list and prints `ok, N duration` for one duration or `ok, N durations` otherwise.
- `sum` adds all durations and prints the total in the selected style.
- `fmt` prints each duration, in input order, in the selected style.
- `round --to UNIT [--mode MODE]` rounds each duration to a multiple of the unit and prints compact output. `down` rounds toward zero; `up` rounds to the next multiple unless already exact; `nearest` rounds to the closest multiple, with a halfway tie rounding up. For example, rounding 1 hour 30 minutes to the hour gives 2 hours. If any rounded value exceeds 99999999 seconds, the command fails at the first such input item and prints no partial output.
- `avg [--style STYLE] [--mode MODE]` divides the total by the number of durations and rounds to a whole second using the selected mode, then prints that value in the selected style.
- `diff [--style STYLE]` prints the change between each consecutive pair. An increase has a `+` prefix, a decrease has a `-` prefix, and an unchanged pair has no sign. The difference itself is rendered in the chosen style. With one duration it succeeds silently.
- `split --into N [--style STYLE]` divides the total into N parts. Each part is the whole-number quotient; the first remainder-count parts receive one extra second. For instance, 10 seconds split into three parts yields 4, 3, and 3 seconds.

Aggregate totals are not limited by the per-duration maximum, so `sum`, `avg`, `diff`, and `split` can process totals greater than 99999999 seconds.

## Examples

In the examples, `durcalc` stands for this POSIX shell function, defined in the repository directory:

```sh
durcalc() { escript durcalc "$@"; }
```

The commands and their output are:

```text
$ printf '1h30m\n2d\n' | durcalc sum
2d1h30m
$ printf '90s\n3600s\n' | durcalc fmt --style long; printf '1d1h\n' | durcalc fmt --style iso
1 minute 30 seconds
1 hour
P1DT1H
$ printf '1h29m\n1h30m\n' | durcalc round --to h; printf '10s\n' | durcalc split --into 3
1h
2h
4s
3s
3s
$ printf '1h\n1h 2m\n' | durcalc check 2>&1; printf '1h\n' | durcalc round 2>&1
durcalc: line 2: expected 1 duration
durcalc: missing --to
```

## Errors

Exit status 0 means success, 1 means an input-list or command failure, and 2 means a command-line failure. No command-line failure reads input. With no command, usage is written to standard error and status 2 is returned; help and version are exceptions that print to standard output and return status 0.

Command-line error messages are:

- `durcalc: unknown command WORD`
- `durcalc: unexpected argument WORD`
- `durcalc: unknown option WORD`
- `durcalc: option OPTION is not valid for COMMAND`
- `durcalc: given twice: OPTION`
- `durcalc: missing value for OPTION`
- `durcalc: bad value for OPTION`
- `durcalc: missing --to`
- `durcalc: missing --into`

List errors (status 1) are:

- `durcalc: input is too long (max 30 lines)`
- `durcalc: line N: expected 1 duration`
- `durcalc: line N: bad duration WORD`
- `durcalc: line N: duration too large WORD`
- `durcalc: no durations`

A rounded result over the per-duration maximum fails with `durcalc: line N: rounded duration too large WORD` (status 1). For each option word, the command-line checks are ordered: first whether that option is valid for the command, then whether it has already appeared, then whether its value is missing, and finally whether the value is invalid. The following word is consumed as the value even when it looks like another option. Once all words have been checked, a missing required `--to` or `--into` is reported. The first command-line problem is reported before input is read. The line limit takes precedence over other input errors; otherwise input lines are checked in order and the first problem is reported. All list errors precede command execution, so they take precedence over command output or errors.

## Development

The project targets Elixir 1.15 or newer and has no external dependencies. Run these checks from the repository directory:

```sh
mix format --check-formatted
mix compile --warnings-as-errors
mix test
```

The CLI exposes a pure boundary: `Durcalc.CLI.run(args, text)` returns a status, standard-output text, and standard-error text, while `Durcalc.CLI.reads_stdin?(args)` determines whether the escript entry point should read standard input. Literal CLI-row tests exercise commands and their replies through that boundary.

---

Built with [BAKED](https://github.com/Gulliby-development/baked), an open-source coding agent (bench round R101).
