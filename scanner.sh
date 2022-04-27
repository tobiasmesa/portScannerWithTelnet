#!/bin/bash
HOST = 127.0.0.1
PORT = 23
timeout 2 bash -c "</dev/tcp/${HOST}/${PORT}"; echo $?