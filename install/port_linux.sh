#!/bin/bash
# Dirty script to port the macOS install script to Linux.
# Makes it easier to maintain a single install script and test.

set -e

# Take the script path even if it is sourced
script_dir="$(dirname $(realpath ${BASH_SOURCE[0]}))"

# For bazel-lsp
mkdir -p ~/.local/bin

# Notes
# * Homebrew on Linux is installed to /home/linuxbrew/.linuxbrew (trying to set a symlink from /opt/homebrew to it
#       confuses brew and it thinks it's on mac)
# * termshark is only available on Linux x86_64 https://formulae.brew.sh/formula/termshark
# * Casks are macOS only
# * We don't install fonts nor ghostty on Linux as we assume it'll be a remote server
sed -e 's#/opt/homebrew#/home/linuxbrew/.linuxbrew#g' \
    -e '/termshark/d' \
    -e '/cask/,/^$/d' \
    -e 's/bazel-lsp-0.6.4-osx-arm64/bazel-lsp-0.6.4-linux-arm64/g' \
    -e '/monaco-bold/d' \
    -e "s/sed -i ''/sed -i''/g" \
    -e '/ghostty/d' \
    -e '/karabiner/d' \
    ${script_dir}/install_mac_os.sh > ${script_dir}/install_linux.sh
chmod +x ${script_dir}/install_linux.sh
