#!/bin/bash
# filepath: .devcontainer/post-create.sh

# Source the environment variables
set -eu

# Install gdb and build-essential
sudo apt-get update && sudo apt-get install -y gdb netcat build-essential

# rust installation
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH=$PATH:~/.cargo/bin/
rustup component add rust-src
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"