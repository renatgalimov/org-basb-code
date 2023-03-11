#!/bin/bash

set -euo pipefail

TEMP_DIRECTORY="$(mktemp -d)"
if [[ ! -d "$TEMP_DIRECTORY" ]]; then
    echo "Temporary directory not set up"
    exit 2
fi

docker image build --progress=plain -t emacs-28.1  - <<EOF
FROM alpine:3
RUN apk update && \
    apk add ca-certificates emacs imagemagick git autoconf automake libpng-dev zlib-dev poppler-dev
EOF

# RUN apt update && \
#     apt install -q -yy \
#     git \
#     autoconf \
#     automake \
#     libpng-dev \
#     zlib1g-dev \
#     libpoppler-glib-dev \
#     libpoppler-private-dev \
#     imagemagick


docker run --rm -u $(id -u):$(id -g) -v "$PWD:/work" -v test-emacs-28:/home/user -e HOME=/home/user -w /work -it emacs-28.1  \
    emacs --batch -l ./bin/run-test.el
