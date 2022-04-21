#!/bin/bash

set -euo pipefail

TEMP_DIRECTORY="$(mktemp -d)"
if [[ ! -d "$TEMP_DIRECTORY" ]]; then
    echo "Temporary directory not set up"
    exit 2
fi

docker image build -t emacs-27.2  - <<EOF
FROM silex/emacs:27.2-ci
RUN apt update && \
    apt install -q -yy \
    git \
    autoconf \
    automake \
    libpng-dev \
    zlib1g-dev \
    libpoppler-glib-dev \
    libpoppler-private-dev \
    imagemagick
EOF

docker run --rm -u $(id -u):$(id -g) -v "$PWD:/work" -v $TEMP_DIRECTORY:/home/user -e HOME=/home/user -w /work -it emacs-27.2  \
    emacs --batch -l ./bin/run-test.el
