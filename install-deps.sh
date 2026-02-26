#!/usr/bin/env bash
# ==============================================================================
# KriawqVim — Script de instalação de dependências de sistema
# Suporta: Arch Linux, Fedora, Debian/Ubuntu, Void Linux
# ==============================================================================

set -e

# ------------------------------------------------------------------------------
# Cores e helpers
# ------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[ OK ]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERR ]${NC} $*" >&2; }
skip()    { echo -e "${DIM}[SKIP]${NC} $*"; }
optional(){ echo -e "${CYAN}[OPT ]${NC} $*"; }
section() {
  echo -e "\n${BOLD}${BLUE}════════════════════════════════════════${NC}"
  echo -e "${BOLD}${BLUE}  $*${NC}"
  echo -e "${BOLD}${BLUE}════════════════════════════════════════${NC}"
}

command_exists() { command -v "$1" &>/dev/null; }

# ------------------------------------------------------------------------------
# Banner
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}${BLUE}"
echo '██╗  ██╗██████╗ ██╗ █████╗ ██╗    ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗'
echo '██║ ██╔╝██╔══██╗██║██╔══██╗██║    ██║██╔═══██╗██║   ██║██║████╗ ████║'
echo '█████╔╝ ██████╔╝██║███████║██║ █╗ ██║██║   ██║██║   ██║██║██╔████╔██║'
echo '██╔═██╗ ██╔══██╗██║██╔══██║██║███╗██║██║▄▄ ██║╚██╗ ██╔╝██║██║╚██╔╝██║'
echo '██║  ██╗██║  ██║██║██║  ██║╚███╔███╔╝╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║'
echo '╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚══╝╚══╝  ╚══▀▀═╝   ╚═══╝  ╚═╝╚═╝     ╚═╝'
echo -e "${NC}"
echo -e "${BOLD}  Instalação de Dependências${NC}"
echo ""

# ------------------------------------------------------------------------------
# Modo automático vs interativo
# ------------------------------------------------------------------------------
AUTO_MODE=false

ask_mode() {
  echo -e "Como você quer executar a instalação?\n"
  echo -e "  ${BOLD}[A]${NC} Automático  — instala tudo sem perguntar"
  echo -e "  ${BOLD}[I]${NC} Interativo  — pergunta antes de cada dependência ${DIM}(padrão)${NC}"
  echo -e "  ${BOLD}[O]${NC} Só opcionais — pula tudo obrigatório, pergunta apenas os opcionais\n"
  read -r -p "$(echo -e "${YELLOW}Escolha [a/I/o]: ${NC}")" MODE_CHOICE

  case "${MODE_CHOICE,,}" in
    a|auto) AUTO_MODE=true
      info "Modo automático ativado. Tudo será instalado sem confirmação.\n" ;;
    o|opt|opcionais) AUTO_MODE=false; ONLY_OPTIONAL=true
      info "Modo opcionais. Apenas os opcionais serão perguntados.\n" ;;
    *) AUTO_MODE=false
      info "Modo interativo ativado. Você será consultado antes de cada passo.\n" ;;
  esac
}
ONLY_OPTIONAL=false

# confirm <descrição> <comando_a_exibir> [optional]
confirm() {
  local description="$1"
  local cmd_display="$2"
  local is_optional="${3:-false}"

  if [ "$is_optional" = "false" ] && [ "$ONLY_OPTIONAL" = "true" ]; then
    return 1
  fi

  if [ "$AUTO_MODE" = true ]; then
    return 0
  fi

  local prefix="${BOLD}▸${NC}"
  [ "$is_optional" = "true" ] && prefix="${CYAN}◆ [OPCIONAL]${NC}"

  echo -e "\n${prefix} ${description}"
  echo -e "  ${DIM}Comando:${NC} ${CYAN}${cmd_display}${NC}"
  read -r -p "$(echo -e "  ${YELLOW}Instalar? [Y/n]: ${NC}")" REPLY

  case "${REPLY,,}" in
    n|no|nao|não) return 1 ;;
    *)            return 0 ;;
  esac
}

