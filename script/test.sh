#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
PDIR="$DIR/.."
UDIR="$PDIR/tree-sitter-jack"
EXE="node_modules/.bin/tree-sitter"

run_test() {
    local root="$PDIR" tst tsts=()
    while (( "$#" )); do
        case "$1" in
            -u) root="$UDIR"
                ;;
            -*) echo "unrecognized flag: $1" && exit 1;;
            *) break;;
        esac
        shift || true
    done
    tst="$1"; shift

    if [[ -z "$tst" ]]; then
        echo "missing test/not found: $tst"
        exit 1
    fi

    if [[ ! -f "$tst" ]]; then
        mapfile -t tsts < <(find . -type f -iname "$tst" -exec realpath {} \;)
    else
        tsts+=( "$tst" )
    fi

    if [[ ! -x "$root/$EXE" ]]; then
        echo "$root/$EXE" not found
        exit 1
    fi
    cd "$root" || exit 1
    
    echo "[RUN] $root/$EXE parse ${tsts[*]} $*"
    npx tree-sitter generate && npx tree-sitter parse "${tsts[@]}" "$@"
}

"$@"
