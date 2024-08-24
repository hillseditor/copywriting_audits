#!/bin/sh
cat ~/.ssh/hub/tk.txt | docker login --username hillseditor --password-stdin
docker pull hillseditor/dp
docker compose build
docker logout
sleep 10
docker compose up -d
