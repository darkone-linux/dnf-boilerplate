# Darkone NixOS Project Boilerplate

Minimal starting point for a NixOS deployment built on the
[Darkone NixOS Framework](https://github.com/darkone-linux/darkone-nixos-framework).

This repository provides the structure expected by the framework, a heavily
commented `etc/config.yaml` to fill in, and nothing else. No hosts, no users,
no generated files — everything is yours to declare.

## Structure

```
flake.nix          Consumer flake (delegates to dnf)
Justfile           Recipes (imports dnf/assets/just/project.just via .dnf/)
etc/config.yaml    Single source of truth — edit this file first
usr/               Your local overrides
  machines/        Per-host artifacts (created at install time)
  users/           Per-user customizations
var/generated/     Generator output — created on first run
.dnf/              Symlink to the framework's Just recipes (bootstrap)
```

## Getting started

### 1. Bootstrap

The framework and its `dnf-generator` binary are fetched from the Nix store.
Run once after cloning:

```sh
# Create the .dnf/ symlink -> framework's `assets` derivation
nix run github:darkone-linux/darkone-nixos-framework#init

# Enter a shell that exposes `dnf-generator`, `colmena`, `sops`, `just`,
# `nixfmt`, `statix`, `nix-unit`, etc.
nix develop github:darkone-linux/darkone-nixos-framework
```

`just --list` should now display all framework recipes
(groups `apply`, `check`, `dev`, `info`, `install`, `manage`).

### 2. Configuration

Open `etc/config.yaml`. This is the single source of truth for your deployment
(network zones, users, hosts, services). Comments describe every field; fill it
in according to your topology.

### 3. First generation

```sh
QUIET=1 just generate     # produces var/generated/*.nix from etc/config.yaml
QUIET=1 just check-flake  # nix flake check
```

On the first run, the generator creates `var/generated/` and the auto-imported
files `usr/modules/default.nix`, `usr/home/modules/default.nix`, etc. These
files are **committed**.

### 4. Secrets initialization (admin)

If you manage deployments from this host (SSH `nix` key, SOPS infrastructure
key, default password):

```sh
just configure-admin-host
```

This recipe is idempotent: it never recreates what already exists. It populates
`usr/secrets/` (age keys, `.sops.yaml` file, encrypted secrets).

### 5. Install a first host

Once `etc/config.yaml` has at least one host with a `disko` block:

```sh
just install <hostname>        # nixos-anywhere + disko
just configure <hostname>      # hardware extraction + push infra key
just apply-verbose <hostname>  # first deployment
```

Or in one shot: `just full-install <hostname>`.

## Pinning to a stable framework version

```sh
nixos-rebuild switch --flake .#<host> \
  --override-input dnf github:darkone-linux/darkone-nixos-framework/<tag>
```

## Going further

- Public documentation: <https://github.com/darkone-linux/dnf-doc>
- Framework source: <https://github.com/darkone-linux/darkone-nixos-framework>
- Generator source: <https://github.com/darkone-linux/dnf-generator>
