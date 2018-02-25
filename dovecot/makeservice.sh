#!/bin/bash

# Run as root in the same directory as the Dockerfile

# Create image
docker build -t dovecot:0.0.1 .

# Create east-west and multicast network
docker network create \
            --opt encrypted \
            --subnet 10.0.0.0/24 \
            --subnet 224.0.0.0/24 \
            --driver overlay \
            dovecot 

# Create volume for dovecot
docker volume create dovecot
docker volume create dynamic
docker volume create home

# Create service
docker service create \
            --mode global \
            --update-delay 60s \
            --update-parallelism 1 \
            --dns 8.8.8.8 \
            --dns 9.9.9.9 \
            --network dovecot \
            --mount source=dovecot,target=/var/log/dovecot \
            --mount source=dovecot,target=/usr/share/example/bk/,readonly \
            --mount source=dynamic,target=/dynamic/ \
            --mount source=home,target=/home/ \
            --name "dovecot" \
            --publish published=993,target=993,protocol=tcp \
            dovecot:0.0.1


