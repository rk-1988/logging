#!/bin/sh -l

cf8 api "$INPUT_API"
cf8 auth "$INPUT_USERNAME" "$INPUT_PASSWORD"

if [ -n "$INPUT_ORG" ] && [ -n "$INPUT_SPACE" ]; then
  cf8 target -o "$INPUT_ORG" -s "$INPUT_SPACE"
fi

sh -c "cf8 $*"
