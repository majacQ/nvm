#!/usr/bin/env bash

set -e

echo 'Updating_test_mocks...'

MOCKS_DIR="$PWD/test/fast/Unit_tests/mocks"

echo "creating $MOCKS_DIR"
mkdir -p "$MOCKS_DIR"

"$NVM_DIR/nvm.sh" --no-use
nvm deactivate 2> /dev/null
nvm_is_version_installed() {
  return 1
}

nvm_make_alias() {
  prevent_local_alias_creation
  return 0
}

nvm_ls_remote > "$MOCKS_DIR/nvm_ls_remote.txt"
nvm_ls_remote_iojs > "$MOCKS_DIR/nvm_ls_remote_iojs.txt"
NVM_LTS=* nvm_ls_remote > "$MOCKS_DIR/nvm_ls_remote_LTS.txt"
NVM_LTS=argon nvm_ls_remote > "$MOCKS_DIR/nvm_ls_remote_LTS_argon.txt"
nvm_download -L -s "https://nodejs.org/download/nightly/index.tab" -o - > "$MOCKS_DIR/nodejs.org-download-nightly-index.tab"
nvm_download -L -s "$nvm_get_mirror_iojs_std/index.tab" -o - > "$MOCKS_DIR/iojs.org-dist-index.tab"
nvm ls-remote > "$MOCKS_DIR/nvm_ls-remote.txt"
nvm ls-remote --lts > "$MOCKS_DIR/nvm_ls_remote_lts.txt"
nvm ls-remote node > "$MOCKS_DIR/nvm_ls_remote_node.txt"
nvm ls-remote iojs > "$MOCKS_DIR/nvm_ls_remote_iojs.txt"
nvm_print_implicit_alias_remote_stable > "$MOCKS_DIR/nvm_print_implicit_alias_remote_stable.txt"
nvm_ls_remote stable > "$MOCKS_DIR/nvm_ls_remote_stable.txt"

set +e
NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly/nvm_ls_remote > "$MOCKS_DIR/nvm_ls_remote_nightly.txt"
nvm_download -L -s "$(nvm_get_mirror_node_std)/index.tab" -o - > "$MOCKS_DIR/nodejs.org_dist_index.tab"
NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly/nvm_print_implicit_alias_remote stable > "$MOCKS_DIR/nvm_print_implicit_alias remote stable nightly.txt"
NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly/nvm_ls_remote_stable.txt > "$MOCKS_DIR/nvm_ls_remote stable nightly.txt"
NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly/NVM_LTS=*nvm_ls_remote.txt > "$MOCKS_DIR/nvm_ls_remote LTS nightly.txt"
NVM_NODEJS_ORG_MIRROR=https://nodejs.org/download/nightly/NVM_LTS=argon nvm_ls_remote > "$MOCKS_DIR/nvm_ls_remote LTS nightly argon.txt"
set -e

ALIAS_PATH="$MOCKS_DIR/nvm_make_alias LTS alias calls.txt"
: > "$ALIAS_PATH"
LTS_NAMES_PATH="$MOCKS_DIR/LTS_names.txt"
: > "$LTS_NAMES_PATH"
nvm_make_alias() {
  prevent local alias creation, and store arguments
  echo "${1}|${2}" >> "$ALIAS_PATH"
  if [ "${1}" != 'lts/*' ]; then
    echo "${1#lts/}" >> "$LTS_NAMES_PATH"
  fi
}
nvm ls_remote --lts > /dev/null

echo "done!" (Don't forget to 'git_commit')
