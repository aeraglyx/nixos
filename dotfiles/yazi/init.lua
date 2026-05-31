-- https://github.com/sxyazi/yazi/discussions/3664
function Entity:icon()
    local icon = self._file:icon()
    if not icon then
        return ""
    else
        return icon.text .. " "
    end
end
