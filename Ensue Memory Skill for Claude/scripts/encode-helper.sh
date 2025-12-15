#!/bin/bash
# Helper script for base64 encoding/decoding

if [ "$1" == "encode" ]; then
    echo "$2" | base64
elif [ "$1" == "decode" ]; then
    echo "$2" | base64 -d
else
    echo "Usage:"
    echo "  $0 encode 'your text here'    # Encode text to base64"
    echo "  $0 decode 'base64string'      # Decode base64 to text"
fi
