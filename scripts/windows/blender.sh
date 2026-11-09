DIR_DOTFILES="${HOME}/nixos/dotfiles"
BLENDER_VERSION="5.2"

APPDATA=$(wslpath "$(powershell.exe '$env:APPDATA')" | tr -d '\r')
DIR_BLEND="${APPDATA}/Blender Foundation/Blender/${BLENDER_VERSION}"
DIR_BLEND_STARTUP="${DIR_BLEND}/scripts/startup"

echo "blender startup dir:"
echo "$DIR_BLEND_STARTUP"

mkdir -p "${DIR_BLEND_STARTUP}"
cp "${DIR_DOTFILES}/blender/scripts/startup/setup.py" "${DIR_BLEND_STARTUP}/setup.py"