# ------------------------------------------------------------------------------
# Detectar distro
# ------------------------------------------------------------------------------
detect_distro() {
  if [ -f /etc/os-release ]; then
    # shellcheck source=/dev/null
    . /etc/os-release
    DISTRO_ID="${ID}"
    DISTRO_LIKE="${ID_LIKE:-}"
  else
    error "Não foi possível detectar a distribuição Linux."
    exit 1
  fi

  case "$DISTRO_ID" in
    arch|manjaro|endeavouros|garuda|cachyos)
      PKG_MANAGER="arch" ;;
    fedora|rhel|centos|almalinux|rocky)
      PKG_MANAGER="fedora" ;;
    debian|ubuntu|linuxmint|pop|elementary|kali|zorin|neon)
      PKG_MANAGER="debian" ;;
    void)
      PKG_MANAGER="void" ;;
    *)
      case "$DISTRO_LIKE" in
        *arch*)            PKG_MANAGER="arch"   ;;
        *fedora*|*rhel*)   PKG_MANAGER="fedora" ;;
        *debian*|*ubuntu*) PKG_MANAGER="debian" ;;
        *void*)            PKG_MANAGER="void"   ;;
        *)
          error "Distribuição não suportada: $DISTRO_ID"
          error "Suportadas: Arch, Fedora, Debian/Ubuntu, Void Linux"
          exit 1
          ;;
      esac
      ;;
  esac

  info "Distribuição detectada: ${BOLD}${DISTRO_ID}${NC} (gerenciador: ${BOLD}${PKG_MANAGER}${NC})"
}

# ------------------------------------------------------------------------------
# Wrappers de instalação por distro
# ------------------------------------------------------------------------------
pkg_install() {
  case "$PKG_MANAGER" in
    arch)   sudo pacman -S --needed --noconfirm "$@" ;;
    fedora) sudo dnf install -y "$@" ;;
    debian) sudo apt-get install -y "$@" ;;
    void)   sudo xbps-install -Sy "$@" ;;
  esac
}

pkg_update() {
  case "$PKG_MANAGER" in
    arch)   sudo pacman -Syu --noconfirm ;;
    fedora) sudo dnf check-update -y || true ;;
    debian) sudo apt-get update -y ;;
    void)   sudo xbps-install -Su ;;
  esac
}

pkg_cmd_str() {
  case "$PKG_MANAGER" in
    arch)   echo "sudo pacman -S --needed --noconfirm $*" ;;
    fedora) echo "sudo dnf install -y $*" ;;
    debian) echo "sudo apt-get install -y $*" ;;
    void)   echo "sudo xbps-install -Sy $*" ;;
  esac
}

# ------------------------------------------------------------------------------
# Inicialização
# ------------------------------------------------------------------------------
ask_mode
detect_distro

# ------------------------------------------------------------------------------
# 1. Atualizar repositórios
# ------------------------------------------------------------------------------
section "Atualizar repositórios do sistema"

UPDATE_CMD=""
case "$PKG_MANAGER" in
  arch)   UPDATE_CMD="sudo pacman -Syu --noconfirm" ;;
  fedora) UPDATE_CMD="sudo dnf check-update" ;;
  debian) UPDATE_CMD="sudo apt-get update" ;;
  void)   UPDATE_CMD="sudo xbps-install -Su" ;;
esac

if confirm "Atualizar lista de pacotes do sistema" "$UPDATE_CMD"; then
  pkg_update
  success "Repositórios atualizados"
else
  skip "Atualização de repositórios ignorada"
fi

# ------------------------------------------------------------------------------
# 2. Dependências base
# ------------------------------------------------------------------------------
section "Dependências base"

