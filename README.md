# TreeSitterSwiftGrammar

A source-only SwiftPM package generated from the unmodified upstream
[tree-sitter-swift revision 28fe3a8](https://github.com/alex-pinkus/tree-sitter-swift/commit/28fe3a8a85586aa297524fe6164140b9521dcaff).
This post-0.7.3 revision fixes `try await` in control-flow conditions, which could
consume the statement body as a trailing closure and lose enclosing declarations.
The generated parser is checked in, so consumers need no parser generator or
build-time download outside SwiftPM.

```swift
dependencies: [
    .package(url: "https://github.com/swift-student/tree-sitter-swift-spm", revision: "<reviewed-package-commit>"),
],
targets: [
    .target(name: "YourTarget", dependencies: [
        .product(name: "TreeSitterSwiftGrammar", package: "tree-sitter-swift-spm"),
    ]),
]
```

`import TreeSitterSwiftGrammar` exposes `tree_sitter_swift()`. Consumers supply
their own compatible Tree-sitter runtime; this package has no runtime dependency,
queries, resource bundles, or Swift wrapper. The generated grammar uses language
ABI 15. It has been validated with Tree-sitter 0.25.10 by downstream Swift
extraction fixtures on macOS arm64 using Swift 6.4.

Generated files remain separate under `Vendor/`. See the upstream
[license](LICENSE), [provenance and update instructions](Vendor/tree-sitter-swift/PROVENANCE.md),
and [file checksums](Vendor/tree-sitter-swift/SHA256SUMS).

Run `make check` to verify the copied files, build debug and release configurations,
and validate the handwritten manifest with SwiftLint 0.65.1 and SwiftFormat 0.62.1.
Run the consuming library's full regression suite before publishing a grammar update,
including Swift syntax, Unicode, recovery, and source-range fixtures. Pin the reviewed
packaging commit until a corresponding package release is tagged; package versions
are independent of grammar versions. Always record the actual upstream revision in
the provenance.

## Regenerate and verify

Install Node.js and Tree-sitter CLI **0.25.10**, then clone the upstream repository:

```sh
git clone https://github.com/alex-pinkus/tree-sitter-swift.git /tmp/tree-sitter-swift
bash scripts/regenerate.sh /tmp/tree-sitter-swift --check
# To replace the generated files after deliberately changing the pin:
bash scripts/regenerate.sh /tmp/tree-sitter-swift
```

Set `TREE_SITTER=/path/to/tree-sitter` to choose the CLI. The script reads the pinned
commit from Git, regardless of the checkout's branch or uncommitted changes; generates
ABI 15 output; runs the complete upstream parser corpus; and compares or replaces the
generated files and checksums. It does not patch the upstream grammar. Editor-query
tests are outside this package, which supplies no queries.

Swift 6 tools and language mode are declared. Platform validation is recorded by
the consuming library; this package makes no additional platform support claims.
