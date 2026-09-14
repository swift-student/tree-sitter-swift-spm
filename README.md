# TreeSitterSwiftGrammar

A source-only SwiftPM package for the unmodified generated parser from
[tree-sitter-swift 0.7.3](https://github.com/alex-pinkus/tree-sitter-swift/releases/tag/0.7.3).
The upstream Git tag omits `src/parser.c`; its release archive includes it.
This repository packages those release files so consumers need no parser generator
or build-time download outside SwiftPM.

```swift
dependencies: [
    .package(url: "https://github.com/swift-student/tree-sitter-swift-spm", exact: "0.1.0"),
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
including Swift syntax, Unicode, recovery, and source-range fixtures. Package versions
are independent of grammar versions: package 0.1.0 contains upstream grammar 0.7.3.
Always record the actual upstream grammar version in the provenance.

Swift 6 tools and language mode are declared. Platform validation is recorded by
the consuming library; this package makes no additional platform support claims.
