#!/usr/bin/env bash
source env.sh
sudo nix \
    --experimental-features "nix-command flakes" \
    run github:nix-community/disko \
    -- \
    --mode disko \
    --root-mountpoint ${INSTALL_DIR} \
    ./disko-config.nix
