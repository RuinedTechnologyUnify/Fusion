#!/usr/bin/env bash

# PatchServer <Patch Name>

PS1="$"

cd Fusion-Server

git add .
git commit -m $1

cd ../

./gradlew rebuildServerPatches