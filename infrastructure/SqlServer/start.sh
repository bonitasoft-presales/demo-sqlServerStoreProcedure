#!/usr/bin/env sh
./stop.sh
docker-compose pull
docker-compose build
docker-compose up -d