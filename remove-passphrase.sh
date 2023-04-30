#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Usage: $0 <private key file> <passphrase>"
    exit 1
fi
private_key_file=$1
private_key_dir=$(dirname "$private_key_file")
private_key_base=$(basename "$private_key_file")
passphrase=$2
no_passphrase_file="$private_key_dir/${private_key_base%.*}-no-passphrase.${private_key_base##*.}"
ssh-keygen -p -N "" -f "$private_key_file" -P "$passphrase" -q
cp "$private_key_file" "$no_passphrase_file"
ssh-keygen -p -N "" -f "$no_passphrase_file" -P "$passphrase" -q
echo "$no_passphrase_file"
