SWIFT ?= swift

.PHONY: verify build tools lint format format-check check
verify:
	cd Vendor/tree-sitter-swift && shasum -a 256 -c SHA256SUMS
build:
	$(SWIFT) build
	$(SWIFT) build -c release
tools:
	@test "$$(swiftlint version)" = "0.65.1" || (echo "Install SwiftLint 0.65.1"; exit 1)
	@test "$$(swiftformat --version)" = "0.62.1" || (echo "Install SwiftFormat 0.62.1"; exit 1)
lint: tools
	swiftlint lint --strict
format: tools
	swiftformat . --config .swiftformat
format-check: tools
	swiftformat . --lint --config .swiftformat
check: verify build lint format-check
