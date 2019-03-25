#!/bin/bash
docker network create --driver=overlay --attachable server_network
docker stack deploy -c ../code_server_stack.yml csr
