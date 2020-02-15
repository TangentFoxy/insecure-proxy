#!/usr/bin/env bash

set -e # exit on any failure

sudo docker build -t guard13007/insecure-proxy:latest .
sudo docker push guard13007/insecure-proxy:latest
