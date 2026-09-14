// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "TreeSitterSwiftGrammar",
    products: [.library(name: "TreeSitterSwiftGrammar", targets: ["TreeSitterSwiftGrammar"])],
    targets: [
        .target(name: "TreeSitterSwiftGrammar", path: "Vendor/tree-sitter-swift",
                exclude: ["LICENSE", "PROVENANCE.md", "SHA256SUMS"],
                sources: ["src/parser.c", "src/scanner.c"], publicHeadersPath: "include",
                cSettings: [.headerSearchPath("src")]),
    ],
    swiftLanguageModes: [.v6],
    cLanguageStandard: .c11
)
