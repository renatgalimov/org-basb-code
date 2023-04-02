#!/bin/sh

set -xeuo pipefail

CLEANUP=
# If number of arguments is 0
if [ $# -eq 0 ]; then
    # Run all tests
    TEMP_HOME="$(mktemp -d)"
    CLEANUP=1
else
    # Run tests specified as arguments
    TEMP_HOME="$1"
fi

# We do tests twice to ensure that it can load after the initial setup
HOME="$TEMP_HOME" emacs --batch -l ./bin/run-test.el
HOME="$TEMP_HOME" emacs --batch -l ./bin/run-test.el

if [ -n "$CLEANUP" ]; then
    rm -rf "$TEMP_HOME"
fi
