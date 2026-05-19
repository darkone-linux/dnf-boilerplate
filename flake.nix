{
  description = "Darkone NixOS Project Boilerplate — starting point for a new deployment.";

  #----------------------------------------------------------------------------
  # FLAKE INPUTS
  #----------------------------------------------------------------------------
  #
  # The framework is consumed from its public GitHub repo. To pin against a
  # released tag, append a ref to the URL or override at build time:
  #
  #   dnf.url = "github:darkone-linux/darkone-nixos-framework/v0.1.0";
  #
  #   nixos-rebuild switch --flake .#<host> \
  #     --override-input dnf github:darkone-linux/darkone-nixos-framework/<tag>
  #
  # For co-development against a local working tree of the framework, swap
  # this URL for an absolute `git+file://` pointing at the sibling checkout.

  inputs = {
    dnf.url = "github:darkone-linux/darkone-nixos-framework";
  };

  #----------------------------------------------------------------------------
  # FLAKE OUTPUTS
  #----------------------------------------------------------------------------
  #
  # The whole assembly logic (Colmena hive, nixosConfigurations, devShells,
  # ISO images) lives in the framework. This project only forwards its own
  # `workDir` (= flake root) so the framework can read its `etc/config.yaml`,
  # `var/generated/` and `usr/` overlay.

  outputs = inputs: inputs.dnf.lib.mkConfigurations ./.;
}
