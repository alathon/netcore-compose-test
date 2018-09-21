#!/bin/sh
source ./secrets.env
docker build -f Dockerfile.release \
  --build-arg PAKET_URL=$PAKET_URL \
  --build-arg PAKET_USERNAME=$PAKET_USERNAME \
  --build-arg PAKET_PASSWORD=$PAKET_PASSWORD \
  -t makewise/web .