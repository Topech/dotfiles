
export FPATH="$HOME/.config/zsh/completions:$FPATH"


autoload -Uz compinit
compinit

# autoload -U +X bashcompinit && bashcompinit


complete -o nospace -C /opt/homebrew/bin/terraform terraform


