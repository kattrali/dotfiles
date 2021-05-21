#!/usr/bin/env bash

AUR_CACHE=~/.local/aur/
mkdir -p "$AUR_CACHE"

for package in $(cat init/arch/Pacfile.aur); do
  PACKAGE_DIR="$AUR_CACHE/$package"
  if [ ! -d "$PACKAGE_DIR" ]; then
    git clone https://aur.archlinux.org/$package.git "$PACKAGE_DIR"
    pushd "$PACKAGE_DIR"
      makepkg --syncdeps --install
    popd
  fi
done
