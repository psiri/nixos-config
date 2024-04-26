#!/usr/bin/env bash
source env.sh
sudo mkdir -p ${INSTALL_DIR}/etc/nixos ${INSTALL_DIR}/boot
sudo cp nixos/*.nix ${INSTALL_DIR}/etc/nixos
sudo nixos-install --root ${INSTALL_DIR}
