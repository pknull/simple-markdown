#!/usr/bin/env bash

# Exit on error.
set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

for dep in ../build/tabular ../build/vader.vim; do
  if [[ ! -d $dep ]]; then
    echo "Missing dependency: $dep"
    echo "You may just want to use 'make test'."
    exit 1
  fi
done

# Keep Vim's temporary files in the checkout and do not write viminfo.
mkdir -p ../build/tmp
export TMPDIR="$(cd ../build/tmp && pwd)"
vim -N -i NONE -u vimrc -c 'Vader! *.vader' > /dev/null
