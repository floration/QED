import Export
open Lean

/-!
# qedexport

Thin wrapper around the pinned `lean4export` library (NDJSON export format 3.1).

    qedexport module   <Module>                         -- every constant defined in <Module>, plus dependencies
    qedexport official <Module> <names.jsonl> <stmt.jsonl>

`module` is run by the UNTRUSTED compile job on the contributor's compiled module.

`official` is run by the TRUSTED verify job on the official statement, compiled there from the base branch.
It exports every constant defined by the statement module (and writes their names to <stmt.jsonl>), plus
every constant listed in <names.jsonl> that exists in the official environment, plus dependencies.
Names are passed as JSON arrays of components (strings and natural numbers), so any name round-trips exactly.
Output goes to stdout. Unsafe and partial constants are exported too, so the checker can reject them by name.
-/

def nameOfJson : Json → Except String Name
  | .arr cs => cs.foldlM (init := Name.anonymous) fun n c =>
    match c with
    | .str s => pure (n.str s)
    | .num k => if k.exponent == 0 && k.mantissa ≥ 0 then pure (n.num k.mantissa.toNat)
                else throw "name component is not a natural number"
    | _ => throw "bad name component"
  | _ => throw "a name must be a JSON array"

def nameToJson (n : Name) : Json :=
  Json.arr <| n.componentsRev.reverse.toArray.map fun
    | .str _ s => Json.str s
    | .num _ k => toJson k
    | .anonymous => Json.null

def exportConsts (env : Environment) (consts : Array Name) : IO Unit :=
  M.run env do
    initState env ["--export-unsafe"]
    dumpMetadata
    for c in consts do
      modify fun st => { st with noMDataExprs := {} }
      dumpConstant c

def moduleConsts (env : Environment) (mod : Name) : IO (Array Name) := do
  let some idx := env.getModuleIdx? mod | throw <| IO.userError s!"module {mod} not loaded"
  return env.header.moduleData[idx.toNat]!.constNames

def main (args : List String) : IO UInt32 := do
  initSearchPath (← findSysroot)
  match args with
  | ["module", mod] =>
    let env ← importModules #[{ module := mod.toName }] {} (loadExts := false)
    exportConsts env (← moduleConsts env mod.toName)
    (← IO.getStdout).flush
    return 0
  | ["official", mod, namesFile, stmtOut] =>
    let env ← importModules #[{ module := mod.toName }] {} (loadExts := false)
    let stmt ← moduleConsts env mod.toName
    IO.FS.writeFile stmtOut (String.join (stmt.toList.map fun n => (nameToJson n).compress ++ "\n"))
    let mut wanted := stmt
    for l in ← IO.FS.lines namesFile do
      if l.isEmpty then continue
      match Json.parse l >>= nameOfJson with
      | .ok n => if env.contains n then wanted := wanted.push n
      | .error e => throw <| IO.userError s!"bad name line: {e}"
    exportConsts env wanted
    (← IO.getStdout).flush
    return 0
  | _ =>
    IO.eprintln "usage: qedexport module <Module> | qedexport official <Module> <names.jsonl> <stmt.jsonl>"
    return 2
