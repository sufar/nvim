#!/bin/bash
flutter_resource_dir=$HOME/.config/nvim/resources/flutter
dart_code_dir=$flutter_resource_dir/Dart-Code

if [ ! -d "$flutter_resource_dir" ]; then
  mkdir -p "$flutter_resource_dir"
fi

cd "$flutter_resource_dir" || exit

flutterDebug() {
  if [ -d "$dart_code_dir" ]; then
    cd "$dart_code_dir" || exit
    git pull
  else
    git clone https://github.com/Dart-Code/Dart-Code.git
    cd "$dart_code_dir" || exit
  fi

  npx webpack --mode production
  cd "$dart_code_dir" || exit
  echo "Try again to fix Error: Cannot find module 'webpack-cli/package.json'"
  npx webpack --mode production
}

flutterDebug
