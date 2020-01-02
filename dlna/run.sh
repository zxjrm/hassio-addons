#!/bin/sh
CONFIG_PATH=/data/options.json
DLNA_NAME="$(jq --raw-output '.dlna_name' $CONFIG_PATH)"
gmediarender -f "$DLNA_NAME"