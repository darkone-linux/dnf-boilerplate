# `usr/users/<login>/`

One subdirectory per user declared in `etc/config.yaml:users`. Each
contains a hand-written `default.nix` that layers on top of the user's
home-manager profile (e.g. extra packages, shell aliases, dotfiles).

Minimal example, `usr/users/alice/default.nix`:

```nix
{ pkgs, ... }:
{
  home.packages = with pkgs; [ ripgrep fd ];

  programs.git = {
    enable = true;
    userName = "Alice";
    userEmail = "alice@example.lan";
  };
}
```

The framework imports `usr/users/<login>/` only for users that actually
exist in `etc/config.yaml`. Adding a directory here without declaring the
user above does nothing.

This directory is empty until you declare your first user.
