#!/bin/bash
set -e

#Download new image version
docker-compose -f docker-compose.yml -f docker-compose.prod.yml pull

docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

sh run.sh