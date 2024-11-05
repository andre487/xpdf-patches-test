#!/usr/bin/env bash
set -eufo pipefail
cd "$(dirname "$0")/.."
if [[ ! -f pdfreference1.6.pdf ]]; then
    curl -sfo pdfreference1.6.pdf 'https://opensource.adobe.com/dc-acrobat-sdk-docs/pdfstandards/pdfreference1.6.pdf'
fi
