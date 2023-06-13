#!/bin/bash
set -e

# https://github.com/evanw/esbuild/issues/1511

# yarn build --watch < /dev/zero & yarn build:css --watch & bundle exec rails s -b 0.0.0.0
yarn build --watch < /dev/zero & yarn build:css --watch
