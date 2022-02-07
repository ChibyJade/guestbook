docker exec -t guestbook_guestbook_1 bash -c "kill `ps aux | grep -F 'symfony' | grep -v -F 'grep' | awk '{ print $2 }'`"

docker exec -t guestbook_guestbook_1 bash -c "symfony run -d symfony console messenger:consume async"