#!/usr/bin/env bash
sudo nix \
    --experimental-features "nix-command flakes" \
    run github:nix-community/disko \
    -- \
    --mode disko \
    ./disko-config.nix
