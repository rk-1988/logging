#!/bin/sh -l

cf api "$CF_API"  # url access
cf auth "$CF_USERNAME" "$CF_PASSWORD"   # username and password access

#condition check
if [ -n "$CF_ORG" ] && [ -n "$CF_SPACE" ]; then
  cf target -o "$CF_ORG" -s "$CF_SPACE"
fi

#starting cf8 cli
sh -c "cf8 $*"   
