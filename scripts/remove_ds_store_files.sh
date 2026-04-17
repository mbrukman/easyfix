#!/bin/bash -eu
#
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

source "$(dirname $0)/common.sh"

exit_if_working_tree_is_not_clean_when_starting

declare -a DS_STORE_FILES=$(find . -name \.DS_Store)
if [[ ${#DS_STORE_FILES[@]} -eq 0 ]]; then
  echo "No .DS_Store files found."
  exit 0
fi

git checkout -b remove-ds-store-files
find . -type f -name \.DS_Store -print0 | xargs -0 rm 
git add -u
git commit -m "$(cat << EOF
Remove \`.DS_Store\` files

\`.DS_Store\` is a hidden auto-created file on macOS, stores directory attributes.
For more info, see: https://en.wikipedia.org/wiki/.DS_Store
EOF)"
