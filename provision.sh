#!/usr/bin/env bash

if [[ `xcode-select -p` != "/Applications/Xcode.app/Contents/Developer" && `xcode-select -p` != "/Applications/Xcode-beta.app/Contents/Developer" ]]; then
  echo "Install XCode from the App Store"
  exit 1
else
  echo "XCode is installed"
fi

declare xcode_select_installed=`xcode-select --install 2>&1 | grep "command line tools are already installed"`
if [ -z "$xcode_select_installed" ]; then
  echo "Installing xcode-select"
  xcode-select --install
else
  echo "xcode-select installed"
fi

if [ ! -x /usr/local/bin/docker ]; then
  echo "Install Docker for Mac: https://www.docker.com/products/docker#/mac"
  exit 1
else
    echo "Docker is installed"
fi

if [ ! -x /usr/local/bin/brew ]; then
    echo "installing homebrew"
    /usr/bin/env ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "homebrew is installed"
fi

if [ ! -x /usr/local/bin/ansible ]; then
    echo "installing ansible via homebrew"
    brew install ansible
else
    echo "ansible is installed"
fi

ansible-playbook -i playbooks/inventory playbooks/main.yml

docker-compose up -d

echo "Ready to go!"
