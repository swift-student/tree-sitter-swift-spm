# Tree-sitter Swift: upstream try-await fix

Upstream: https://github.com/alex-pinkus/tree-sitter-swift
Revision: `28fe3a8a85586aa297524fe6164140b9521dcaff` (2026-07-04, after release 0.7.3).
The grammar and scanner are unmodified upstream sources. This revision includes
[the upstream fix for `try await` in control-flow conditions](https://github.com/alex-pinkus/tree-sitter-swift/commit/28fe3a8a85586aa297524fe6164140b9521dcaff).

`src/parser.c` and `src/tree_sitter/*` are generated with Tree-sitter CLI 0.25.10
(`da6fe9beb4f7f67beb75914ca8e0d48ae48d6406`) and `--abi 15`.
`src/scanner.c` and `LICENSE` are copied verbatim from that upstream revision.
`include/swift.h` is copied from `bindings/swift/TreeSitterSwift/swift.h`.
See `SHA256SUMS` for each shipped file and `LICENSE` for the upstream MIT license.

Reproduce with Node.js, the pinned CLI, and an upstream Git clone:

```sh
bash scripts/regenerate.sh /path/to/tree-sitter-swift --check
```

The script archives only the exact pinned Git revision, generates the parser,
runs the complete upstream parser corpus, and compares every packaged source and
checksum. Omit `--check` to update the generated files. Never hand-edit them.
The [CLI's official macOS arm64 release archive](https://github.com/tree-sitter/tree-sitter/releases/download/v0.25.10/tree-sitter-macos-arm64.gz)
has SHA-256 `a6295d469669f6e901b6029ae6c129bd094df582d278c237fada413505cb9c42`.

This package supplies no runtime or editor queries. Consumer fixtures validate
this grammar against Tree-sitter runtime 0.25.10. Run `make check` and the
consuming library's complete fixture suite before publishing an update.
