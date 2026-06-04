dot_src=~/nixos/dotfiles

symlink () {
    src=$1
    dst=$2
    if [ ! -e "$src" ]; then
        echo "missing src $src"
    else
        echo "created dst $dst"
        ln -sfn "$src" "$dst"
    fi
}

symlink_home () {
    src="$dot_src/$1"
    dst="$HOME/$2"
    symlink "$src" "$dst"
}

symlink_conf () {
    src="$dot_src/$1"
    dst="$HOME/.config/$1"
    symlink "$src" "$dst"
}

programs=(alacritty beets btop direnv dunst eza fastfetch flameshot fzf ghostty git hypr kitty lazygit mpv nvim qmk qutebrowser rofi starship sunsetr tealdeer tmux waybar yazi)

for program in "${programs[@]}"; do
    symlink_conf "$program"
done

symlink_home "bash/.bashrc" ".bashrc"
symlink_home "bash/.profile" ".profile"
symlink_home "ssh/config" ".ssh/config"
