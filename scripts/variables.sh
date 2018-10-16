#!/usr/bin/env bash

if [[ -f .additional-variables ]]; then
  cat .additional-variables >> ~/.zprofile
fi
