# My Dev Env
#
# docker build . -t andersonmarcelino/devenv
# docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock andersonmarcelino/devenv
#

FROM docker/compose:alpine-1.26.0-rc2

RUN apk add --no-cache \
    zsh \
    bash \
    bash-completion \
    findutils \
    curl \
    perl \
    git \
    git-perl \
    tmux \
    wget \
    procps \
    the_silver_searcher \
    libice \
    libsm \
    libx11 \
    libxt \
    ncurses \
    libffi-dev \
    openssl-dev \
    libgcc \
    openssh \
    openssh-keygen \
    neovim \
    xclip \
    gnupg \
    python3-dev \
    tig \
    socat \
    bind-tools

RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# enable ssh
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin\ yes/' /etc/ssh/sshd_config \
  && rm -rf /var/cache/apk/* \
  && sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config \
  && sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config \
  && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config \
  && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config \
  && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config \
  && sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config \
  && /usr/bin/ssh-keygen -A \
  && ssh-keygen -t rsa -b 4096 -f  /etc/ssh/ssh_host_key

ENV SHELL /bin/zsh

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

COPY scripts/runin.sh /bin/runin.sh
RUN chmod +x /bin/runin.sh \
 && ln -s /bin/runin.sh /bin/node \
 && ln -s /bin/runin.sh /bin/npm \
 && ln -s /bin/runin.sh /bin/ruby \
 && ln -s /bin/runin.sh /bin/yarn \
 && ln -s /bin/runin.sh /bin/bundle


RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install
RUN cp ~/.fzf/bin/fzf /bin/fzf

RUN mkdir /root/.config
RUN mkdir /root/.config/nvim
RUN mkdir /root/.config/nvim/bundle
RUN mkdir /root/.config/nvim/autoload

RUN curl -LSso /root/.config/nvim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN cd /root/.config/nvim/bundle \
 && git clone --depth 1 https://github.com/tpope/vim-sensible \
 && git clone --depth 1 https://github.com/tpope/vim-fugitive \
 && git clone --depth 1 https://github.com/tpope/vim-projectionist \
 && git clone --depth 1 https://github.com/ngmy/vim-rubocop \
 && git clone --depth 1 https://github.com/rking/ag.vim \
 && git clone --depth 1 https://github.com/janko-m/vim-test \
 && git clone --depth 1 https://github.com/tpope/vim-endwise \
 && git clone --depth 1 https://github.com/tpope/vim-surround \
 && git clone --depth 1 https://github.com/tmhedberg/matchit \
 && git clone --depth 1 https://github.com/vim-scripts/tComment \
 && git clone --depth 1 https://github.com/scrooloose/nerdtree \
 && git clone --depth 1 https://github.com/MarcWeber/vim-addon-mw-utils \
 && git clone --depth 1 https://github.com/skwp/greplace.vim \
 && git clone --depth 1 https://github.com/vim-ruby/vim-ruby \
 && git clone --depth 1 https://github.com/elixir-lang/vim-elixir \
 && git clone --depth 1 https://github.com/scrooloose/syntastic \
 && git clone --depth 1 https://github.com/tpope/vim-haml \
 && git clone --depth 1 https://github.com/dkprice/vim-easygrep \
 && git clone --depth 1 https://github.com/tpope/vim-rails \
 && git clone --depth 1 https://github.com/frankier/neovim-colors-solarized-truecolor-only \
 && git clone --depth 1 https://github.com/myusuf3/numbers.vim \
 && git clone --depth 1 https://github.com/christoomey/vim-tmux-navigator \
 && git clone --depth 1 https://github.com/jgdavey/tslime.vim \
 && git clone --depth 1 https://github.com/pangloss/vim-javascript \
 && git clone --depth 1 https://github.com/jelera/vim-javascript-syntax \
 && git clone --depth 1 https://github.com/jsx/jsx.vim \
 && git clone --depth 1 https://github.com/avdgaag/vim-phoenix \
 && git clone --depth 1 https://github.com/vim-scripts/PatternsOnText \
 && git clone --depth 1 https://github.com/yegappan/mru \
 && git clone --depth 1 https://github.com/posva/vim-vue \
 && git clone --depth 1 https://github.com/mattn/emmet-vim \
 && git clone --depth 1 https://github.com/maxbrunsfeld/vim-yankstack \
 && git clone --depth 1 https://github.com/junegunn/fzf.vim \
 && git clone --depth 1 https://github.com/briancollins/vim-jst


RUN apk add --no-cache --virtual .build-deps \
    libusb-dev \
    eudev-dev \
    musl-dev \
    make \
    gcc

RUN pip3 install setuptools wheel attrs
RUN pip3 install trezor_agent

RUN apk del .build-deps

COPY scripts/entry.sh /bin/entry.sh
RUN chmod +x /bin/entry.sh

COPY scripts/initconfig.sh /bin/initconfig
RUN chmod +x /bin/initconfig


COPY dotfiles/gitconfig /root/.gitconfig
COPY dotfiles/zshrc /root/.zshrc
COPY dotfiles/aliases /root/.aliases
COPY dotfiles/tmux.conf /root/.tmux.conf
COPY dotfiles/vimrc /root/.config/nvim/init.vim

ENV LANGUAGE pt_BR.UTF-8
ENV LANG pt_BR.UTF-8

WORKDIR /root/workspace

ENTRYPOINT ["/bin/entry.sh"]
CMD ["tmux"]
