#!/usr/bin/env bash

# CommitAPI <Patch Name>

PS1="$"

cd ../Fusion-API

git add .
git commit --allow-empty -m $1
git format-patch -1