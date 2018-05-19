#!/bin/bash -eu
#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Writing an easyfix transformation.

source "$(dirname $0)/../easyfix.sh" || exit 1

# Modifies files in-place using the primitives in `easyfix.sh`.
#
# Args:
#   $1: file to operate on
function fixSpelling() {
  replace "speling" "spelling" "$1"
}

# This function will be called once for every file returned from
# `findMatchingFiles`; you can either operate on all input files or do custom
# processing for different file types, or throw errors on unexpected files, if
# you wish.
#
# Args:
#   $1: file to operate on
function processFile() {
  # Only select files we're interested in, e.g., by extension
  case "$1" in
    *.md)
      fixSpelling "$1"
      ;;

    *)
      echo "Unrecognized file extension: $1" >&2
      ;;
  esac
}

# No arguments. Returns a list of files to process.
function findMatchingFiles() {
  grep -ri "speling" * | uniqueFiles
}

# Note: update the command below to literally list your filename. This is used
# to avoid actually running the file when included by the test script.
easyfix_run "spelling_fix.sh" "$@"
