# My Dev Env
#
# docker build . -t andersonmarcelino/devenv
# docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock andersonmarcelino/devenv
#


FROM debian:buster-slim
LABEL maintainer "Anderson Marcelino <anderson@andersonmarcelino.com.br>"

RUN apt-get update && apt-get install -y \
  zsh \
  curl \
  vim \
  git \
  tmux \
  wget

ENV DOCKERVERSION=18.03.1-ce
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz

RUN chsh -s $(which zsh)

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

COPY scripts/entry.sh /bin/entry.sh
RUN chmod +x /bin/entry.sh

COPY scripts/initconfig.sh /bin/initconfig
RUN chmod +x /bin/initconfig

COPY dotfiles/gitconfig /root/.gitconfig
COPY dotfiles/zshrc /root/.zshrc

WORKDIR /root/workspace

ENTRYPOINT ["/bin/entry.sh", "tmux"]
