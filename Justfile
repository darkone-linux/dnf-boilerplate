# dnf-boilerplate — consumer Justfile.
#
# `.dnf/` is a symlink to the framework's `assets` package in the nix store.
# Bootstrap it once with:
#   nix run github:darkone-linux/darkone-nixos-framework#init
# `import?` keeps `just --list` working (showing local recipes only) before
# the bootstrap runs.

import? '.dnf/just/project.just'

# Justfile help
_default:
	@just --list