case "$PKG_MANAGER" in
  arch)   BASE_PKGS="neovim git curl wget unzip tar gzip ripgrep fd base-devel" ;;
  fedora) BASE_PKGS="neovim git curl wget unzip tar gzip ripgrep fd-find @development-tools" ;;
  debian) BASE_PKGS="neovim git curl wget unzip tar gzip ripgrep fd-find build-essential" ;;
  void)   BASE_PKGS="neovim git curl wget unzip tar gzip ripgrep fd base-devel" ;;
esac

if confirm "Instalar pacotes base (neovim, git, curl, ripgrep, fd, build tools)" \
           "$(pkg_cmd_str $BASE_PKGS)"; then
  # shellcheck disable=SC2086
  pkg_install $BASE_PKGS
  success "Dependências base instaladas"
else
  skip "Dependências base ignoradas"
fi

# ------------------------------------------------------------------------------
# 3. Compiladores C/C++ + clangd
# ------------------------------------------------------------------------------
section "Compiladores C/C++ e clangd (necessários para Treesitter)"

case "$PKG_MANAGER" in
  arch)
    CC_PKGS="gcc clang llvm"
    CLANGD_PKG="clang" ;;
  fedora)
    CC_PKGS="gcc gcc-c++ clang llvm"
    CLANGD_PKG="clang-tools-extra" ;;
  debian)
    CC_PKGS="gcc g++ clang llvm"
    CLANGD_PKG="clangd" ;;
  void)
    CC_PKGS="gcc clang llvm"
    CLANGD_PKG="clang-tools-extra" ;;
esac

if confirm "Instalar compiladores C/C++ (gcc, clang, llvm)" \
           "$(pkg_cmd_str $CC_PKGS)"; then
  # shellcheck disable=SC2086
  pkg_install $CC_PKGS
  success "Compiladores instalados"
else
  skip "Compiladores C/C++ ignorados"
fi

if ! command_exists clangd; then
  if confirm "Instalar clangd (LSP para C/C++)" "$(pkg_cmd_str $CLANGD_PKG)"; then
    pkg_install "$CLANGD_PKG"
    success "clangd instalado"
  else
    skip "clangd ignorado"
  fi
else
  warn "clangd já instalado: $(command -v clangd)"
fi

# ------------------------------------------------------------------------------
# 4. Node.js e npm
# ------------------------------------------------------------------------------
section "Node.js e npm"

if command_exists node; then
  warn "Node.js já instalado: $(node --version)"
else
  case "$PKG_MANAGER" in
    arch|fedora|void)
      if confirm "Instalar Node.js e npm" "$(pkg_cmd_str nodejs npm)"; then
        pkg_install nodejs npm
        success "Node.js instalado: $(node --version)"
      else
        skip "Node.js ignorado"
      fi
      ;;
    debian)
      NODESOURCE_CMD="curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs"
      if confirm "Instalar Node.js LTS via NodeSource" "$NODESOURCE_CMD"; then
        info "Adicionando repositório NodeSource (Node.js LTS)..."
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        pkg_install nodejs
        success "Node.js instalado: $(node --version)"
      else
        skip "Node.js ignorado"
      fi
      ;;
  esac
fi

# ------------------------------------------------------------------------------
# 5. Python
# ------------------------------------------------------------------------------
section "Python 3"

if command_exists python3; then
  warn "Python já instalado: $(python3 --version)"
else
  case "$PKG_MANAGER" in
    arch)   PY_PKGS="python python-pip" ;;
    fedora) PY_PKGS="python3 python3-pip" ;;
    debian) PY_PKGS="python3 python3-pip python3-venv" ;;
    void)   PY_PKGS="python3 python3-pip" ;;
  esac

  if confirm "Instalar Python 3 e pip" "$(pkg_cmd_str $PY_PKGS)"; then
    # shellcheck disable=SC2086
    pkg_install $PY_PKGS
    success "Python instalado: $(python3 --version)"
  else
    skip "Python ignorado"
  fi
