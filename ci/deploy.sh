#!/bin/bash
set -e

#Download new image version
docker-compose -f docker-compose.yml -f docker-compose.prod.yml pull

docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

docker exec -t guestbook_guestbook_1 bash -c "symfony console doctrine:database:drop --force || true"
docker exec -t guestbook_guestbook_1 bash -c "symfony console doctrine:database:create"
docker exec -t guestbook_guestbook_1 bash -c "symfony console doctrine:migration:migrate -n"
docker exec -t guestbook_guestbook_1 bash -c "symfony console doctrine:fixtures:load -n"

sh run.sh