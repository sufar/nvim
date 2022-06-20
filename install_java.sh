#!/bin/bash

java_resource_dir=$HOME/.config/nvim/resources/java
jdtls_server_dir=$java_resource_dir/jdtls-server
java_debug_dir=$java_resource_dir/java-debug
java_test_dir=$java_resource_dir/vscode-java-test
lombok_dir=$java_resource_dir/lombok

mvn -v || exit
git --version || exit
npm -v || exit

if [ ! -d "$java_resource_dir" ]; then
  mkdir -p "$java_resource_dir"
fi

jdtLanguageServer() {
  if [ -d "$jdtls_server_dir" ]; then
    mv "$jdtls_server_dir" /tmp
  fi
  mkdir -p "$jdtls_server_dir"
  cd "$jdtls_server_dir" || exit
  rm -f jdt-language-server-latest*
  wget http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz || exit
  tar -zxf jdt-language-server-latest.tar.gz
  rm -f "$jdtls_server_dir"/jdt-language-server-latest.tar.gz
}

javaDebug() {
  if [ -d "$java_debug_dir" ]; then
    cd "$java_debug_dir" || exit
    git pull
  else
    cd "$java_resource_dir" || exit
    git clone https://github.com/microsoft/java-debug.git || exit
  fi
  cd "$java_debug_dir" || exit
  mvn clean install -Dmaven.test.skip || exit
}

javaTest() {
  if [ -d "$java_test_dir" ]; then
    cd "$java_test_dir" || exit
    git pull
  else
    cd "$java_resource_dir" || exit
    git clone https://github.com/microsoft/vscode-java-test || exit
  fi
  cd "$java_test_dir" || exit
  npm install
  npm run build-plugin
}

lombokDownload() {
  cd "$java_resource_dir" || exit
  if [ -d "$lombok_dir" ]; then
    mv "$lombok_dir" /tmp
  fi
  mkdir -p "$lombok_dir"
  lombokLatestTag=`wget -qO- -t1 -T2 "https://api.github.com/repos/projectlombok/lombok/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g'`
  lombokUrl=https://codeload.github.com/projectlombok/lombok/tar.gz/refs/tags/"$lombokLatestTag"
  echo lombokUrl
  wget "$lombokUrl"
  tar -zxf "$lombokLatestTag" --strip-components=1 -C "$lombok_dir"
  # rm -f "$java_resource_dir"/"$lombokLatestTag"
}

lombokJarDownload() {
  cd "$java_resource_dir" || exit
  rm -f "$java_resource_dir"/lombok*
  wget https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar
}

echo "--------------jdtLanguageServer-----------------"
if [ -d "$jdtls_server_dir" ]; then
  read -r -p "Would you like to install jdtLanguageServer? 'y' or 'n': " choose
  if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
    jdtLanguageServer
  fi
else
  jdtLanguageServer
fi

echo "--------------javaDebug-------------------------"
if [ -d "$java_debug_dir" ]; then
  read -r -p "Would you like to install javaDebug? 'y' or 'n': " choose
  if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
    javaDebug
  fi
else
  javaDebug
fi

echo "--------------javaTest--------------------------"
if [ -d "$java_test_dir" ]; then
  read -r -p "Would you like to install javaTest? 'y' or 'n': " choose
  if [ "$choose" == "yes" ] || [ "$choose" == "y" ]; then
    javaTest
  fi
else
  javaTest
fi

echo "--------------lombokDownload--------------------------"
lombokJarDownload
