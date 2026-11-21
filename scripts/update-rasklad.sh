#!/usr/bin/env bash
# Point Casks/rasklad.rb at the latest Rasklad release (or the version given as $1).
# Prints "updated <version>" or "up to date <version>". Does not commit.
set -euo pipefail
cd "$(dirname "$0")/.."
CASK=Casks/rasklad.rb
REPO=Agentbars/rasklad

if [[ $# -ge 1 ]]; then
  version="${1#v}"
else
  auth=()
  [[ -n "${GH_TOKEN:-}" ]] && auth=(-H "Authorization: Bearer $GH_TOKEN")
  tag=$(curl -fsSL ${auth[@]+"${auth[@]}"} "https://api.github.com/repos/$REPO/releases/latest" \
        | python3 -c 'import json,sys; print(json.load(sys.stdin)["tag_name"])')
  version="${tag#v}"
fi
[[ "$version" =~ ^[0-9]+(\.[0-9]+)*$ ]] || { echo "bad version: $version" >&2; exit 1; }

current=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$CASK")
if [[ "$current" == "$version" ]]; then
  echo "up to date $version"
  exit 0
fi

zip=$(mktemp)
trap 'rm -f "$zip"' EXIT
curl -fsSL -o "$zip" "https://github.com/$REPO/releases/download/v$version/Rasklad-v$version.zip"
sha=$(shasum -a 256 "$zip" | cut -d' ' -f1)

sed -i.bak \
  -e "s/^  version \".*\"$/  version \"$version\"/" \
  -e "s/^  sha256 \".*\"$/  sha256 \"$sha\"/" "$CASK"
rm -f "$CASK.bak"
echo "updated $version"
