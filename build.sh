#!/bin/sh
source ./secrets.env
docker-compose stop
docker-compose build --build-arg PAKET_URL=$PAKET_URL --build-arg PAKET_USERNAME=$PAKET_USERNAME --build-arg PAKET_PASSWORD=$PAKET_PASSWORD
