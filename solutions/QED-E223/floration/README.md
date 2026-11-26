# QED-E223: explicit Sudoku puzzles that need exponentially long resolution refutations

`theorem solution : OpenProblems.QEDE223.Claim`, with ε = 1/2.

**Construction.** The base Sudoku solution puts symbol `((o+t) mod n, (b+q) mod n)` at row `b·n+o`,
column `t·n+q`. The cells with `o = t = 0` form an `n×n` Latin square on the symbols `< n`, and each of its
boxes is one of its rows. That square is replaced by a partial design of order `L = 8⌊n/8⌋`, with rows
A, B, A', B' of sizes `p, h, p, h` (`h = 2⌊n/8⌋−1`, `p = h+2`), the same split on columns, and symbol
classes X, Z, Y, Y'. The design has six blank blocks. It is then extended by `k = n mod 8` disjoint
transversals to order `n`.

**Lower bound.** A restriction sends each blank cell's live symbols to variables of PHP(h+2, h). Every
Sudoku clause becomes either trivially true or a superset of a PHP clause: cell lines, row, column and
box lines all map bijectively onto pigeon or hole lines. Resolution refutations transfer without getting
longer (`QEDRes.transfer'`). The onto-functional PHP(δ+N, N) lower bound (critical assignments, a
hitting-set measure, a swap/width argument, then greedy restrictions) gives `18^(h/2) ≤ |L|·17^(h/2)`,
which is at least `2^(√n)` for `n ≥ 20000`.

**Unsatisfiability.** Column 0 of the core has `p` blank cells whose rows miss only the `h` symbols of X.

**Explicitness.** The givens bit is an arithmetic expression `givE` over `(n, b, o, t, q, α, β)`. It is
compiled by a verified counter-machine → `FinTM2` compiler (`QEDTM.gen_polytime`), giving a
polynomial-time `Turing.TM2ComputableInPolyTime` function on unary input.

Files are concatenated in this order: `A_PHP` (PHP lower bound), `B_TM` (Turing machine generator),
`C_Sudoku` (reduction, design, prolongation, encoding), `Solution` (assembly).
