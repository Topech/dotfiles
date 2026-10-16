#!/usr/bin/env bash

LLAMA_CPP_URL=http://localhost:8080

curl -s ${LLAMA_CPP_URL}/models | jq '.data[] | select(.status.value == "loaded") | .id'


