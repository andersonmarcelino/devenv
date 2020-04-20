#!/bin/sh
docker exec workspace_${PWD##*/}_1 ${0##*/} $@
