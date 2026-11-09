DIR_DOTFILES="${HOME}/nixos/dotfiles"

LOCALAPPDATA=$(wslpath "$(powershell.exe '$env:LOCALAPPDATA')" | tr -d '\r')
DIR_TERMINAL="${LOCALAPPDATA}/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState"

echo "settings dir:"
echo "$DIR_TERMINAL"

mkdir -p "${DIR_TERMINAL}"
cp "${DIR_DOTFILES}/terminal/settings.json" "${DIR_TERMINAL}/settings.json"
