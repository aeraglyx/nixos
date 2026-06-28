eval "$(starship init bash)"
eval "$(zoxide init --cmd h bash)"
eval "$(direnv hook bash)"

export HISTCONTROL=ignoredups
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

alias res="$SHELL"

flake="--flake path:${HOME}/nixos#${HOSTNAME}"
alias nrs="sudo nixos-rebuild switch $flake"
alias nrt="sudo nixos-rebuild test $flake"
alias nrd="sudo nixos-rebuild dry-activate $flake"
alias nfu="sudo nix flake update --flake ~/nixos"
alias ncg="sudo nix-collect-garbage"
alias ntr="nix-tree ${HOME}/nixos#nixosConfigurations.${HOSTNAME}.config.system.build.toplevel"
alias nso="sudo nix-store --optimize"
alias nd="nix develop"
alias ns="nix-shell"
alias nsp="nix-shell -p"
alias nhc="nixos-generate-config --show-hardware-config"

alias g="lazygit"
alias grh="git fetch --all && git reset --hard origin/main"
alias e="nvim"
alias et="nvim ."
alias ls="eza --icons --all"
alias lsa="eza --long --icons --all"
alias tre="eza --tree --icons --all --git-ignore"
alias tree="eza --tree --icons --all --ignore-glob '.git'"
alias f="yazi"
alias kill="pkill"
alias diff="diff --old-group-format=$'\n\e[0;31m%<\e[0m' --new-group-format=$'\e[0;34m%>\e[0m' --unchanged-group-format=''"
alias syn="rsync -avh --info=progress2 --no-i-r"
alias synck="rsync -avh --dry-run --checksum --delete"
alias da="direnv allow"
alias og="sh ~/scripts/open_github.sh"
# alias ana="systemd-analyze && echo && systemd-analyze blame | head -n 10"
alias ana="systemd-analyze"
alias anab="systemd-analyze blame | head -n 32"
alias matrix="cmatrix -C cyan"
alias qmkc="qmk compile -j $(nproc) --compiledb"
alias ser="sh scripts/serve.sh"
alias sun="sunsetr --config ~/.config/test-sunsetr/ --simulate '2026-01-01 20:00:00' '2026-01-01 21:00:00' 1440"
alias sunc="cargo run -- --config ~/.config/test-sunsetr/ --simulate '2026-01-01 20:00:00' '2026-01-01 21:00:00' 1440"

dots="$HOME/nixos"
proj="$HOME/projects"
cmd="-c 'Telescope find_files'"

alias en="cd $dots/ && nvim $cmd ."
alias ed="cd $dots/dotfiles/ && nvim $cmd ."
alias eb="cd $dots/dotfiles/bash/ && nvim .bashrc"
alias eh="cd $dots/dotfiles/hypr/ && nvim $cmd ."
alias ev="cd $dots/dotfiles/nvim/ && nvim $cmd ."

alias ec="cd $proj/onyx.nvim/ && nvim $cmd ."
alias kb="cd $proj/qmk_userspace/ && nvim $cmd ."

dir() {
    mkdir -p "$1"
    cd "$1" || exit
}
