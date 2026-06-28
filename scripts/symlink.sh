dot_src=~/nixos/dotfiles

BLACK='\033[30m'
RED='\033[31m'
RESET='\033[0m'

symlink () {
    src=$1
    dst=$2
    if [ ! -e "$src" ]; then
        echo -e "${RED}[ missing src ] $src${RESET}"
    elif [ -L "$dst" ] && [ "$src" -ef "$dst" ]; then
        echo -e "${BLACK}[ skipped dst ] $dst${RESET}"
    else
        mkdir -p "${dst%/*}"
        if [ -e "$dst" ]; then
            echo -n "[ overwrite ? ] $dst "
            read -r -s -N 1 char && echo
            if [ "$char" = $'\n' ]; then
                rm -rf "$dst"
                ln -sfn "$src" "$dst"
            fi
        else
            echo "[ created dst ] $dst"
            ln -sfn "$src" "$dst"
        fi
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

programs=(alacritty beets btop direnv dunst eza fastfetch flameshot fzf ghostty git hypr kitty lazygit mpv nvim qmk qutebrowser rmpc rofi starship sunsetr tealdeer tmux waybar yazi)

for program in "${programs[@]}"; do
    symlink_conf "$program"
done

symlink_home "bash/.bashrc" ".bashrc"
symlink_home "bash/.profile" ".profile"
symlink_home "ssh/config" ".ssh/config"
symlink_home "blender/scripts/startup" ".config/blender/5.1/scripts/startup"
