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
  wget \
  procps \
  docker-compose \
  silversearcher-ag

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

COPY scripts/fakes/ruby /bin/ruby
RUN chmod +x /bin/ruby

COPY scripts/fakes/node /bin/node
RUN chmod +x /bin/node

COPY scripts/fakes/npm /bin/npm
RUN chmod +x /bin/npm

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

RUN mkdir /root/.vim
RUN mkdir /root/.vim/bundle
RUN mkdir /root/.vim/autoload

RUN curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

RUN cd /root/.vim/bundle \
 && git clone --depth 1 https://github.com/tpope/vim-sensible \
 && git clone --depth 1 https://github.com/tpope/vim-fugitive \
 && git clone --depth 1 https://github.com/tpope/vim-projectionist \
 && git clone --depth 1 https://github.com/mustache/vim-mustache-handlebars \
 && git clone --depth 1 https://github.com/blarghmatey/split-expander \
 && git clone --depth 1 https://github.com/ngmy/vim-rubocop \
 && git clone --depth 1 https://github.com/rking/ag.vim \
 && git clone --depth 1 https://github.com/sjl/vitality.vim \
 && git clone --depth 1 https://github.com/janko-m/vim-test \
 && git clone --depth 1 https://github.com/tpope/vim-bundler \
 && git clone --depth 1 https://github.com/ecomba/vim-ruby-refactoring \
 && git clone --depth 1 https://github.com/tpope/vim-endwise \
 && git clone --depth 1 https://github.com/tpope/vim-surround \
 && git clone --depth 1 https://github.com/tmhedberg/matchit \
 && git clone --depth 1 https://github.com/kana/vim-textobj-user \
 && git clone --depth 1 https://github.com/nelstrom/vim-textobj-rubyblock \
 && git clone --depth 1 https://github.com/vim-scripts/tComment \
 && git clone --depth 1 https://github.com/scrooloose/nerdtree \
 && git clone --depth 1 https://github.com/MarcWeber/vim-addon-mw-utils \
 && git clone --depth 1 https://github.com/tomtom/tlib_vim \
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
 && git clone --depth 1 https://github.com/henrik/vim-qargs \
 && git clone --depth 1 https://github.com/pangloss/vim-javascript \
 && git clone --depth 1 https://github.com/jelera/vim-javascript-syntax \
 && git clone --depth 1 https://github.com/jsx/jsx.vim \
 && git clone --depth 1 https://github.com/terryma/vim-expand-region \
 && git clone --depth 1 https://github.com/avdgaag/vim-phoenix \
 && git clone --depth 1 https://github.com/vim-scripts/PatternsOnText \
 && git clone --depth 1 https://github.com/yegappan/mru \
 && git clone --depth 1 https://github.com/posva/vim-vue \
 && git clone --depth 1 https://github.com/mattn/emmet-vim \
 && git clone --depth 1 https://github.com/maxbrunsfeld/vim-yankstack \
 && git clone --depth 1 https://github.com/junegunn/fzf.vim \
 && git clone --depth 1 https://github.com/briancollins/vim-jst

COPY dotfiles/gitconfig /root/.gitconfig
COPY dotfiles/zshrc /root/.zshrc
COPY dotfiles/tmux.conf /root/.tmux.conf
COPY dotfiles/vimrc /root/.vimrc

WORKDIR /root/workspace

ENV LANGUAGE pt_BR.UTF-8
ENV LANG pt_BR.UTF-8

ENTRYPOINT ["/bin/entry.sh", "tmux"]
