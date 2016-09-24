#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# sanity check
# grep -R --no-filename '"github.com/syndtr/goleveldb' "$DIR/../leveldb"

/usr/bin/find "$DIR/../leveldb" -type f -iname "*.go"
# | xargs sed -i -e 's:"github.com/syndtr/goleveldb:"github.com/midnightfreddie/goleveldb:'