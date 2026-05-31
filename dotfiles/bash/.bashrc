eval "$(starship init bash)"
eval "$(zoxide init --cmd h bash)"
eval "$(direnv hook bash)"

export HISTCONTROL=ignoredups
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config
export STARSHIP_CONFIG="$XDG_CONFIG_HOME"/starship/starship.toml
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

alias res="$SHELL"

flake="--flake path:/home/aeraglyx/nixos#${HOSTNAME}"
alias nrs="sudo nixos-rebuild switch $flake"
alias nrt="sudo nixos-rebuild test $flake"
alias nrd="sudo nixos-rebuild dry-activate $flake"
alias nfu="sudo nix flake update --flake ~/nixos"
alias ncg="sudo nix-collect-garbage"
alias ntr="nix-tree /home/aeraglyx/nixos#nixosConfigurations.${HOSTNAME}.config.system.build.toplevel"
alias nso="sudo nix-store --optimize"
alias nd="nix develop"
alias ns="nix-shell"
alias nsp="nix-shell -p"

alias g="lazygit"
alias grh="git fetch --all && git reset --hard origin/main"
alias e="nvim"
alias et="nvim ."
alias ls="eza --icons"
alias lsa="eza --long --icons --all --no-user"
alias tre="eza --tree --icons --all --git-ignore --no-permissions --no-filesize --no-user --no-time"
alias f="yazi"
alias kill="pkill"
alias da="direnv allow"
alias og="sh ~/scripts/open_github.sh"
alias qmkc="qmk compile -j $(nproc) --compiledb"
alias ana="systemd-analyze && echo && systemd-analyze blame | head -n 10"
alias matrix="cmatrix -C cyan"
alias ser="sh scripts/serve.sh"
alias sun="sunsetr --config ~/.config/test-sunsetr/ --simulate '2026-01-01 20:00:00' '2026-01-01 21:00:00' 1440"
alias sunc="cargo run -- --config ~/.config/test-sunsetr/ --simulate '2026-01-01 20:00:00' '2026-01-01 21:00:00' 1440"

cmd="-c 'Telescope find_files'"
alias en="cd ~/nixos/ && nvim $cmd ."
alias ed="cd ~/dotfiles/ && nvim $cmd ."
alias eb="cd ~/dotfiles/bash/ && nvim .bashrc"
alias eh="cd ~/dotfiles/hypr/.config/hypr/ && nvim $cmd ."
alias ev="cd ~/dotfiles/nvim/.config/nvim/ && nvim $cmd ."
alias ec="cd ~/projects/onyx.nvim/ && nvim $cmd ."
alias kb="cd ~/projects/qmk_userspace/ && nvim $cmd ."

dir() {
    mkdir -p "$1"
    cd "$1" || exit
}
