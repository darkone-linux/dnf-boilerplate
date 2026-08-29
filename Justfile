# dnf-boilerplate — consumer Justfile.
#
# `dnf/` is a symlink to the framework tree in the nix store, laid down once by:
#   nix run github:darkone-linux/darkone-nixos-framework#init
# It gives `just` its recipes and `dnf-generator` the profiles it resolves on
# disk (`dnf/home/profiles/`, `dnf/hosts/disko/`). It is gitignored.
# `import?` keeps `just --list` working (local recipes only) before that runs.

import? 'dnf/assets/just/project.just'
#import? 'dnf/assets/just/dev.just'    # uncomment for framework/sub-project development

# Justfile help
_default:
	@just --list
