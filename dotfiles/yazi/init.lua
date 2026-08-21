-- https://github.com/sxyazi/yazi/discussions/3664
function Entity:icon()
    local icon = th.icon:match(self._file)
    if not icon then
        return ""
    else
        return icon.text .. " "
    end
end
