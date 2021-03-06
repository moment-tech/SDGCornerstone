#!/bin/bash

#

set -e
REPOSITORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${REPOSITORY}"
if workspace version > /dev/null 2>&1 ; then
    echo "Using system install of Workspace..."
    workspace refresh $1 $2 $3 $4 •use‐version 0.30.2
elif ~/Library/Caches/ca.solideogloria.Workspace/Versions/0.30.2/workspace version > /dev/null 2>&1 ; then
    echo "Using system cache of Workspace..."
    ~/Library/Caches/ca.solideogloria.Workspace/Versions/0.30.2/workspace refresh $1 $2 $3 $4 •use‐version 0.30.2
elif ~/.cache/ca.solideogloria.Workspace/Versions/0.30.2/workspace version > /dev/null 2>&1 ; then
    echo "Using system cache of Workspace..."
    ~/.cache/ca.solideogloria.Workspace/Versions/0.30.2/workspace refresh $1 $2 $3 $4 •use‐version 0.30.2
elif .build/SDG/Workspace/workspace version > /dev/null 2>&1 ; then
    echo "Using repository cache of Workspace..."
    .build/SDG/Workspace/workspace refresh $1 $2 $3 $4 •use‐version 0.30.2
else
    echo "No cached build detected, fetching Workspace..."
    export OVERRIDE_INSTALLATION_DIRECTORY=.build/SDG
    curl -sL https://gist.github.com/SDGGiesbrecht/4d76ad2f2b9c7bf9072ca1da9815d7e2/raw/update.sh | bash -s Workspace "https://github.com/SDGGiesbrecht/Workspace" 0.30.2 "" workspace
    .build/SDG/Workspace/workspace refresh $1 $2 $3 $4 •use‐version 0.30.2
fi
