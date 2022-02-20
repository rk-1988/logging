#!/bin/sh -l

set -eu
cf_opts=
if [ "x${INPUT_VALIDATE}" = "xfalse" ]; then
  cf_opts="--skip-ssl-validation"
fi
cf api ${INPUT_API} ${cf_opts}
CF_USERNAME=${INPUT_USERNAME} CF_PASSWORD=${INPUT_PASSWORD} cf auth
cf target -o ${INPUT_ORG} -s ${INPUT_SPACE}
cf push -f ${INPUT_MANIFEST}

#starting cf8 cli
sh -c "cf8 $*"   










#cf api "$cf_api"  # url access
#cf auth "$cf_username" "$cf_password"   # username and password access

#condition check
#if [ -n "$cf_org" ] && [ -n "$cf_space" ]; then
#  cf target -o "$cf_org" -s "$cf_space"
#fi

#starting cf8 cli
#sh -c "cf8 $*"   
