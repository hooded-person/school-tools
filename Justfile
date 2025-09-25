root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# update import declaration in lib.typ
update-lib-imports:
  echo "#import \"/src/imports.typ\": $(cat "src/imports.typ" | grep -Po "#let +\K(\w+)(?= *= *\(:\))" | paste -sd",")" > '{{TYPST_ROOT}}/src/lib.typ'

# generate manual
doc: update-lib-imports
  typst compile docs/manual.typ docs/manual.pdf
  typst compile docs/thumbnail.typ thumbnail-light.svg
  typst compile --input theme=dark docs/thumbnail.typ thumbnail-dark.svg

# run test suite
test *args: update-lib-imports
  tt run {{ args }}

# update test cases
update *args: update-lib-imports
  tt update {{ args }}

# package the library into the specified destination folder
package target: update-lib-imports
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run ci suite
ci: test doc
