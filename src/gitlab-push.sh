#!/usr/bin/env bash

set -ex

if [[ -v "DEPLOY_USERNAME" && -v "DEPLOY_ACCESS_TOKEN" ]]
then
  if [[ "${CI_PROJECT_URL}" =~ (([^/]*/){3}) ]]; then
    mkdir -p "$HOME/.config/git"
    echo "${BASH_REMATCH[1]/:\/\//://${DEPLOY_USERNAME}:${DEPLOY_ACCESS_TOKEN}@}" > "$HOME/.config/git/credentials"
    git config --global credential.helper store
  fi
fi

git push "${DEPLOY_TARGET_REPOSITORY:-$CI_PROJECT_URL}" "HEAD:refs/heads/${DEPLOY_TARGET_BRANCH:-$CI_ENVIRONMENT_NAME}" $([[ -v "DEPLOY_FORCE_PUSH" && "true" == "${DEPLOY_FORCE_PUSH}" ]] && echo --force)
