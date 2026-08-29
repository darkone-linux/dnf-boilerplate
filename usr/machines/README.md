# `usr/machines/<hostname>/`

One directory per installed host. Seeded by `just generate` for every host
carrying a `disko:` block in `etc/config.yaml`, then completed by
`just install` / `just configure`. You should not need to write these by hand.

Typical contents:

- `default.nix` — entry point (auto-imported when the directory exists).
- `disko.nix` — disk layout, copied once from the `disko.profile` you chose
  (`dnf/hosts/disko/` or `usr/hosts/disko/`). Yours to adapt afterwards.
- `generated-configuration.nix` — rewritten on every `just generate` from the
  host's `disko:` block. **Do not edit.**
- `hardware-configuration.nix` — extracted from the running machine by
  `just copy-hw` (or by `nixos-anywhere` during `just install`). **Do not edit.**

This directory stays empty until you declare a host with a `disko:` block.
