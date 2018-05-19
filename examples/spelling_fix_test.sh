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

# Testing an easyfix transformation.

source "$(dirname $0)/spelling_fix.sh" || exit 1
source "$(dirname $0)/../easyfix_testing.sh" || exit 2

# Ensures that no changes are made for given input.
#
# Args:
#   $1: input string
#   $2: expected output string
function run_test() {
  easyfix_run_test fixSpelling "$@"
}

# Ensures that no changes are made for given input.
#
# Args:
#   $1: input string
function run_test_no_change() {
  easyfix_run_test_no_change fixSpelling "$@"
}

# NOTE: see additional testing functions in `easyfix_testing.sh`, including:
#
# * easyfix_run_test_extension()
# * easyfix_run_test_extension_no_change()
#
# if you would like to test varying file extensions as well.

run_test "complex speling here" "complex spelling here"
run_test "who won the speling bee?" "who won the spelling bee?"

run_test_no_change "i already know how to spell"
run_test_no_change "spelling is my middle name"

echo 'PASSED'
