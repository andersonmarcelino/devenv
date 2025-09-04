# 🐳 DevEnv - Development Environment Container

A comprehensive Docker-based development environment with a fully configured Alpine Linux container, featuring modern development tools, editors, and utilities for productive software development.

## ✨ Features

### 🛠️ Development Tools
- **Docker Integration**: Full Docker CLI and Docker Compose support
- **Git & Version Control**: Git with advanced aliases and configurations
- **Editor**: Neovim with extensive plugin ecosystem
- **Shell**: Zsh with Oh My Zsh framework
- **Terminal Multiplexer**: tmux with custom configuration
- **Search Tools**: The Silver Searcher (ag) and fzf for fast file searching

### 🔧 Programming Language Support
- **Node.js & npm**: JavaScript/TypeScript development
- **Python 3**: With pip package manager
- **Ruby**: Via containerized execution
- **Multiple Language Plugins**: Vim plugins for JavaScript, Ruby, Elixir, Vue.js, and more

### 🎨 Editor Features (Neovim)
- **Plugin Manager**: Pathogen for plugin management
- **Code Intelligence**: Syntax highlighting, linting with Syntastic
- **Git Integration**: Fugitive for Git operations within editor
- **File Navigation**: NerdTree file explorer
- **Testing**: vim-test for running tests
- **AI Assistance**: GitHub Copilot integration
- **Color Scheme**: Solarized true color theme

### 🔒 Security & SSH
- **SSH Server**: Configured SSH daemon for remote access
- **GPG Support**: GNU Privacy Guard integration
- **Trezor Integration**: Hardware wallet support via trezor_agent
- **Key Management**: Automated SSH key setup

### 🌍 Networking & Display
- **X11 Forwarding**: GUI application support
- **Display Integration**: DISPLAY environment variable support
- **Network Tools**: socat, bind-tools for networking tasks

## 🚀 Quick Start

### Standard Container Mode
```bash
docker run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/workspace:/root/workspace \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /etc/localtime:/etc/localtime:ro \
  -e DISPLAY=$DISPLAY \
  -e WORKDIR=~/workspace \
  andersonmarcelino/devenv
```

### SSH Mode
```bash
docker run -it --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/workspace:/root/workspace \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$DISPLAY \
  -e WORKDIR=~/workspace \
  -p 22:22 \
  -v /etc/localtime:/etc/localtime:ro \
  andersonmarcelino/devenv -s tmux
```

### Linux Host Configuration
For Linux hosts, add network host access:
```bash
--network host
```

Enable X11 forwarding:
```bash
xhost +local:docker
```

## 🏗️ Building the Image

```bash
docker build . -t andersonmarcelino/devenv
```

## 📁 Project Structure

```
devenv/
├── Dockerfile              # Main container definition
├── readme.md               # Original documentation
├── dotfiles/               # Configuration files
│   ├── aliases             # Shell aliases
│   ├── gitconfig           # Git configuration
│   ├── tmux.conf           # tmux settings
│   ├── vimrc               # Neovim configuration
│   └── zshrc               # Zsh shell configuration
└── scripts/                # Utility scripts
    ├── entry.sh            # Container entry point
    ├── initconfig.sh       # Configuration initialization
    └── runin.sh            # Container execution wrapper
```

## ⚙️ Configuration

### Persistent Configuration
The container automatically manages persistent configuration through mounted volumes:

- **Shell History**: `~/workspace/.config/zsh_history`
- **SSH Keys**: `~/workspace/.config/ssh/`
- **GPG Keys**: `~/workspace/.config/gnupg/`
- **GitHub Copilot**: `~/workspace/.config/github-copilot/`
- **Git Config**: `~/workspace/.config/gitconfig.local`

### Git Aliases
Pre-configured Git aliases for efficient workflow:
- `g l` - Pretty log with graph
- `g s` - Short status
- `g cm <msg>` - Commit with message
- `g co <branch>` - Checkout branch
- `g pl` - Pull with rebase and autostash
- `g ps` - Push and set upstream

### Docker Aliases
Convenient aliases for Docker Compose operations:
- `dcup` - Docker compose up
- `dcstart/dcstop` - Start/stop services
- `dps` - Formatted container list
- `runin` - Execute commands in workspace container

## 🔌 Installed Packages

### Core System
- Alpine Linux 3.22
- Docker CLI & Compose
- Git with Perl extensions
- OpenSSH server

### Development Tools
- Neovim with 30+ plugins
- tmux terminal multiplexer
- fzf fuzzy finder
- The Silver Searcher (ag)
- Claude Code AI assistant

### Programming Languages
- Node.js & npm
- Python 3 with pip
- Support for Ruby, Elixir, JavaScript, TypeScript, Vue.js

## 🌐 Platform Support

- **✅ Linux**: Full support with host networking
- **✅ Windows**: Tested and working
- **🔧 macOS**: Should work with proper X11 setup

## 📝 Notes

- The container runs as root for maximum compatibility
- All configurations are designed to persist across container restarts
- The environment is optimized for development workflows
- Hardware security key support through Trezor integration

## 🤝 Contributing

This is a personal development environment container. Feel free to fork and customize for your own needs.

## 📄 License

Personal project - use at your own discretion.