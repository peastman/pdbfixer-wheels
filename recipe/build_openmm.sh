#!/bin/bash

set -ex

# Build the wheel
rm -rf dist
$PYTHON -m pip wheel . --wheel-dir=dist

# Copy the wheel to destination
for whl in dist/*.whl; do
  if [[ "$build_platform" == "osx-"* ]]; then
    WHL_DEST=$RECIPE_DIR/../build_artifacts/pypi_wheels
  elif [[ "$build_platform" == "linux-"* ]]; then
    WHL_DEST=/home/conda/feedstock_root/build_artifacts/pypi_wheels
  fi
  mkdir -p $WHL_DEST
  cp $whl $WHL_DEST
done

# Install the wheel
for whl in dist/*.whl; do
  $PYTHON -m pip install $whl
done
