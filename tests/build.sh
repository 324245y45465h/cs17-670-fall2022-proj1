#!/bin/bash

WAT2WASM=$(which wat2wasm)

if [[ ! -x $WAT2WASM ]]; then
   echo Error: wat2asm not found in PATH
   exit 1
fi

for f in *.wat; do
    wat2wasm $f
done
