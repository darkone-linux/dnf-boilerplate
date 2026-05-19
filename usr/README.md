# `usr/` — your local overlay

This is **your** layer. The framework lives in the nix store (via the `dnf`
flake input) and never reaches into your repo by relative path — it only
reads what you put here.

## Subdirectories

- **`machines/<hostname>/`** — per-host install artefacts. Created the first
  time you `just install <hostname>` (disko, hardware-configuration,
  generated-configuration).
- **`users/<login>/`** — per-user customisations. Add a `default.nix` here
  to layer your own home-manager configuration on top of the user's profile.
- **`modules/`** — additional NixOS modules specific to this deployment.
  `just generate` produces `modules/default.nix` (auto-import index).
- **`home/`** — home-manager overlay. Mirror structure of `modules/`.
- **`home/profiles/`** — custom user profiles to reference from
  `etc/config.yaml:users.<login>.profile`.
- **`secrets/`** — SOPS-encrypted secrets + age keys. Created by
  `just configure-admin-host`. **Never** edited by automation.

Empty subdirectories are pruned by Git. They appear on disk only after you
add content (or after `just generate` runs).

## Convention

- `default.nix` files at the top of `usr/modules/`, `usr/home/modules/`,
  etc. are **generated** by `just generate`. Header: `# DO NOT EDIT`.
- Hand-written entry points (e.g. `usr/home/default.nix` that imports
  `./modules`) are yours to maintain.
