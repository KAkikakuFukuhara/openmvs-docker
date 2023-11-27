#!/bin/bash
xhost +local:
docker-compose up -d
docker exec -it ntopenmvs-app bash
docker-compose down
xhost -local: