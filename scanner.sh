#!/bin/bash timeout 2 bash -c "</dev/tcp/127.0.0.1/30"; echo $?


#!/usr/bin/env bash
SERVER=google.com
PORT=80
</dev/tcp/$SERVER/$PORT
if [ "$?" -ne 0 ]; then
  echo "Connection to $SERVER on port $PORT failed"
  exit 1
else
  echo "Connection to $SERVER on port $PORT succeeded"
  exit 0
fi