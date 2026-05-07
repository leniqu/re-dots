# Цвета
autoload -U colors && colors

# Приглашение (пользователь@хост белым, текущая папка — циан)
PROMPT='%F{white}%n@%m%f %F{cyan}%~%f %# '

# История
HISTSIZE=10000
SAVEHIST=10000
setopt histignorealldups

# Плагины (положи их вручную в ~/.zsh/ или поставь через пакетный менеджер)
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Псевдонимы
alias ls='ls --color=auto'
alias ll='ls -la'
alias la='ls -a'

# Fastfetch при запуске
fastfetch
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec Hyprland
fi
