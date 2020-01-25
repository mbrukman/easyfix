#!/bin/bash -eu
#
# Copyright 2020 Google LLC
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

# With the creation of Alphabet, Google Inc. was renamed to Google LLC:
#
# * https://techcrunch.com/2017/09/04/google-parent-alphabet-forms-holding-company-xxvi-to-complete-2015-corporate-reorganization/
# * https://www.fastcompany.com/40462340/alphabet-google-xxvi-holdings-restructuring-reorganization-transparency
#
# This script updates instances of "Google Inc." to "Google LLC" which are
# present in copyright header comments to match the new company structure.

source "$(dirname $0)/../easyfix.sh" || exit 1

# Args:
#   $1: file to operate on
function googleIncToLlc() {
  replace "Google Inc\\." "Google LLC" "$1"
}

# We will handle all filetypes, without exception.
#
# Args:
#   $1: file to operate on
function processFile() {
  googleIncToLlc "$1"
}

# No arguments. Returns a list of files to process.
function findMatchingFiles() {
  grep -ri "Google Inc\\." * | uniqueFiles
}

easyfix_run "google_inc_to_llc.sh" "$@"
