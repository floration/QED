import Lake
open Lake DSL
package openproblems
require mathlib from git "https://github.com/leanprover-community/mathlib4" @ "v4.36.0"
@[default_target] lean_lib OpenProblems where
  srcDir := "."
  roots := #[]
