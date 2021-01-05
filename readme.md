# [WIP]
Just it


to run the container
```bash
  docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/workspace:/root/workspace -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
    -e DISPLAY=$DISPLAY -e WORKDIR=~/workspace andersonmarcelino/devenv
```

to run with ssh
```
  docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/workspace:/root/workspace -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=$DISPLAY -e WORKDIR=~/workspace -p 22:22 \
    -v /etc/localtime:/etc/localtime:ro \
    andersonmarcelino/devenv -s tmux
```

FIX IT LAT
```bash
  xhost +local:docker
```