fi

# ------------------------------------------------------------------------------
# 6. Go
# ------------------------------------------------------------------------------
section "Go"

if command_exists go; then
  warn "Go já instalado: $(go version)"
else
  case "$PKG_MANAGER" in
    arch|void) GO_PKG="go" ;;
    fedora)    GO_PKG="golang" ;;
    debian)    GO_PKG="golang-go" ;;
  esac

  if confirm "Instalar Go" "$(pkg_cmd_str $GO_PKG)"; then
    pkg_install "$GO_PKG"
    success "Go instalado: $(go version)"
  else
    skip "Go ignorado"
  fi
fi

if command_exists go && [ -z "${GOPATH:-}" ]; then
  export GOPATH="$HOME/go"
  export PATH="$PATH:$GOPATH/bin"
  warn "GOPATH configurado temporariamente. Adicione ao seu shell rc:"
  warn "  export GOPATH=\"\$HOME/go\" && export PATH=\"\$PATH:\$GOPATH/bin\""
fi

# ------------------------------------------------------------------------------
# 7. Rust (rustup)
# ------------------------------------------------------------------------------
section "Rust (rustup)"

if command_exists rustup; then
  warn "rustup já instalado. Atualizando toolchain..."
  rustup update stable
elif command_exists cargo; then
  warn "cargo já disponível: $(cargo --version)"
else
  RUSTUP_CMD="curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path"
  if confirm "Instalar Rust via rustup (cargo, rustc, rustfmt)" "$RUSTUP_CMD"; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
    # shellcheck source=/dev/null
    source "$HOME/.cargo/env"
    success "Rust instalado: $(rustc --version)"
  else
    skip "Rust ignorado"
  fi
fi

if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck source=/dev/null
  source "$HOME/.cargo/env"
fi

if command_exists rustup; then
  if confirm "Instalar clippy e rustfmt (linter e formatador Rust)" \
             "rustup component add clippy rustfmt"; then
    rustup component add clippy rustfmt
    success "clippy + rustfmt instalados"
  else
    skip "clippy/rustfmt ignorados"
  fi
fi

# ------------------------------------------------------------------------------
# 8. Servidores LSP via npm
# ------------------------------------------------------------------------------
section "Servidores LSP e ferramentas via npm"

npm_step() {
  local description="$1"
  local pkg="$2"
  local bin="${3:-$2}"

  if ! command_exists npm; then
    warn "npm não encontrado — pulando $pkg"
    return
  fi

  if command_exists "$bin"; then
    warn "$bin já instalado: $(command -v "$bin")"
    return
  fi

  if confirm "$description" "sudo npm install -g $pkg"; then
    sudo npm install -g "$pkg"
    success "$pkg instalado"
  else
    skip "$pkg ignorado"
  fi
}

npm_step "intelephense — LSP para PHP"                      intelephense
npm_step "typescript — compilador TypeScript"               typescript                    tsc
npm_step "typescript-language-server — LSP para TS/JS"      typescript-language-server    typescript-language-server
npm_step "eslint — linter JavaScript/TypeScript"            eslint
npm_step "pyright — LSP para Python"                        pyright
npm_step "vscode-langservers-extracted — LSP HTML/CSS/JSON" vscode-langservers-extracted  vscode-html-language-server
npm_step "prettier — formatador JS/TS/JSON/CSS/HTML"        prettier
npm_step "blade-formatter — formatador para Blade (Laravel)" blade-formatter              blade-formatter

# ------------------------------------------------------------------------------
# 9. rust-analyzer (LSP para Rust)
# ------------------------------------------------------------------------------
section "rust-analyzer (LSP para Rust)"

if command_exists rust-analyzer; then
  warn "rust-analyzer já instalado"
