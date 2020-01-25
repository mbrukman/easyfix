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

source "$(dirname $0)/google_inc_to_llc.sh" || exit 1
source "$(dirname $0)/../easyfix_testing.sh" || exit 2

# Ensures that no changes are made for given input.
#
# Args:
#   $1: input string
#   $2: expected output string
function run_test() {
  easyfix_run_test googleIncToLlc "$@"
}

# Ensures that no changes are made for given input.
#
# Args:
#   $1: input string
function run_test_no_change() {
  easyfix_run_test_no_change googleIncToLlc "$@"
}

run_test "Copyright 2019 Google Inc." "Copyright 2019 Google LLC"

run_test_no_change "Copyright 2019 Google LLC"
run_test_no_change "Copyright 2019 Acme Inc."

echo 'PASSED'
