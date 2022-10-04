#!/usr/bin/env bash

# requires curl & jq
# upstreamCommit

current=$(cat ../gradle.properties | grep purpurRef | sed 's/purpurRef = //')
upstream=$(git ls-remote https://github.com/PurpurMC/Purpur | grep ver/1.19.2 | cut -f 1)

purpur=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/PurpurMC/Purpur/compare/$current...$upstream | jq -r '.commits[] | "PurpurMC/Purpur@\(.sha[:7]) \(.commit.message | split("\r\n")[0] | split("\n")[0])"')

echo "Current: $current"
echo "Upstream: $upstream"


if [ $current == $upstream ]; then
    echo "Equal"
    exit 0
fi

updated=""
logsuffix=""

if [ ! -z "purpur" ]; then
    logsuffix="$logsuffix\n\nPurpur Changes:\n$purpur"
    updated="Purpur"
fi

disclaimer="Upstream has released updates that appear to apply and compile correctly"

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

sed -i 's/purpurRef = .*/purpurRef = '"$upstream"'/' ../gradle.properties

git add ../gradle.properties
echo -e "$log" | git commit -F -
