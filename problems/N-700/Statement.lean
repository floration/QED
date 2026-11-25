import Mathlib
/-! N-700: Does UGC imply SSEH?
STATUS: NOT YET FORMALIZED
Raghavendra-Steurer proved that the Small-Set Expansion Hypothesis implies the Unique Games
Conjecture. Is the converse true, i.e. is Small-Set Expansion UG-hard?
Informal statement: Give a polynomial-time reduction from Unique Games to Gap-Small-Set
Expansion showing UGC ⇒ SSEH: for every η > 0 there is δ > 0 such that Gap-SSE(η, δ) is NP-hard
under the assumption that Gap-UG(ε, 1−ε) is NP-hard for all ε > 0 (equivalently, Gap-SSE(η, δ)
is UG-hard). The alternative, a separation, can only be meaningful relative to a model (e.g. an
oracle, or an algorithm class such as SoS degrees that solves SSE but provably not UG).
Formalization notes: Not formalized. A faithful statement needs polynomial-time computability
and many-one (Karp) reductions between promise problems, NP-hardness, and the gap versions of
Unique Games (label-cover instances with permutation constraints) and Small-Set Expansion
(edge expansion of sets of measure δ in regular graphs). Mathlib has no polynomial-time
complexity theory (no P, NP, or polynomial-time reductions usable for such statements).
Note that "UGC ⇒ SSEH" as a bare implication between two unproved hypotheses cannot be refuted
without proving UGC, so the meaningful content is the existence of a reduction; proving `Claim`
would be such a reduction, and a refutation would have to be relative to a restricted model.
-/
namespace OpenProblems.N700
def Claim : Prop := sorry
end OpenProblems.N700
