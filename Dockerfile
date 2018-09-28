###########################################
#                                         #
#           Aegis: A Docker IDE           #
# Author: Anderson Marcelino              #
# Email: anderson@andersonmarcelino.com.br#
#                                         #
###########################################

FROM debian:latest

RUN apt-get update && apt-get install -y \
      zsh

CMD zsh
