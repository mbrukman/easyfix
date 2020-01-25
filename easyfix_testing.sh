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

# This script, upon being sourced, will create a temporary directory and
# schedule it for deletion upon program exit.

# Create temp directory.
readonly TMPDIR="$(mktemp -d /tmp/easyfix.XXXXXX)"

# Register cleanup on exit to remove directory.
trap "rm -rf ${TMPDIR}" EXIT SIGINT SIGTERM

# Runs a test to verify that the input is rewritten to match the expected
# output.
#
# Args:
#   $1: extension for temp files
#   $2: command to run
#   $3: input string
#   $4: expected output string
easyfix_run_test_extension() {
  local ACTUAL="${TMPDIR}/actual$1"
  local EXPECTED="${TMPDIR}/expected$1"

  echo -e -n "$3" > "${ACTUAL}"
  echo -e -n "$4" > "${EXPECTED}"

  $2 "${ACTUAL}"

  diff "${EXPECTED}" "${ACTUAL}" || {
    echo
    echo "Expected: [$(cat ${EXPECTED})]"
    echo "  Actual: [$(cat ${ACTUAL})]"
    echo
    echo "While testing: [$3]"
    echo "           ->  [$4]"
    echo
    echo "FAILED"
    exit 1
  }
}

# Runs a test with default (i.e., empty) extension to the tempfiles.
#
# Args:
#   $1: command to run
#   $2: input string
#   $3: expected output string
easyfix_run_test() {
  easyfix_run_test_extension "" "$@"
}

# Runs a test expecting the input to be unchanged.  Since the input is the same
# as the expected output, we have only 2 arguments to this function.
#
# Args:
#   $1: extension for temp files
#   $2: command to run
#   $3: input string
easyfix_run_test_extension_no_change() {
  easyfix_run_test_extension "$1" "$2" "$3" "$3"
}

# Runs a test as above, with default (i.e., empty) extension on the tempfiles.
#
# Args:
#   $1: command to run
#   $2: input string
easyfix_run_test_no_change() {
  easyfix_run_test_extension_no_change "" "$@"
}
