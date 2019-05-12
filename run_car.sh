#!/bin/sh

carthage bootstrap --no-checkout
carthage checkout
carthage build --cache-builds
