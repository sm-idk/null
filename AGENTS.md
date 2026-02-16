# AGENTS.md - NixOS/Home Manager Configuration

Guidelines for AI agents working in this NixOS/Home Manager configuration repository.

## Project Overview

This is a personal NixOS/Home Manager configuration using Flakes. It manages system and user configurations across multiple hosts.

## Build/Deploy Commands

Never build the system, that is reserved only for the user. Suggest `nh` instead of `nixos-rebuild`.
Instead to verify the changes, use `nix eval .#<hostname>`

## Code Style Guidelines

### Import Patterns

```nix
# NixOS modules - explicit imports list
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];
}
```

### Package Management

```nix
# Preferred: Use builtins.attrValues with inherit for clean package lists
home.packages = builtins.attrValues {
  inherit (pkgs)
    git
    vim
    htop
  ;
};
```

### Module Structure

- Keep modules focused on a single concern
- Use `_:` for modules that don't need any arguments
- Group related modules in directories with `default.nix`
- Hardware-specific configs in `hardware-configuration.nix`

### Comments

```nix
# Use single space after hash
# Section headers with descriptive names
# Avoid redundant comments that state the obvious
# Try to make the code speak for itself, before you comment
```

## Error Handling

- Validate syntax with `nix flake check` before committing
- If you get an error about a missing file, try to use git add <filename>
- After you're done with a feature or a task, please run `nix eval .#nixosConfigurations.null.config.warnings`
- For home-manager do `nix eval .#nixosConfigurations.null.config.home-manager.users.bruno.warnings`

## Inputs and Dependencies

- Pin nixpkgs to specific branches (`nixos-25.11`)
- Use `nixpkgs-unstable` for bleeding-edge packages via `pkgsUnstable`
- Check `flake.lock` for current versions
