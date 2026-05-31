# qute://help/configuring.html
# qute://help/settings.html


from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    config: Any = None
    c: Any = None


config.load_autoconfig(False)

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:136.0) Gecko/20100101 Firefox/139.0', 'https://accounts.google.com/*')

config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.set('content.local_content_can_access_remote_urls', True, 'file:///home/aeraglyx/.local/share/qutebrowser/userscripts/*')
config.set('content.local_content_can_access_file_urls', False, 'file:///home/aeraglyx/.local/share/qutebrowser/userscripts/*')


c.tabs.favicons.scale = 1.0
c.tabs.favicons.show = 'always'
c.tabs.padding = {'bottom': 3, 'left': 8, 'right': 8, 'top': 3}
c.tabs.position = 'left'
c.tabs.show = 'multiple'
c.tabs.min_width = -1
c.tabs.indicator.width = 3
c.tabs.pinned.shrink = True
c.tabs.pinned.frozen = True
c.tabs.undo_stack_size = 64
c.tabs.width = 280

c.statusbar.padding = {'bottom': 3, 'left': 8, 'right': 8, 'top': 3}

c.completion.cmd_history_max_items = 64
c.completion.height = '40%'

class colors():
    deep = "#1c1c1c"
    base = "#202020"
    surf = "#292929"
    smol = "#383838"
    dim = "#525252"
    meh = "#888888"
    uhm = "#b0b0b0"
    text = "#c8c8c8"
    red = "#fd7eaa"
    peach = "#deb39c"
    mire = "#c0c295"
    green = "#97cbb8"
    blue = "#96c6dd"
    purp = "#bcb8e2"
    aqua = "#b2c4d0"

c.colors.completion.fg = [colors.text, colors.text, colors.text]
c.colors.completion.odd.bg = colors.base
c.colors.completion.even.bg = colors.base
c.colors.completion.category.fg = colors.text
c.colors.completion.category.bg = colors.surf
c.colors.completion.category.border.top = colors.surf
c.colors.completion.category.border.bottom = colors.surf
c.colors.completion.item.selected.fg = colors.base
c.colors.completion.item.selected.bg = colors.blue
c.colors.completion.item.selected.border.top = colors.base
c.colors.completion.item.selected.border.bottom = colors.base
c.colors.completion.item.selected.match.fg = 'white'
c.colors.completion.match.fg = colors.peach
c.colors.completion.scrollbar.bg = colors.base
c.colors.completion.scrollbar.fg = colors.dim

c.colors.prompts.border = '1px solid gray'
c.colors.prompts.bg = '#444444'

c.colors.statusbar.normal.fg = colors.meh
c.colors.statusbar.normal.bg = colors.base
c.colors.statusbar.insert.fg = colors.green
c.colors.statusbar.insert.bg = colors.base
c.colors.statusbar.command.fg = colors.blue
c.colors.statusbar.command.bg = colors.base
c.colors.statusbar.url.fg = colors.text
c.colors.statusbar.url.error.fg = colors.red
c.colors.statusbar.url.hover.fg = colors.blue
c.colors.statusbar.url.success.http.fg = colors.dim
c.colors.statusbar.url.success.https.fg = colors.dim
c.colors.statusbar.url.warn.fg = colors.peach

c.colors.tabs.bar.bg = colors.base
c.colors.tabs.indicator.start = colors.dim
c.colors.tabs.indicator.stop = colors.dim
c.colors.tabs.indicator.system = 'rgb'
c.colors.tabs.odd.fg = colors.text
c.colors.tabs.odd.bg = colors.base
c.colors.tabs.even.fg = colors.text
c.colors.tabs.even.bg = colors.base
c.colors.tabs.selected.odd.fg = colors.base
c.colors.tabs.selected.odd.bg = colors.blue
c.colors.tabs.selected.even.fg = colors.base
c.colors.tabs.selected.even.bg = colors.blue

c.colors.messages.info.bg = colors.base
c.colors.messages.info.fg = colors.text
c.colors.messages.info.border = colors.base
c.colors.messages.warning.bg = colors.base
c.colors.messages.warning.fg = colors.peach
c.colors.messages.warning.border = colors.base
c.colors.messages.error.bg = colors.base
c.colors.messages.error.fg = colors.red
c.colors.messages.error.border = colors.base


c.colors.webpage.preferred_color_scheme = 'dark'
# c.colors.webpage.darkmode.enabled = True
# c.colors.webpage.darkmode.threshold.background = 0

c.fonts.default_family = 'Caskaydia Cove Nerd Font'
c.fonts.default_size = '13pt'

config.bind('so', 'config-source')
# config.bind('M', 'hint links spawn mpv {hint-url}')
