#!/bin/bash
# Git add all and commit with message.
function gitac() {
  git add --all &&
    git commit -m "$1"
}
