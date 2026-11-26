#!/usr/bin/env bash
# CI setup shared by verify.yml and verifier-selftest.yml. Always run from the base branch's copy of scripts/
# (verify.yml restores scripts/ from the base branch first), never from a contributor's copy.
#   scripts/ci_setup.sh            Lean + pinned Mathlib cache + the pinned exporter (scripts/qedexport)
#   scripts/ci_setup.sh --nanoda   ... and the pinned independent kernel (nanoda), for trusted jobs
set -euo pipefail
NANODA_REV=0da9f98feadd3a0a2ef4b3dbcf52a298a6fef929   # ammkrn/nanoda_lib, accepts export format 3.1.x

# Never reuse build outputs that came with the checkout.
rm -rf .lake scripts/qedexport/.lake

curl -sSfL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y --default-toolchain none
export PATH="$HOME/.elan/bin:$PATH"
echo "$HOME/.elan/bin" >> "$GITHUB_PATH"
if [ -f lake-manifest.json ]; then lake exe cache get; else lake update && lake exe cache get; fi

# The exporter is built with exactly the repository's toolchain, so it can read the oleans built here.
cp lean-toolchain scripts/qedexport/lean-toolchain
(cd scripts/qedexport && lake build qedexport)
echo "QED_EXPORTER=$PWD/scripts/qedexport/.lake/build/bin/qedexport" >> "$GITHUB_ENV"

if [ "${1:-}" = "--nanoda" ]; then
  d="$RUNNER_TEMP/nanoda"
  rm -rf "$d"
  git clone -q https://github.com/ammkrn/nanoda_lib "$d"
  git -C "$d" checkout -q "$NANODA_REV"
  cargo build -q --release --locked --manifest-path "$d/Cargo.toml"
  echo "QED_NANODA=$d/target/release/nanoda_bin" >> "$GITHUB_ENV"
fi
