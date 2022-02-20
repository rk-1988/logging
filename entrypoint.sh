#!/bin/sh -l

cf api "$cf_api"  # url access
cf auth "$cf_username" "$cf_password"   # username and password access

#condition check
if [ -n "$cf_org" ] && [ -n "$cf_space" ]; then
  cf target -o "$cf_org" -s "$cf_space"
fi

#starting cf8 cli
sh -c "cf8 $*"   
