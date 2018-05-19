# Copyright 2011 Google Inc.
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

# This script is non-executable because it should be sourced into other scripts.

# Replaces $1 with $2 in file $3: hashes not allowed in either $1 or $2.
#
# Args:
#   $1: original text
#   $2: replacement text
#   $3: file to modify in-place
replace() {
  perl -pi -e "s#$1#$2#g" "$3"
}

# Same as above, except supports multiline.
#
# Args:
#   $1: original text
#   $2: replacement text
#   $3: file to modify in-place
replaceMultiLine() {
  perl -pi -e "BEGIN{undef \$/;} s#$1#$2#smg" "$3"
}

# A different version of the same, that allows replacing with hashes, but not
# slashes.
replaceHash() {
  perl -pi -e "s/$1/$2/" "$3"
}

# Deletes lines matching $1 in file $2
deleteLines() {
  perl -ni -e "print unless /$1/" "$2"
}

uniqueFiles() {
  sed 's/:.*//' | sort | uniq
}

findBUILD() {
  find $1 -name BUILD
}

findCPP() {
  find $1 -name \*\.h
  find $1 -name \*\.cc
}

findPython() {
  find $1 -name \*\.py
}

die_error() {
  echo "$(basename $0): $@" >&2
  exit 1
}

checkPwdIsGoogle3() {
  if [ "$(basename $(pwd))" != "google3" ]; then
    die_error "must run this script from the google3 directory"
  fi
}

# Selects the correct Perforce-interacting binary.
# Currently supports: c4, g4, v4 as well as git5.
x4() {
  if [ -d "../.git" ]; then   # git5
    case $1 in
      open|revert)  # Ignored for git5
        ;;
      *)            # Unknown: must add a handler
        die_error "unhandled command for git5: $1"
    esac
  elif [[ $(pwd) =~ ^/google/code/$USER/ ]]; then
    v4 "$@"
  else
    g4 "$@"
  fi
}

# Opens a single file in for editing, unless it's already writable.
openFile() {
  if [ ! -w "$1" ]; then
    checkPwdIsGoogle3
    x4 open "$1"
  fi
}

# Open a list of files for editing.
openFiles() {
  checkPwdIsGoogle3
  x4 open "$@"
}

# Reverts open unmodified files.
revertUnchangedFiles() {
  checkPwdIsGoogle3
  x4 revert -a
}

# Main entry point: run the actual test rewriting.
# Depends on the user having defined two functions:
#
# * findMatchingFiles() - returns a list of google3-relative paths to process
# * processFile(file) - handles in-place rewrite of given file
#
# Args:
#   $1: name of the current module
easyfix_run() {
  # Only run this script if we're the main file being invoked; otherwise,
  # we might be sourced into another script for testing.  This is similar to the
  # Python idiom:
  #
  # if __name__ == '__main__'
  #   app.run()
  #
  if [ "$(basename $0)" != "$1" ]; then
    return
  fi
  shift

  local items="$@"
  if [ $# -eq 0 ]; then
    items="$(findMatchingFiles)"
  fi

  for item in ${items}; do
    if [ -d "$item" ]; then
      local files="$(findMatchingFiles $item)"
      if [ -z "${files}" ]; then
        continue;
      fi
      for file in ${files}; do
        processFile "${file}"
      done
    elif [ -f "${item}" ]; then
      processFile "${item}"
    else
      die_error "Unrecognized: ${item} is neither a file nor directory."
    fi
  done

  revertUnchangedFiles
}
