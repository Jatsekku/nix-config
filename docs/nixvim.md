# NixVim

---
> **09.02.2025**\
> I decided to give vim a try.
> In this particular config-time point I'm gonna start with neovim.
---

## What is nixvim?
It's bascially neovim managed by nix with flake support.\
This approach unify ad simplify managing neovim in comparasion to
vanila-neovim package.

## Stucture
- Basic nixvim settings are managed by home-manager under\
[/homeManagerModules/neovim.nix](/homeManagerModules/nixvim.nix)
- Personal settings are managed per user i.e.\
[/users/jatsekku/nixvim/default.nix](/users/jatsekku/nixvim/default.nix)

## References
1. https://typecraft.dev/neovim-for-newbs - Newbie-targeted course about neovim configuration
