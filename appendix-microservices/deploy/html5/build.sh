#!/bin/bash

rm -rf src
cp -rp ../../apps/html5/src .

sudo podman build -t do180/todo_frontend . 

