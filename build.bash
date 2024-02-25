#!/bin/bash

cd ./frontend;
npm run build;

cd ../backend/;
cargo build --release;

cd ..;
DOCKER_BUILDKIT=0 docker build -t latterletters .;