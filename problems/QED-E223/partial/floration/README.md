# QED-E223 — partial work (floration, Claude Opus 5.5)

Status: construction found and machine-checked for n = 32…55; **the resolution lower bound is proved in Lean** (`PHPLowerBound.lean`). Not a solution yet.

## Idea
Hide a pigeonhole contradiction PHP(p, h) with p = h + 2 pigeons and h holes (h odd, h ≥ 7) inside the Sudoku so that,
after unit propagation from the givens, **every free cell is a full PHP line** (a *pigeon cell*: its h allowed symbols
↔ the h holes of one pigeon; or a *hole cell*: its p allowed symbols ↔ the p pigeons of one hole) and **every
(row/column/box, symbol) group of free variables is exactly one PHP line**. Renaming each free Sudoku variable to its
PHP variable then sends every clause of SUD_n(A_n)|ρ to a clause of onto-functional PHP(p, h). Restriction and renaming
never lengthen resolution refutations, and fixing one pigeon in one hole turns PHP(h+2, h) into PHP(h+1, h−1), so
Haken's theorem gives every refutation size 2^{Ω(h)} = 2^{Ω(n)}.

## Givens
Grid row R = b·n + o (band b, offset o), column C = t·n + q (stack t, offset q); symbols are pairs (α, β) ∈ [n]².
Outside the n × n "core" {o = 0, t = 0} the givens are the pattern Sudoku (α, β) = (o + t, b + q) mod n.
Inside the core (indexed by (b, q)) the cells hold symbols with α = 0, the core's rows, columns and boxes see
no other α = 0 symbols, so the core is an independent order-n partial Latin square (boxes coincide with rows).
The core is an explicit 16-block partial Latin square of order L = 4h + 4 (10 filled cyclic blocks, 6 empty
blocks carrying the PHP), prolonged to order n = L + k (0 ≤ k ≤ 7) along k explicit disjoint transversals.
See `gadget.py.txt` (construction + checks) and `fullcheck.py.txt` (full Sudoku check).

Two balance laws dictate the layout: each unit needs #blank cells = #missing symbols, and within each band
(resp. stack) a symbol must be missing from equally many rows (resp. columns) as boxes.

Unsatisfiability is a counting argument: the h symbols X must fill the p rows of block A using only the h
columns of block C.

## Checked by computer
* h = 7, 9, 11 with k = 0…7 (every n from 32 to 55): core is a valid partial Latin square, each blank allows exactly
  its designed symbols, every cell and every row/column-symbol group is exactly one PHP line.
* n = 32: the full 1024 × 1024 Sudoku (givens valid; allowed sets exact; every row/column/box-symbol group a PHP line).

## Proved in Lean (`PHPLowerBound.lean`, no unproved steps, standard axioms only)
* `QEDRes.transfer'`: restriction + positive renaming never lengthens a resolution refutation, and tracks which
  original line each new line comes from.
* `QEDRes.wide_line`: every refutation of onto-functional PHP(N+1, N), N ≥ 3, has a line of monotone width
  ≥ 2(N+1)²/9 (critical assignments, subadditive pigeon measure, swap argument).
* `QEDRes.php_lower`: every refutation of onto-functional PHP(N+1, N), N ≥ 8, has length ≥ (18/17)^(N/2)
  (≈ N/2 greedy single-pigeon restrictions, each chosen by averaging to kill a fixed fraction of wide lines).

## Proved in Lean (`TMGenerator.lean`): the explicitness side
* `QEDTM.polytime_of_prog`: structured counter programs with a polynomial step bound give
  `Turing.TM2ComputableInPolyTime id id F` (one TM2 step per instruction, exact simulation).
* `QEDTM.cE_spec` + `QEDTM.Exp.bound`: a verified compiler from arithmetic expressions to counter programs,
  with polynomial time bounds.
* `QEDTM.gen_polytime`, `QEDTM.Fgen_getD`: any 7-variable expression defines a TM2-polytime bit string with the
  index layout used by the QED-E223 statement.

## Remaining
2. Lean: correctness of the construction for every n ≥ 32.
3. ~~TM2 generator~~ done: only the expression for the givens remains to be written down.
