#!/bin/sh
docker-compose stop
sh ./build-debug.sh 
docker-compose up -d
docker exec -i makewise-web dotnet publish -c Debug src/GiraffeWeb.fsproj