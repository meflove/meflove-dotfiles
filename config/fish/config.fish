# ====== Настройки при входе в систему ======
if status --is-login
    if test (tty) = /dev/tty1
        mkdir -p ~/.cache
        exec Hyprland >~/.cache/hyprland.log || exec zsh
    else
        exec zsh
    end
end

# ====== Сочетания клавиш ======
fish_default_key_bindings
fzf_configure_bindings --variables=

# ====== Интерактивные настройки ======
if status is-interactive
    # Основные настройки
    set fish_greeting

    # Zellij
    export ZELLIJ_CONFIG_DIR=$HOME/.config/zellij
    set ZELLIJ_AUTO_ATTACH true

    # # Автозапуск Zellij в Ghostty
    if [ "$TERM" = xterm-ghostty ]
        eval (zellij setup --generate-auto-start fish | string collect)
    end
end

# ====== Псевдонимы (aliases) ======
# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Системные утилиты ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias ls='eza --icons=always --color=always -a1 --level 1'
alias ll='eza --icons=always --color=always -alh --git'
alias tree='ls --tree --level 1000'
alias du=dust
alias df=duf
alias ip='ip -color=auto'
alias grep='grep --color=auto'
alias cat=bat
alias catt='command cat'
alias Holes='sudo netstat -tupln'
alias err='journalctl -b -p err'

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Редакторы и разработка ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias n=nvim
alias m=micro
alias py=python
alias dif="delta"
alias th=ad
alias nzo='search_with_zoxdie'
alias venv="uv venv && source .venv/bin/activate.fish"
alias zigup="command sudo zigup --install-dir /home/meflove/.zig"

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Управление пакетами ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias p=paru
alias pamcan=pacman
alias hmmm='paru -Sy &> /dev/null && paru -Qu'
alias pkglist='pacman -Qs --color=always | less -R'
alias pacman-fzf-local="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pacman-fzf-remote="pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Git и инструменты ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias g=git
alias icat="kitten icat" # Просмотр изображений в терминале
alias fman="compgen -c | fzf | xargs man"

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Сеть и интернет ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias ipv4="ip addr show | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f6 | cut -d/ -f1"
alias ipv6="ip addr show | grep 'inet6 ' | cut -d ' ' -f6 | sed -n '2p'"
alias PublicIP='curl ifconfig.me && echo ""'
alias brn='curl wttr.in/barnaul | head -n -1'

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Мультимедиа ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias ytdlp="cd /home/meflove/Yt-DLP/ && yt-dlp \
  -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' \
  -S vcodec:h264"

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Управление терминалом ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias cls="clear && fastfetch"
alias c="clear && fastfetch" # Дублирует cls

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Sudo и безопасность ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
alias visudo='EDITOR=nvim command sudo visudo'
alias se=sudoedit

# ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰ Сокращения команд ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
abbr mkdir 'mkdir -p'
abbr rm 'rm -rf'
abbr cp 'cp -r'

# ====== Переменные окружения ======
export EDITOR=nvim
export SUDO_PROMPT="$(tput setaf 1 bold)Password:$(tput sgr0) "
export LIBVIRT_DEFAULT_URI="qemu:///system"
export TERM="xterm-256color"

# ====== Настройки путей ======
fish_add_path .cargo/bin/

# Pipx
set PATH $PATH /home/meflove/.local/bin

# npm
export npm_config_prefix="$HOME/.local"
# ====== Дополнительные функции ======
# Starship prompt
starship init fish | source

# Zoxide (быстрый переход по директориям)
zoxide init fish | source

source $__fish_config_dir/functions/magic-enter-cmd.fish
source ~/.config/fish/themes/tokyo-night-moon.fish