else
  case "$PKG_MANAGER" in
    arch|fedora|void)
      if confirm "Instalar rust-analyzer" "$(pkg_cmd_str rust-analyzer)"; then
        pkg_install rust-analyzer
        success "rust-analyzer instalado"
      else
        skip "rust-analyzer ignorado"
      fi
      ;;
    debian)
      if command_exists rustup; then
        if confirm "Instalar rust-analyzer via rustup" "rustup component add rust-analyzer"; then
          rustup component add rust-analyzer
          success "rust-analyzer instalado via rustup"
        else
          skip "rust-analyzer ignorado"
        fi
      else
        warn "rustup não encontrado — instale Rust primeiro"
      fi
      ;;
  esac
fi

# ------------------------------------------------------------------------------
# 10. Go tools
# ------------------------------------------------------------------------------
section "Ferramentas Go (gopls, staticcheck, gofumpt)"

go_step() {
  local bin="$1"
  local pkg="$2"

  if ! command_exists go; then
    warn "go não encontrado — pulando $bin"
    return
  fi

  if command_exists "$bin"; then
    warn "$bin já instalado: $(command -v "$bin")"
    return
  fi

  if confirm "Instalar $bin" "go install $pkg"; then
    go install "$pkg"
    success "$bin instalado"
  else
    skip "$bin ignorado"
  fi
}

go_step gopls       golang.org/x/tools/gopls@latest
go_step staticcheck honnef.co/go/tools/cmd/staticcheck@latest
go_step gofumpt     mvdan.cc/gofumpt@latest

# ------------------------------------------------------------------------------
# 11. Formatadores de código
# ------------------------------------------------------------------------------
section "Formatadores de código"

# stylua — Lua
if command_exists stylua; then
  warn "stylua já instalado: $(command -v stylua)"
else
  STYLUA_INSTALLED=false

  # Tenta via package manager (Arch tem no AUR, Void no repo)
  case "$PKG_MANAGER" in
    arch)
      if confirm "Instalar stylua (formatador Lua) via pacman" "$(pkg_cmd_str stylua)"; then
        pkg_install stylua && STYLUA_INSTALLED=true
        success "stylua instalado"
      fi
      ;;
    void)
      if confirm "Instalar stylua (formatador Lua) via xbps" "$(pkg_cmd_str stylua)"; then
        pkg_install stylua && STYLUA_INSTALLED=true
        success "stylua instalado"
      fi
      ;;
  esac

  if [ "$STYLUA_INSTALLED" = false ] && command_exists cargo; then
    if confirm "Instalar stylua (formatador Lua) via cargo" "cargo install stylua"; then
      cargo install stylua
      success "stylua instalado"
    else
      skip "stylua ignorado"
    fi
  elif [ "$STYLUA_INSTALLED" = false ]; then
    warn "stylua não pôde ser instalado (instale cargo/Rust primeiro)"
  fi
fi

# black — Python
if command_exists black; then
  warn "black já instalado: $(command -v black)"
elif command_exists pip3; then
  if confirm "Instalar black (formatador Python) via pip" "pip3 install --user black"; then
    pip3 install --user black
    success "black instalado"
  else
    skip "black ignorado"
  fi
elif command_exists pip; then
  if confirm "Instalar black (formatador Python) via pip" "pip install --user black"; then
    pip install --user black
    success "black instalado"
  else
    skip "black ignorado"
  fi
else
  warn "pip não encontrado — instale Python primeiro para usar black"
fi

# php-cs-fixer (opcional)
if command_exists php-cs-fixer; then
  warn "php-cs-fixer já instalado"
else
  if command_exists composer; then
    if confirm "Instalar php-cs-fixer (formatador PHP) via composer" \
               "composer global require friendsofphp/php-cs-fixer" "true"; then
      composer global require friendsofphp/php-cs-fixer
      success "php-cs-fixer instalado"
    else
      skip "php-cs-fixer ignorado"
    fi
  else
    optional "php-cs-fixer: composer não encontrado (instale composer para usar)"
  fi
