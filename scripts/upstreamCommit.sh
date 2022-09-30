#!/usr/bin/env bash

# requires curl & jq

# upstreamCommit <baseHash> <newHash>
# param: bashHash - the commit hash to use for comparing commits (baseHash...newHash)
# param: newHash - the commit hash to use for comparing commits
#upstreamCommit.sh 3bd6f8fc3c251df3b89d73ea780e3219e4f67119 dc8af93dfd232ab2971893d0b6c39c2649114b1f

(
set -e
PS1="$"

purpur=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/PurpurMC/Purpur/compare/$1...$2 | jq -r '.commits[] | "PurpurMC/Purpur@\(.sha[:7]) \(.commit.message | split("\r\n")[0] | split("\n")[0])"')

updated=""
logsuffix=""
if [ ! -z "purpur" ]; then
    logsuffix="$logsuffix\n\nPurpur Changes:\n$purpur"
    updated="Purpur"
fi
disclaimer="Upstream has released updates that appear to apply and compile correctly"

log="${UP_LOG_PREFIX}Updated Upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log" | git commit -F -

) || exit 1