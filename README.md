Rust golang java scala vue flutter's neovim development environment configurations

![image](https://user-images.githubusercontent.com/82210712/232181237-861f29a0-243e-497e-be63-949f4a404882.png)

## dependency

archlinux:

```shell
sudo pacman -S xsel
sudo pacman -S lazygit
sudo pacman -S ncdu
yay -S coursier
sudo pacman -S fd
sudo pacman -S ripgrep
sudo pacman -S jq
sudo pacman -S graphviz
yay -S sniprun
pip install neovim
```

windows:

```shell
scoop install ripgrep
scoop install gcc
```

## First of all

In neovim exec: `:Lazy` and `U`

## rust

In neovim exec `:MasonInstall rust-analyzer` and `:MasonInstall codelldb`

![image](https://user-images.githubusercontent.com/82210712/232181189-40bea576-8e47-40ba-833e-8daf97c63c61.png)

## java

In neovim exec `:MasonInstall jdtls` and `:MasonInstall java-test` and `:MasonInstall java-debug-adapter`

Set system environment `JAVA8_HOME` and `JAVA11_HOME`

Set `JAVA_HOME` to jdk17

![image](https://user-images.githubusercontent.com/82210712/232179334-a52bbb89-c412-4567-9a61-d983c94ff8fa.png)

## gradle

In neovim exec `:MasonInstall gradle-language-server`

In your gradle project
```
./gradlew buildEnvironment
```

## python

In neovim exec `:MasonInstall pyright` and don't install the debugpy

```
pip install debugpy
```
[nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)

## flutter

In neovim exec `:MasonInstall dart-debug-adapter`

## golang

Make sure the $GOPATH/bin path is added to your $PATH environment variable. To check this you can run
```bash
echo $PATH | grep "$GOPATH/bin"
```
If nothing shows up, you can add the following to your shell config file:
```bash
export PATH=$PATH:$GOPATH/bin
```

In neovim exec `:GoInstallBinaries`

The neovim configuration file: `lua/lsp/golang.lua`

Please don't use mason to install `gopls` and `go-debug-adapter`

Debug:

debug main: `:GoDebug`

debug test: when cursor in test function, nvim exec `:GoDebug -t`

[ray-x/go.nvim](https://github.com/ray-x/go.nvim)

## scala

[scalameta/nvim-metals](https://github.com/scalameta/nvim-metals)

[Install coursier and add cs to PATH](https://get-coursier.io/docs/cli-installation)

```
curl -fL "https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz" | gzip -d > cs
```

In neovim exec `:MetalsInstall`

## vue

In neovim exec `:MasonInstall vue-language-server`, which will install volar.

## lua

In neovim exec `:MasonInstall lua-language-server`

## json

In neovim exec `:MasonInstall json-lsp`

## yaml

In neovim exec `:MasonInstall yaml-language-server`

## sql

[vim-dadbod](https://github.com/tpope/vim-dadbod)

[vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)

[vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion)

### add connections

```
mkdir ~/.local/share/db_ui
```

> vim ~/.local/share/db_ui/connections.json

```
[
  {
    "name": "localhost",
    "url": "mysql://root:zugle@127.0.0.1"
  }
]
```

### mysql

Download the [mysql client](https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.32-linux-glibc2.17-x86_64-minimal.tar.xz) and put the `mysql` to PATH

```
sudo pacman -S ncurses
sudo pacman -S ncurses5-compat-libs
```

## toml

In neovim exec `:MasonInstall taplo`

## xml

In neovim exec `:MasonInstall lemminx`

## bash

In neovim exec `:MasonInstall bash-language-server`

```
sudo pacman -S shellcheck
```
[bash-language-server](https://github.com/bash-lsp/bash-language-server)

[shellcheck](https://github.com/koalaman/shellcheck#installing)

## css

In neovim exec `:MasonInstall css-lsp`

## html

In neovim exec `:MasonInstall html-lsp`

## javascript typescript

In neovim exec `:MasonInstall typescript-language-server`
