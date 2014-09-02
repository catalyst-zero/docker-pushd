#!/bin/bash

# For now, we just inject these files from the ENV
if [ ! -z "$FILE_CERT_PEM" ]; then
	echo "$FILE_CERT_PEM" > /opt/pushd/cert.pem
fi

if [ -z "$FILE_KEY_PEM" ]; then
	echo "$FILE_KEY_PEM" > /opt/pushd/key.pem
fi

coffee /opt/pushd/pushd.coffee $*
