# Sourced by the Crest rule in aerospace.toml, which saves starting a second shell. Runs
# crest-window-detected.swift compiled and returns its exit status. The binary is kept
# outside the repository and rebuilt whenever the source is newer.

source_file=${BASH_SOURCE[0]%.sh}.swift
binary=~/.cache/aerospace/crest-window-detected

if [[ ! $binary -nt $source_file ]]; then
    mkdir -p "${binary%/*}" &&
        swiftc -O "$source_file" -o "$binary.$$" &&
        mv "$binary.$$" "$binary" || return
fi

"$binary"
