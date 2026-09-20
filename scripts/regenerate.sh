#!/usr/bin/env bash
set -euo pipefail

# Keep this revision and the provenance document in sync. No local grammar edits
# are used: archive the exact upstream commit, generate, and run its parser corpus.
upstream_revision=28fe3a8a85586aa297524fe6164140b9521dcaff
generator_version='tree-sitter 0.25.10 (da6fe9beb4f7f67beb75914ca8e0d48ae48d6406)'
tree_sitter="${TREE_SITTER:-tree-sitter}"
package_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ $# -lt 1 || $# -gt 2 || ( $# -eq 2 && "$2" != --check ) ]]; then
  echo "Usage: $0 /path/to/upstream-tree-sitter-swift [--check]" >&2
  exit 2
fi
if [[ "$("$tree_sitter" --version)" != "$generator_version" ]]; then
  echo "Expected $generator_version" >&2
  exit 1
fi

temporary=$(mktemp -d)
trap 'rm -rf "$temporary"' EXIT
mkdir -p "$temporary/upstream" "$temporary/vendor/include" "$temporary/vendor/src/tree_sitter"
# Only parser inputs and the complete parser corpus are needed. This package does
# not ship or use the upstream editor queries and their separate test harness.
git -C "$1" archive "$upstream_revision" \
  grammar.js tree-sitter.json src/scanner.c test/corpus LICENSE \
  bindings/swift/TreeSitterSwift/swift.h | tar -x -C "$temporary/upstream"
(
  cd "$temporary/upstream"
  "$tree_sitter" generate --abi 15
  "$tree_sitter" test
)

files=(LICENSE src/parser.c src/scanner.c src/tree_sitter/alloc.h src/tree_sitter/array.h src/tree_sitter/parser.h)
for file in "${files[@]}"; do
  cp "$temporary/upstream/$file" "$temporary/vendor/$file"
done
cp "$temporary/upstream/bindings/swift/TreeSitterSwift/swift.h" "$temporary/vendor/include/swift.h"
(
  cd "$temporary/vendor"
  shasum -a 256 LICENSE include/swift.h src/parser.c src/scanner.c \
    src/tree_sitter/alloc.h src/tree_sitter/array.h src/tree_sitter/parser.h > SHA256SUMS
)

files+=(include/swift.h SHA256SUMS)
if [[ "${2:-}" == --check ]]; then
  for file in "${files[@]}"; do
    cmp "$temporary/vendor/$file" "$package_dir/Vendor/tree-sitter-swift/$file"
  done
  echo "Generated parser matches the pinned upstream revision."
else
  for file in "${files[@]}"; do
    cp "$temporary/vendor/$file" "$package_dir/Vendor/tree-sitter-swift/$file"
  done
  echo "Updated generated parser. Run make check and the consuming library's fixture suite."
fi
