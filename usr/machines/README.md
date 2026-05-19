# `usr/machines/<hostname>/`

One subdirectory per host you install. Created automatically by
`just install <hostname>` / `just configure <hostname>`; you should not
need to write these files by hand.

Typical contents per host:

- `default.nix` — entry point (auto-imported by `mkConfigurations`)
- `hardware-configuration.nix` — extracted from the running host via
  `nixos-generate-config --show-hardware-config`. Protected — do not edit.
- `generated-configuration.nix` — produced by the generator from the
  host's `disko` block in `etc/config.yaml`. Protected — do not edit.
- `disko.nix` — disk layout used at install time by
  [disko](https://github.com/nix-community/disko).

This directory is empty until you install your first host.
