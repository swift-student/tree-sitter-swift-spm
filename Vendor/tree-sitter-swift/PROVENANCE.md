# Tree-sitter Swift 0.7.3

Unmodified upstream release files from
https://github.com/alex-pinkus/tree-sitter-swift/releases/tag/0.7.3
(tag commit `b8b22bffbb3441780e6471665bacfb263741c86a`).

Archive: https://github.com/alex-pinkus/tree-sitter-swift/releases/download/0.7.3/tree-sitter-swift.tar.gz

Archive SHA-256: `c595b41459b0816f246ec27f60e08392ff453135e12ef47a1852ed37fe6705fe`

The Git tag omits generated parser.c; the release archive supplies it. Sources are
vendored in this dedicated SwiftPM package to keep consumer builds independent of
a parser generator or downloads outside SwiftPM. `src/parser.c` is generated upstream (language ABI 15);
`src/scanner.c`, `src/tree_sitter/*`, and `LICENSE` are copied verbatim.
`include/swift.h` is copied from `bindings/swift/TreeSitterSwift/swift.h`.
See SHA256SUMS for the exact shipped files and LICENSE for the upstream MIT license.

To update, download a tagged release, record its archive hash and commit, replace
only these files, regenerate SHA256SUMS, and run make check plus a consuming
library's Swift fixture corpus. Do not hand-edit generated code. This package does
not supply or depend on a Tree-sitter runtime. Downstream extraction fixtures have
validated this grammar with runtime 0.25.10 on macOS arm64 using Swift 6.4.
No bundled Tags queries are used.
