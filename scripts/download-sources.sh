#!/usr/bin/env bash
set -eufo pipefail

cur_dir="$(dirname "$0")"
source "$cur_dir/common"

cd "$cur_dir/.."
rm -rf src
mkdir src

curl -sfo src/xpdf.tar.gz "https://dl.xpdfreader.com/xpdf-$XPDF_VERSION.tar.gz"
tar -xf src/xpdf.tar.gz -C src
rm src/xpdf.tar.gz
