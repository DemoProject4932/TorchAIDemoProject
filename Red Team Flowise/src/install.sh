#!/bin/bash

curl -fsSL https://ollama.com/install.sh | sh
sleep 3

ollama pull llama3

npm install -g flowise

ollama serve &
sleep 5

flowise start &

