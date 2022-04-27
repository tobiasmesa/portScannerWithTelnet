#!/bin/bash

timeout $TIMEOUT_SECONDS bash -c "</dev/tcp/${HOST}/${PORT}"; echo $?