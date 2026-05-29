# Darkone NixOS Project Boilerplate

Point de départ minimal pour démarrer un déploiement NixOS bâti sur le
[Darkone NixOS Framework](https://github.com/darkone-linux/darkone-nixos-framework).

Ce dépôt fournit la structure attendue par le framework, un `etc/config.yaml`
abondamment commenté à remplir, et rien d'autre. Aucun hôte, aucun utilisateur,
aucun fichier généré — c'est à vous de tout déclarer.

## Structure

```
flake.nix          Flake consommatrice (délègue à dnf)
Justfile           Recettes (importe dnf/assets/just/project.just via .dnf/)
etc/config.yaml    Source de vérité — éditez ce fichier en premier
usr/               Vos surcharges locales
  machines/        Artefacts par hôte (créés à l'installation)
  users/           Personnalisations par utilisateur
var/generated/     Sortie du générateur — créée à la première exécution
.dnf/              Symlink vers les recettes Just du framework (bootstrap)
```

## Démarrage

### 1. Bootstrap

Le framework et son binaire `dnf-generator` sont récupérés depuis le store Nix.
Une fois après clone :

```sh
# Pose le symlink .dnf/ -> dérivation `assets` du framework
nix run github:darkone-linux/darkone-nixos-framework#init

# Entre dans un shell qui expose `dnf-generator`, `colmena`, `sops`, `just`,
# `nixfmt`, `statix`, `nix-unit`, etc.
nix develop github:darkone-linux/darkone-nixos-framework
```

`just --list` doit maintenant afficher toutes les recettes du framework
(groupes `apply`, `check`, `dev`, `info`, `install`, `manage`).

### 2. Configuration

Ouvrez `etc/config.yaml`. C'est l'unique source de vérité pour votre
déploiement (zones réseau, utilisateurs, hôtes, services). Les commentaires
décrivent chaque champ ; remplissez selon votre topologie.

### 3. Première génération

```sh
QUIET=1 just generate     # produit var/generated/*.nix depuis etc/config.yaml
QUIET=1 just check-flake  # nix flake check
```

À la première exécution, le générateur crée `var/generated/` et les fichiers
auto-importés `usr/modules/default.nix`, `usr/home/modules/default.nix`,
etc. Ces fichiers sont **commités**.

### 4. Initialisation des secrets (admin)

Si vous gérez les déploiements depuis cet hôte (clé SSH `nix`, clé
infrastructure SOPS, mot de passe par défaut) :

```sh
just configure-admin-host
```

Cette recette est idempotente : elle ne recrée ce qui existe déjà. Elle
peuple `usr/secrets/` (clés age, fichier `.sops.yaml`, secrets chiffrés).

### 5. Installer un premier hôte

Une fois `etc/config.yaml` rempli avec au moins un host disposant d'un bloc
`disko` :

```sh
just install <hostname>        # nixos-anywhere + disko
just configure <hostname>      # extraction hardware + push clé infra
just apply-verbose <hostname>  # premier déploiement
```

Ou en un seul coup : `just full-install <hostname>`.

## Pointer sur une version stable du framework

```sh
nixos-rebuild switch --flake .#<host> \
  --override-input dnf github:darkone-linux/darkone-nixos-framework/<tag>
```

## Pour aller plus loin

- Documentation publique : <https://github.com/darkone-linux/dnf-doc>
- Code du framework : <https://github.com/darkone-linux/darkone-nixos-framework>
- Code du générateur : <https://github.com/darkone-linux/dnf-generator>