fi

# ------------------------------------------------------------------------------
# 12. Hack Nerd Font
# ------------------------------------------------------------------------------
section "Hack Nerd Font"

FONT_DIR="$HOME/.local/share/fonts"

if fc-list 2>/dev/null | grep -qi "hack nerd"; then
  warn "Hack Nerd Font já instalada"
else
  FONT_CMD="curl -fLo /tmp/Hack.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
  if confirm "Instalar Hack Nerd Font (ícones do dashboard e nvim-tree)" "$FONT_CMD"; then
    info "Baixando Hack Nerd Font..."
    mkdir -p "$FONT_DIR"
    FONT_ZIP="/tmp/Hack.zip"
    curl -fLo "$FONT_ZIP" \
      "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
    unzip -o "$FONT_ZIP" -d "$FONT_DIR/HackNerdFont" "*.ttf" 2>/dev/null || true
    rm -f "$FONT_ZIP"
    fc-cache -fv "$FONT_DIR" &>/dev/null
    success "Hack Nerd Font instalada"
  else
    skip "Hack Nerd Font ignorada"
  fi
fi

# ------------------------------------------------------------------------------
# 13. Ferramentas opcionais
# ------------------------------------------------------------------------------
section "Ferramentas opcionais"

# fish shell
if command_exists fish; then
  warn "fish já instalado: $(command -v fish)"
else
  case "$PKG_MANAGER" in
    arch)   FISH_PKG="fish" ;;
    fedora) FISH_PKG="fish" ;;
    debian) FISH_PKG="fish" ;;
    void)   FISH_PKG="fish-shell" ;;
  esac
  if confirm "Instalar fish shell (shell padrão do terminal embutido)" \
             "$(pkg_cmd_str $FISH_PKG)" "true"; then
    pkg_install "$FISH_PKG"
    success "fish instalado"
  else
    skip "fish ignorado"
  fi
fi

# lazygit
if command_exists lazygit; then
  warn "lazygit já instalado: $(command -v lazygit)"
else
  case "$PKG_MANAGER" in
    arch)
      if confirm "Instalar lazygit (git TUI, muito útil com o terminal embutido)" \
                 "$(pkg_cmd_str lazygit)" "true"; then
        pkg_install lazygit
        success "lazygit instalado"
      else
        skip "lazygit ignorado"
      fi
      ;;
    fedora|debian|void)
      if command_exists go; then
        if confirm "Instalar lazygit via go install" \
                   "go install github.com/jesseduffield/lazygit@latest" "true"; then
          go install github.com/jesseduffield/lazygit@latest
          success "lazygit instalado"
        else
          skip "lazygit ignorado"
        fi
      else
        optional "lazygit: instale Go primeiro (go install github.com/jesseduffield/lazygit@latest)"
      fi
      ;;
  esac
fi

# xclip / wl-clipboard (clipboard no terminal)
if command_exists xclip || command_exists wl-copy; then
  warn "Clipboard já configurado (xclip ou wl-clipboard encontrado)"
else
  # Detecta se está em Wayland ou X11
  if [ -n "$WAYLAND_DISPLAY" ]; then
    CLIP_PKG_ARCH="wl-clipboard"
    CLIP_PKG_FEDORA="wl-clipboard"
    CLIP_PKG_DEBIAN="wl-clipboard"
    CLIP_PKG_VOID="wl-clipboard"
    CLIP_DESC="wl-clipboard (clipboard Wayland — necessário para copiar do Neovim)"
  else
    CLIP_PKG_ARCH="xclip"
    CLIP_PKG_FEDORA="xclip"
    CLIP_PKG_DEBIAN="xclip"
    CLIP_PKG_VOID="xclip"
    CLIP_DESC="xclip (clipboard X11 — necessário para copiar do Neovim no terminal)"
  fi

  case "$PKG_MANAGER" in
    arch)   CLIP_PKG="$CLIP_PKG_ARCH" ;;
    fedora) CLIP_PKG="$CLIP_PKG_FEDORA" ;;
    debian) CLIP_PKG="$CLIP_PKG_DEBIAN" ;;
    void)   CLIP_PKG="$CLIP_PKG_VOID" ;;
  esac

  if confirm "$CLIP_DESC" "$(pkg_cmd_str $CLIP_PKG)" "true"; then
    pkg_install "$CLIP_PKG"
    success "Clipboard instalado"
  else
    skip "Clipboard ignorado"
  fi
