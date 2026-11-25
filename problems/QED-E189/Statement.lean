import Mathlib
/-! QED-E189: Reachability for two-interval piecewise affine maps
Fix a rational cut point c in (0,1) and two affine maps with rational coefficients, and let f use the first map on [0,c) and the second on [c,1), with f mapping [0,1) into itself. Given rational x and y in [0,1), does iterating f from x ever hit y exactly? Is there an algorithm that decides this for every such f, x, y? It is open even for two pieces, while in dimension two the analogous problem is undecidable.
Informal statement: For $\theta=(a_1,b_1,a_2,b_2,c)\in\mathbb Q^5$ with $0<c<1$ let $f_\theta:[0,1)\to\mathbb R$, $f_\theta(t)=a_1t+b_1$ for $t<c$ and $f_\theta(t)=a_2t+b_2$ for $t\ge c$, and let $\Theta=\{\theta: f_\theta([0,1))\subseteq[0,1)\}$ (a decidable set). Let $\mathrm{Reach}_2=\{(\theta,x,y):\theta\in\Theta,\ x,y\in\mathbb Q\cap[0,1),\ \exists n\ge0\ f_\theta^{\,n}(x)=y\}$. Decide whether $\mathrm{Reach}_2$ is decidable (either answer, with proof, resolves the problem).
Formalization notes:
* Computability model: Mathlib's `ComputablePred` (partial recursive functions) on inputs
  encoded as natural numbers. Instances (θ, x, y) ∈ ℚ⁷ are encoded by an explicit, plainly
  primitive-recursive coding: `ratOfNat k` decodes k via `Nat.unpair` into a sign bit,
  numerator and denominator−1 (surjective onto ℚ), and `nth k i` extracts the i-th component of
  an iterated `Nat.unpair` tuple. Any standard encoding of rational tuples is computably
  inter-translatable with this one, so decidability does not depend on the choice.
* `f θ t = a₁t+b₁` if `t < c`, else `a₂t+b₂`, computed in ℚ. Since θ, x are rational the
  orbit stays in ℚ, and on [0,1) it agrees with the real map.
* `Θ`: `0 < c < 1` and `f` maps every rational t ∈ [0,1) into [0,1). This equals the real
  condition f([0,1)) ⊆ [0,1): each piece is affine with rational coefficients, so a violation
  at a real point of [0,c) or [c,1) would give one at a nearby rational point, or else the
  piece equals 0 or 1 exactly at an irrational point, impossible unless it is constant
  (then also at rational points).
* `Reach k`: the decoded instance lies in Θ, x, y ∈ [0,1), and ∃ n, f^[n] x = y
  (n = 0 allowed). Codes of invalid instances are rejected, as in the informal statement,
  where membership in Θ and in [0,1) is decidable.
* Proving `Claim` = Reach₂ is decidable. Proving `¬Claim` = Reach₂ is undecidable. Both
  resolve the problem.
-/
namespace OpenProblems.QEDE189
noncomputable section

/-- Decode a natural number to a rational: `k ↦ ⟨⟨s, a⟩, b⟩`, value `±a/(b+1)`. -/
def ratOfNat (k : ℕ) : ℚ :=
  (if (Nat.unpair (Nat.unpair k).1).1 % 2 = 0 then (1 : ℚ) else -1) *
    ((Nat.unpair (Nat.unpair k).1).2 : ℚ) / (((Nat.unpair k).2 : ℚ) + 1)

/-- The `i`-th component of `k` viewed as an iterated pair `⟨k₀, ⟨k₁, ⟨k₂, …⟩⟩⟩`. -/
def nth : ℕ → ℕ → ℕ
  | k, 0 => (Nat.unpair k).1
  | k, i + 1 => nth (Nat.unpair k).2 i

/-- The decoded rational instance `(a₁, b₁, a₂, b₂, c, x, y)` as indices 0..6. -/
def inst (k : ℕ) (i : ℕ) : ℚ := ratOfNat (nth k i)

/-- The two-interval piecewise affine map with parameters `a₁ b₁ a₂ b₂ c`. -/
def pam (a₁ b₁ a₂ b₂ c : ℚ) (t : ℚ) : ℚ :=
  if t < c then a₁ * t + b₁ else a₂ * t + b₂

/-- The parameters define a self-map of `[0,1)` with cut point in `(0,1)`. -/
def Valid (a₁ b₁ a₂ b₂ c : ℚ) : Prop :=
  0 < c ∧ c < 1 ∧ ∀ t : ℚ, 0 ≤ t → t < 1 → 0 ≤ pam a₁ b₁ a₂ b₂ c t ∧ pam a₁ b₁ a₂ b₂ c t < 1

/-- The reachability language `Reach₂`, on encoded instances. -/
def Reach (k : ℕ) : Prop :=
  Valid (inst k 0) (inst k 1) (inst k 2) (inst k 3) (inst k 4) ∧
    0 ≤ inst k 5 ∧ inst k 5 < 1 ∧ 0 ≤ inst k 6 ∧ inst k 6 < 1 ∧
    ∃ n : ℕ, (pam (inst k 0) (inst k 1) (inst k 2) (inst k 3) (inst k 4))^[n] (inst k 5) =
      inst k 6

def Claim : Prop := ComputablePred Reach

end
end OpenProblems.QEDE189
