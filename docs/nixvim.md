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

## Plugins
Neovim can be highly customized and extend by applying plugins.

### lualine.nvim
[![lualine.nvim](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github)](https://github.com/nvim-lualine/lualine.nvim)
[![nixvim](https://img.shields.io/badge/nixvim_docs-efefff?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiPgogIDxwYXRoIGQ9Ik01OS43NCAzMS4xN2gzM2wzMDcuODMgNDQ2LjQ0aC03NC40NEwxMzMuNTIgMTk0LjEzdjI4My40OEg1OS43NHoiIHN0eWxlPSJmaWxsOiM3ZWI2ZTEiLz4KICA8cGF0aCBkPSJNNDQ4LjU3IDQ3Ny42MWgtMzNMMTA3Ljc0IDMxLjE3aDc0LjQzbDE5Mi42MSAyODMuNDhWMzEuMTdoNzMuNzl6IiBzdHlsZT0iZmlsbDojNGU3MWI2Ii8+Cjwvc3ZnPg==)](https://nix-community.github.io/nixvim/plugins/lualine/index.html?highlight=lualine#lualine)


### telescope.nvim
[![telescope.nvim](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github)](https://github.com/nvim-telescope/telescope.nvim)
[![nixvim](https://img.shields.io/badge/nixvim_docs-efefff?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiPgogIDxwYXRoIGQ9Ik01OS43NCAzMS4xN2gzM2wzMDcuODMgNDQ2LjQ0aC03NC40NEwxMzMuNTIgMTk0LjEzdjI4My40OEg1OS43NHoiIHN0eWxlPSJmaWxsOiM3ZWI2ZTEiLz4KICA8cGF0aCBkPSJNNDQ4LjU3IDQ3Ny42MWgtMzNMMTA3Ljc0IDMxLjE3aDc0LjQzbDE5Mi42MSAyODMuNDhWMzEuMTdoNzMuNzl6IiBzdHlsZT0iZmlsbDojNGU3MWI2Ii8+Cjwvc3ZnPg==)](https://nix-community.github.io/nixvim/plugins/telescope/index.html?highlight=telesc#telescope)

Telescope is extensible fuzzy finder for Neovim.\
Some of it's functionalities:
- Searching/greping files
- Navigating git files, commits, branches 
- Live greping
- Interactive UI

### nvim-treesitter
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github)](https://github.com/nvim-treesitter/nvim-treesitter)
[![nixvim](https://img.shields.io/badge/nixvim_docs-efefff?style=for-the-badge&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbDpzcGFjZT0icHJlc2VydmUiIHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiPgogIDxwYXRoIGQ9Ik01OS43NCAzMS4xN2gzM2wzMDcuODMgNDQ2LjQ0aC03NC40NEwxMzMuNTIgMTk0LjEzdjI4My40OEg1OS43NHoiIHN0eWxlPSJmaWxsOiM3ZWI2ZTEiLz4KICA8cGF0aCBkPSJNNDQ4LjU3IDQ3Ny42MWgtMzNMMTA3Ljc0IDMxLjE3aDc0LjQzbDE5Mi42MSAyODMuNDhWMzEuMTdoNzMuNzl6IiBzdHlsZT0iZmlsbDojNGU3MWI2Ii8+Cjwvc3ZnPg==)](https://nix-community.github.io/nixvim/plugins/treesitter/index.html?highlight=trees#treesitter)

## References
1. https://typecraft.dev/neovim-for-newbs - Newbie-targeted course about neovim configuration
