# dvim

## Perequisite
- Node 18 or later
- Neovim 8 or later
- Vim 0.4 or later

## Installation
- Install Packer
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
Then run following built-in command to install plugins:
```
:PackerUpdate or :PackerInstall
```

- Install lua language server https://luals.github.io/wiki/build/
```
git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server
./make.sh

// If you are receiving a compile error similar to cannot find -lstdc++ when running a make script, you may need to install libstdc++.
// On Fedora Linux or similar, you can do this by running the following
dnf install libstdc++-static
```

If you get error when running `./make.sh`, maybe you need to install ninja package `apt install ninja-build`

- Active Gruvbox theme
uncomment following line in `lua/base.lua`
```
vim.cmd([[colorscheme gruvbox]])
```

## F&Qs
<details>
<summary>[coc] server connection lost</summary>

```
Run :CocInstall . It requires Node version ≥ 18
```
</details>

<details>
<summary>prettiered not found. did you forget to install it</summary>

```
Install pretter globally `npm install -g prettier`
Active Pretter using COC: `:CocInstall coc-prettier`
```
</details>

<details>
<summary>Got issue with Treesitter</summary>

```
If you got error message in treesitter panel when you select a specific file, ie: base.lua. You have install it in Treesitter by using command: `TSInstall lua`
```
</details>