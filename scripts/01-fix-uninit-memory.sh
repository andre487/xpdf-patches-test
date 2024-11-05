#!/usr/bin/env bash
set -eufo pipefail

cur_dir="$(cd $(dirname "$0") && pwd)"
source "$cur_dir/common"
"$cur_dir/download-sources.sh"
"$cur_dir/download-pdf.sh"

cd "$cur_dir/../src/xpdf-$XPDF_VERSION"
if [[ "$*" =~ --fix ]]; then
    ls -lah xpdf/PDFDoc.cc
    patch -p0 < "$cur_dir/../patches/01-fix-uninit-memory.patch"
fi

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_CXX_FLAGS="-O1 -g -fsanitize=memory -fno-optimize-sibling-calls -fsanitize-memory-track-origins=2 -fno-omit-frame-pointer -fsanitize-blacklist=$cur_dir/../msan-exclude.txt" -S . -B build
cmake --build build --target pdftohtml

cd "$cur_dir/.."
out_dir="$(mktemp -d)"
"./src/xpdf-$XPDF_VERSION/build/xpdf/pdftohtml" 'pdfreference1.6.pdf' "$out_dir"
echo "Out dir: $out_dir"
