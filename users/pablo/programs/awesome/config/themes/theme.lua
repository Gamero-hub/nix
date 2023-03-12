---------------------------
-- Default awesome theme --
---------------------------

require '../user_likes'

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require 'gears'

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = require 'themes.colors.catppuccin'

theme.wallpaper = wallpaper

theme.useless_gap         = dpi(8)
theme.border_width        = dpi(1)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(60)
theme.menu_width  = dpi(180)
theme.menu_font = "Iosevka Nerd Font Semibold Italic 10"
theme.menu_bg = theme.overlay0
theme.menu_fg = theme.text

-- Taglist
theme.taglist_bg = theme.base
theme.taglist_bg_urgent = theme.red
theme.normal_tag_format = '󰊠 '
theme.occupied_tag_format = theme.normal_tag_format
theme.selected_tag_format = '󰮯 '
theme.taglist_fg_focus = theme.yellow
theme.taglist_fg = theme.surface0
theme.taglist_fg_occupied = theme.blue
theme.taglist_font = theme.font

-- Define the image to load
theme.titlebar_close_button_normal = gears.surface.load_from_shape(50, 20, gears.shape.rounded_rect, theme.surface0)
theme.titlebar_close_button_focus  = gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.red) 

theme.titlebar_minimize_button_normal = gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.surface0)
theme.titlebar_minimize_button_focus  = gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.green)

theme.titlebar_maximized_button_normal_inactive = gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.surface0)
theme.titlebar_maximized_button_focus_inactive =  gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.yellow) 
theme.titlebar_maximized_button_normal_active =  gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.yellow) 
theme.titlebar_maximized_button_focus_active  =  gears.surface.load_from_shape(50, 20, gears.shape.rounded_bar, theme.yellow) 

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

-- local color = gears.color({
--   type = "linear",
--   from = { 0, 0 },
--   to = { 750, 0 },
--   stops = {
--     { 0.25, theme.red },
--     { 0.5, theme.mauve },
--     { 0.75, theme.blue },
--     { 1, theme.sky },
--   },
-- })
--

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

