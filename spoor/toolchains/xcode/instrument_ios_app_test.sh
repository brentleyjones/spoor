#!/usr/bin/env bash
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

set -eu

# --- begin runfiles.bash initialization v3 ---
# Copy-pasted from the Bazel Bash runfiles library v3.
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \
  source "$0.runfiles/$f" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \
  { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=;
# --- end runfiles.bash initialization v3 ---

set +o pipefail

home="$(mktemp -d)"
export HOME="$home"

app_build_file=$(rlocation "$APP_RELATIVE_PATH")
APP_PATH="${app_build_file%/*}"
DESTINATION="platform=iOS Simulator,OS=17.2,name=iPhone 15"
CONFIGURATION="Debug"
# FIXME: This doesn't work when a toolchain is at "~/Library/Developer/Toolchains" already
XCODE_USER_TOOLCHAINS_PATH="$HOME/Library/Developer/Toolchains"
SPOOR_TOOLCHAIN_PATH=$(rlocation "_main/spoor/toolchains/xcode/$TOOLCHAIN_NAME")

DERIVED_DATA_PATH="$(mktemp -d)"
BINARY_FILE_PATH="$DERIVED_DATA_PATH/Build/Products/$CONFIGURATION-iphonesimulator/$APP_NAME.app/$APP_NAME"

function clean_up {
  rm -rf "$home"
  rm -rf "$DERIVED_DATA_PATH"
  rm -rf "$XCODE_USER_TOOLCHAINS_PATH"
}

# Manually clean up artifacts because the this test cannot be run in a sandbox.
trap clean_up SIGINT
trap clean_up EXIT

# Hack (continued): Revert files back to their original name by undoing the
# `http_archive` patch.
find "$APP_PATH" -name '*__SPACE__*' -print0 |
  sort -rz |
    while read -d $'\0' f; do
      mv "$f" "$(dirname "$f")/$(basename "${f//__SPACE__/ }")"
    done

mkdir -p "$XCODE_USER_TOOLCHAINS_PATH"
ln -s "$SPOOR_TOOLCHAIN_PATH" "$XCODE_USER_TOOLCHAINS_PATH/$TOOLCHAIN_NAME"

xcodebuild \
  clean build \
  -configuration "$CONFIGURATION" \
  -destination "$DESTINATION" \
  -derivedDataPath "$DERIVED_DATA_PATH" \
  -clonedSourcePackagesDirPath "$APP_PATH" \
  -project "$APP_PATH/$APP_NAME.xcodeproj" \
  -scheme "$APP_NAME" \
  -toolchain Spoor

if ! find "$DERIVED_DATA_PATH" -name "*.spoor_symbols" | grep -q "."; then
  echo "No function maps were created."
  exit 1
fi

if ! nm -g "$BINARY_FILE_PATH" | grep -q "__spoor_runtime_"; then
  echo "The instrumented binary does not contain Spoor runtime symbols."
  exit 1
fi