fi

# ------------------------------------------------------------------------------
# Resumo final
# ------------------------------------------------------------------------------
section "Verificação final"
echo ""

check_cmd() {
  local label="$1"
  local cmd="$2"
  if command_exists "$cmd"; then
    success "${BOLD}${label}${NC}: $(command -v "$cmd")"
  else
    warn "${BOLD}${label}${NC}: não encontrado ${DIM}(reinicie o terminal se acabou de instalar)${NC}"
  fi
}

echo -e "${BOLD}── Essenciais ──────────────────────────────${NC}"
check_cmd "nvim"    nvim
check_cmd "git"     git
check_cmd "rg"      rg
check_cmd "fd"      fd

echo -e "\n${BOLD}── Compiladores ────────────────────────────${NC}"
check_cmd "gcc"     gcc
check_cmd "clang"   clang
check_cmd "clangd"  clangd

echo -e "\n${BOLD}── Runtimes ────────────────────────────────${NC}"
check_cmd "node"    node
check_cmd "npm"     npm
check_cmd "python3" python3
check_cmd "go"      go
check_cmd "cargo"   cargo
check_cmd "rustc"   rustc

echo -e "\n${BOLD}── Servidores LSP ──────────────────────────${NC}"
check_cmd "rust-analyzer"              rust-analyzer
check_cmd "gopls"                      gopls
check_cmd "intelephense"               intelephense
check_cmd "typescript-language-server" typescript-language-server
check_cmd "pyright"                    pyright
check_cmd "vscode-html-language-server" vscode-html-language-server
check_cmd "eslint"                     eslint

echo -e "\n${BOLD}── Formatadores ────────────────────────────${NC}"
check_cmd "prettier"        prettier
check_cmd "stylua"          stylua
check_cmd "black"           black
check_cmd "rustfmt"         rustfmt
check_cmd "gofmt"           gofmt
check_cmd "gofumpt"         gofumpt
check_cmd "blade-formatter" blade-formatter

echo -e "\n${BOLD}── Opcionais ───────────────────────────────${NC}"
check_cmd "fish"     fish
check_cmd "lazygit"  lazygit
check_cmd "staticcheck" staticcheck

echo ""
echo -e "${GREEN}${BOLD}Concluído!${NC}"
echo ""
echo -e "${YELLOW}Próximos passos:${NC}"
echo -e "  1. Abra o Neovim: ${BOLD}nvim${NC}"
echo -e "     → O lazy.nvim instala todos os plugins automaticamente na primeira abertura"
echo -e "  2. Após os plugins instalarem, rode: ${BOLD}:TSUpdate${NC}  (Treesitter parsers)"
echo -e "  3. Configure o WakaTime: ${BOLD}:WakaTimeApiKey${NC}"
echo -e "  4. Configure o Copilot: ${BOLD}:Copilot auth${NC}"
echo ""
echo -e "${DIM}Se algum binário não foi encontrado, rode:${NC}"
echo -e "  ${CYAN}source ~/.cargo/env${NC}                    # Rust / stylua"
echo -e "  ${CYAN}export PATH=\"\$PATH:\$HOME/go/bin\"${NC}       # Go tools"
echo -e "  ${CYAN}export PATH=\"\$PATH:\$HOME/.local/bin\"${NC}   # black, pip tools"
echo ""
