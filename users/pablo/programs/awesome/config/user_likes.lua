local menubar = require "menubar"

theme = "~/.config/awesome/themes/theme.lua"
wallpaper = "~/.config/awesome/assets/wallpaper.jpg"

terminal = "kitty"
explorer = "thunar"
browser = "firefox"
launcher = "rofi -show drun"
editor = os.getenv("EDITOR") or "nvim"
visual_editor = "code" -- vscode
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4" -- super, the windows key


-- Set the terminal for applications that require it
menubar.utils.terminal = terminal
