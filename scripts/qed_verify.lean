import Lean
open Lean

/-!
# Trusted QED solution verifier

Usage (run by `scripts/check.py --stage=verify`, never on contributor code):

    LEAN_PATH=<dir with QEDStmt.olean and QEDSol.olean>:<Mathlib LEAN_PATH> \
      lean --run scripts/qed_verify.lean <nonce> QEDStmt QEDSol <Claim name> <proof|disproof>

* `QEDStmt.olean` is the official `Statement.lean` from the base branch, compiled by the trusted job.
* `QEDSol.olean` is the official statement followed by the contribution, compiled by the untrusted job.
  It is only ever treated as data.

This file is elaborated before any contributor module is loaded, so contributor notations, macros,
elaborators, namespaces, `variable`s, `#guard_msgs`, printed output, etc. cannot influence how it is
parsed or what it prints. The contributor module is imported with `loadExts := false` (no environment
extensions, no `initialize` code), every declaration it adds is re-checked by the kernel
(`Kernel.Environment.replay`), the statement's declarations must be identical to the ones compiled from
the official statement alone, `solution` must be a root-level constant whose type is *syntactically*
`OpenProblems.<id>.Claim` (or `¬ OpenProblems.<id>.Claim` for a disproof), and its axioms are collected
by walking the kernel-checked environment directly (not from any precomputed, importable data).
-/

def allowedAxioms : List Name := [``propext, ``Classical.choice, ``Quot.sound]

def die {α : Type} (msg : String) : IO α := throw (IO.userError msg)

/-- Progress line on stderr (never parsed; only the nonce line on stdout counts). -/
def step (msg : String) : IO Unit := do
  IO.eprintln s!"[qed_verify {← IO.monoMsNow} ms] {msg}"

/-- All axioms `root` depends on, walking types and values of constants in a kernel environment. -/
def collectAxioms (env : Kernel.Environment) (root : Name) : IO (Array Name) := do
  let mut seen : NameSet := {}
  let mut axs : Array Name := #[]
  let mut todo : Array Name := #[root]
  while !todo.isEmpty do
    let n := todo.back!
    todo := todo.pop
    if seen.contains n then continue
    seen := seen.insert n
    let some ci := env.find? n | die s!"unknown constant {n} while collecting axioms"
    if ci.isUnsafe then die s!"{n} is unsafe"
    if ci matches .axiomInfo _ then axs := axs.push n
    todo := todo ++ ci.type.getUsedConstants
    if let some v := ci.value? (allowOpaque := true) then
      todo := todo ++ v.getUsedConstants
    if let .inductInfo v := ci then
      todo := todo ++ v.ctors.toArray
  return axs

/-- Returns the list of axioms used, or throws. The two environments are imported with `leakEnv := true`
and never freed: this is a short-lived process, and freeing the imported regions while kernel
objects built from them (the replayed environment) are still alive is unsafe. `loadExts := false`:
no environment extension of the contributor module is loaded and no `initialize` code runs. -/
def check (stmtMod solMod claim : Name) (kind : String) : IO (List String) := do
    let envS ← importModules #[{ module := stmtMod }] {} (leakEnv := true) (loadExts := false)
    step "statement environment loaded"
    let envA ← importModules #[{ module := solMod }] {} (leakEnv := true) (loadExts := false)
    step "solution environment loaded"
    let some sIdx := envS.getModuleIdx? stmtMod | die "statement module not loaded"
    let some aIdx := envA.getModuleIdx? solMod | die "solution module not loaded"
    let sData := envS.header.moduleData[sIdx.toNat]!
    let aData := envA.header.moduleData[aIdx.toNat]!
    unless aData.imports.map (·.module) == sData.imports.map (·.module) do
      die "the solution module's imports differ from the official statement's"
    let some cS := envS.find? claim | die s!"{claim} is not declared by the official statement"
    -- Declarations the statement also has must be identical; everything else is new and is replayed.
    let mut newConsts : Std.HashMap Name ConstantInfo := {}
    let mut sawClaim := false
    for ci in aData.constants do
      match envS.find? ci.name with
      | some ci' =>
        unless ci == ci' do die s!"{ci.name} differs from the official statement / its imports"
        if ci.name == claim then sawClaim := true
      | none => newConsts := newConsts.insert ci.name ci
    unless sawClaim do die s!"{claim} is missing from the compiled solution"
    unless newConsts.contains `solution do
      die "no root-level `solution` declaration (it must not be inside a namespace)"
    step s!"{newConsts.size} new declarations; replaying"
    -- Kernel re-check of every new declaration on top of the official statement's environment.
    let kenv ← envS.toKernelEnv.replay newConsts
    let some sol := kenv.find? `solution | die "`solution` was not accepted by the kernel"
    match sol with
    | .thmInfo _ | .defnInfo _ | .opaqueInfo _ => pure ()
    | _ => die "`solution` must be a theorem or a definition"
    let claimE := mkConst claim (cS.levelParams.map mkLevelParam)
    let target := if kind == "proof" then claimE else mkApp (mkConst ``Not) claimE
    let shown := if kind == "proof" then toString claim else "¬ " ++ toString claim
    unless sol.levelParams == cS.levelParams && sol.type == target do
      die s!"`solution` must have type exactly {shown}"
    step "replayed; collecting axioms"
    let axs ← collectAxioms kenv `solution
    step s!"{axs.size} axioms"
    let bad := axs.filter (fun a => !allowedAxioms.contains a)
    let badStr := String.intercalate ", " (bad.toList.map toString)
    unless bad.isEmpty do
      die s!"uses non-standard axioms: {badStr}"
    return axs.toList.map toString

def main (args : List String) : IO UInt32 := do
  let [nonce, stmtMod, solMod, claim, kind] := args
    | die "usage: qed_verify <nonce> <StmtModule> <SolModule> <Claim> <proof|disproof>"
  try
    unless kind == "proof" || kind == "disproof" do die s!"unknown kind {kind}"
    initSearchPath (← findSysroot)
    let axs ← check stmtMod.toName solMod.toName claim.toName kind
    let axStr := String.intercalate ", " axs
    IO.println s!"QED-VERIFY {nonce} OK {axStr}"
    (← IO.getStdout).flush
    return 0
  catch e =>
    IO.println s!"QED-VERIFY {nonce} FAIL {e}"
    (← IO.getStdout).flush
    return 1
