#!/bin/bash
RESOURCE_DIR=$(pwd)

if [ ! -d "$RESOURCE_DIR" ]; then
  echo "mkdir $RESOURCE_DIR"
  mkdir "$RESOURCE_DIR"
fi

read -r -p "Would you like to install Java dependecies? 'y' or 'n': " choose
if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
  sh "$RESOURCE_DIR"/install_java.sh
fi

read -r -p "Would you like to install Rust dependecies? 'y' or 'n': " choose
if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
  sh "$RESOURCE_DIR"/install_rust.sh
fi

read -r -p "Would you like to install Flutter dependecies? 'y' or 'n': " choose
if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
  sh "$RESOURCE_DIR"/install_flutter.sh
fi
