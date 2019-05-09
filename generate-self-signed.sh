#!/bin/bash

DOMAIN=${1-localhost}
VALID_DAYS=${2-365}
ALT_NAMES=${3-*.lcl} # comma delimited list of alt names
KEY_NAME=${4-${DOMAIN}_key.pem}
CERT_NAME=${5-${DOMAIN}_cert.pem}

OPENSSL_CONF=/etc/ssl/openssl.cnf
KEY_SIZE=4096

# insert "DNS:" at the start and after each comma to generate
# a list like DNS:example.com,DNS.other.com
ALT_NAMES=$(echo ${ALT_NAMES} | sed 's/^/DNS:/' | sed 's/,/,DNS:/')

# Generate the self signed cert for localhost
openssl req \
  -x509 -newkey rsa:${KEY_SIZE} \
  -subj "/CN=${DOMAIN}" \
  -nodes \
  -keyout ${KEY_NAME} \
  -out ${CERT_NAME} \
  -days ${VALID_DAYS} \
  -extensions SAN \
  -config <(cat ${OPENSSL_CONF} \
      <(printf "\n[SAN]\nsubjectAltName=${ALT_NAMES}")) \
