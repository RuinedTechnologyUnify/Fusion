#!/usr/bin/env bash

# PatchAPI <Patch Name>

PS1="$"

cd Fusion-API

git add .
git commit --allow-empty -m $1

cd ../

./gradlew rebuildAPIPatches