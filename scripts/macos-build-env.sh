#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	echo "Source this file: source scripts/macos-build-env.sh" >&2
	exit 1
fi

brew_prefix="${HOMEBREW_PREFIX:-$(brew --prefix)}"
gnu_paths=(
	"$brew_prefix/opt/coreutils/libexec/gnubin"
	"$brew_prefix/opt/diffutils/bin"
	"$brew_prefix/opt/findutils/libexec/gnubin"
	"$brew_prefix/opt/gnu-getopt/bin"
	"$brew_prefix/opt/gnu-sed/libexec/gnubin"
	"$brew_prefix/opt/gnu-tar/libexec/gnubin"
	"$brew_prefix/opt/grep/libexec/gnubin"
	"$brew_prefix/opt/make/libexec/gnubin"
)

for gnu_path in "${gnu_paths[@]}"; do
	if [ -d "$gnu_path" ]; then
		PATH="$gnu_path:$PATH"
	fi
done

export PATH
