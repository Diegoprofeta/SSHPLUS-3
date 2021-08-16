#!/bin/bash
docker run \
  --name chisel -p 80:80 \
  -d --restart always \
  jpillora/chisel server -p 80 --socks5 --key supersecret --auth "teste:12345"
