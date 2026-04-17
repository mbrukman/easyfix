# Copyright 2025 Google LLC
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

function git_is_working_tree_clean() {
  git status | grep "nothing to commit, working tree clean" >& /dev/null 2>&1
}

function exit_if_working_tree_is_not_clean_when_starting() {
  if ! git_is_working_tree_clean ; then
    echo "'git status' shows there are modified or untracked files in the tree." >&2
    echo "'git status' should show: " >&2
    echo >&2
    echo "    nothing to commit, working tree clean" >&2
    echo >&2
    echo "Run this command from a clean working tree." >& 2
    exit 1
  fi
}

function exit_if_working_tree_is_clean_after_changes() {
  if git_is_working_tree_clean ; then
    echo "No files updated."
    exit 0
  fi
}
