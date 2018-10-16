#!/usr/bin/env bash

if [[ -n ${GIT_USER_NAME} ]]; then
  echo "Setting git username to $GIT_USER_NAME"
  git config --global user.name $GIT_USER_NAME
fi
if [[ -n ${GIT_USER_EMAIL} ]]; then
  echo "Setting git email to $GIT_USER_NAME"
  git config --global user.email $GIT_USER_EMAIL
fi