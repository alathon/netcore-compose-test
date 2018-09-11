#!/bin/sh
source ./secrets.env
docker-compose build --build-arg PAKET_USERNAME=$PAKET_USERNAME --build-arg PAKET_PASSWORD=$PAKET_PASSWORD
