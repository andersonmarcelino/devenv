#!/bin/sh
docker exec workspace-${PWD##*/}-1 ${0##*/} $@
