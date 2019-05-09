#!/bin/bash

### Expected env vars
## These get passed, in order, to the generate script
## you must specify the previous one if you want to use the current one
## IE: must specify DOMAIN if you want to use VALID_DAYS
# DOMAIN - the domain name for the cert - default: localhost
# VALID_DAYS - lifetime of the cert: default 365
# ALT_NAMES - a comma delimited list of alt domain names the cert is valid for: default "*.lcl"

./generate-self-signed.sh ${DOMAIN} ${VALID_DAYS} ${ALT_NAMES}

# this is the command run by (https://github.com/nginxinc/docker-nginx/tree/master/mainline/alpine)
# we're just going to do exactly what that does, only with the cert generation above
nginx -g "daemon off;"

