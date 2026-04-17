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

# Replaces text such as:
#
#     ```
#     @misc{paper00author,
#       author = '...',
#       title = '...',
#       ...
#     }
#     ```
#
# with:
#
#     ```bibtex
#     @misc{paper00author,
#       author = '...',
#       title = '...',
#       ...
#     }
#     ```
#
# which adds syntax highlighting to Markdown, which improves readability when
# rendered to HTML.

source "$(dirname $0)/common.sh"

exit_if_working_tree_is_not_clean_when_starting

# Note: this syntax is Markdown-specific; for ReST or AsciiDoc, we may need
# different changes.
declare -r FILES="${@:-README.md}"
perl -0pi -e 's/(```)\n(@[a-z]+\s*{)/\1bibtex\n\2/g' "${FILES}"

exit_if_working_tree_is_clean_after_changes

git checkout -b add-bibtex-syntax-highlighting
git add -u
git commit -m "$(cat <<EOF
Added BibTeX syntax highlighting to improve readability.
EOF)"
