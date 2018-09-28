###########################################
#                                         #
#           Aegis: A Docker IDE           #
# Author: Anderson Marcelino              #
# Email: anderson@andersonmarcelino.com.br#
#                                         #
###########################################

FROM debian:latest

RUN apt-get update && apt-get install -y \
      zsh \
      curl

ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

CMD zsh
