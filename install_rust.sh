#!/bin/bash
rust_resource_dir=$HOME/.config/nvim/resources/rust
vscode_lldb_dir=$rust_resource_dir/vscode-lldb

if [ ! -d "$rust_resource_dir" ]; then
  mkdir -p "$rust_resource_dir"
fi

cd "$rust_resource_dir" || exit

vscodeLLLDB() {
  if [ -d "$vscode_lldb_dir" ]; then
    rm -rf "$vscode_lldb_dir"
  fi
  mkdir -p "$vscode_lldb_dir"
  cd "$vscode_lldb_dir" || exit
  rm -f rm codelldb-x86_64-linux.vsix*
  lldbTag=`wget -qO- -t1 -T2 "https://api.github.com/repos/vadimcn/vscode-lldb/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
  echo 'vscode-lldb the newest version is '"$lldbTag"' but it does not work, error: Either --connect or --port must be specified'
  lldbTag=v1.6.10
  echo 'warning!!! use vscode-lldb version: '"$lldbTag"
  wget https://github.com/vadimcn/vscode-lldb/releases/download/"$lldbTag"/codelldb-x86_64-linux.vsix
  unzip codelldb-x86_64-linux.vsix
}

vscodeLLLDB
