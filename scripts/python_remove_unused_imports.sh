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

# Remove unused imports.
python -m ruff check --select=F401 --fix

exit_if_working_tree_is_clean_after_changes

git checkout -b python-remove-unused-imports
git add -u
git commit -m "$(cat <<EOF
Remove unused Python imports

Change generated using [ruff](https://docs.astral.sh/ruff/) via:

\`\`\`
python -m ruff check --select=F401 --fix
\`\`\`
EOF)"
