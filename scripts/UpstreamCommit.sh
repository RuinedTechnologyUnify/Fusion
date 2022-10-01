#!/usr/bin/env bash

# requires curl & jq
# upstreamCommit

set -e
current=$(cat ../gradle.properties | grep purpurRef | sed 's/purpurRef = //')

purpur=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/PurpurMC/Purpur/compare/$current...HEAD | jq -r '.commits[] | "PurpurMC/Purpur@\(.sha[:7]) \(.commit.message | split("\r\n")[0] | split("\n")[0])"')

updated=""
logsuffix=""
if [ ! -z "purpur" ]; then
    logsuffix="$logsuffix\n\nPurpur Changes:\n$purpur"
    updated="Purpur"
fi
disclaimer="Upstream has released updates that appear to apply and compile correctly"

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"
sed -i 's/purpurRef = .*/purpurRef = '"$current"'/' ../gradle.properties
echo -e "$log" | git commit -F -
