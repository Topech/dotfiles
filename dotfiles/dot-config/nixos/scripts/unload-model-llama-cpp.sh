#!/usr/bin/env bash

LLAMA_CPP_URL=http://localhost:8080
MODEL="$1"
_MODEL_JSONIFIED='{"model":"'${MODEL}'"}'

curl -s -X POST ${LLAMA_CPP_URL}/models/unload \
  -H "Content-Type: application/json" \
  -d "${_MODEL_JSONIFIED}"

