#! /usr/bin/env nix-shell
#! nix-shell -i bash -p jq curl wget unzip nix
# shellcheck shell=bash

set -euo pipefail

INPUT_FILE="extensions_list.txt"
OUTPUT_FILE="extensions.nix"

echo "Generating ${OUTPUT_FILE}..."

TMP_DIR=$(mktemp -d)
trap 'rm -rf -- "$TMP_DIR"' EXIT

TMP_OUTPUT_FILE="${TMP_DIR}/extensions.nix.tmp"

cat > "$TMP_OUTPUT_FILE" <<EOF
# This file is auto-generated
# DO NOT edit manually
{ pkgs }:
[
EOF

while read -r line || [[ -n "$line" ]]; do
  # Skip comments and empty lines.
  if [[ "$line" =~ ^\s*# ]] || [[ -z "$line" ]]; then
    continue
  fi

  id=$(echo "$line" | awk '{print $1}' | tr -d '\r')

  x_param="id%3D${id}%26installsource%3Dondemand%26uc"
  URL="https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=133&x=${x_param}"
  finalurl=$(curl -w "%{url_effective}" -I -L -sS "${URL}" -o "${TMP_DIR}/curl.tmp")

  download_path="${TMP_DIR}/extension.zip"
  wget -q -O "$download_path" "$finalurl"

  hex_hash=$(sha256sum "$download_path" | cut -d' ' -f1)
  hash=$(nix hash to-sri --type sha256 "$hex_hash")

  unzip_dir="${TMP_DIR}/unzipped"
  mkdir -p "$unzip_dir"
  unzip -q "$download_path" -d "$unzip_dir" || true

  # Extract the version from the manifest
  version=$(jq -r ".version" < "${unzip_dir}/manifest.json")
  rm -r "$unzip_dir"

  cat >> "$TMP_OUTPUT_FILE" <<EOF
  {
    id = "${id}";
    crxPath = pkgs.fetchurl {
      url = "${finalurl}";
      name = "${id}.crx";
      hash = "${hash}";
    };
    version = "${version}";
  }
EOF

done < "$INPUT_FILE"

echo "]" >> "$TMP_OUTPUT_FILE"

# Only if the entire loop succeeds, we atomically replace the old file
mv "$TMP_OUTPUT_FILE" "$OUTPUT_FILE"

echo "Successfully generated and replaced ${OUTPUT_FILE}!"
