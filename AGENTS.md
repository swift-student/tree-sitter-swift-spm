# Contributor instructions

This package contains C code generated from a pinned, unmodified upstream grammar.
Never hand-edit files under Vendor. Use scripts/regenerate.sh and preserve its
license, provenance, and checksums. Run the script with --check to verify reproduction.
Use Swift 6 language mode for handwritten Swift and Swift Testing if tests are added.
Run make check and the consuming library's complete fixture suite before publishing an update.
Do not claim platform support without validation.
