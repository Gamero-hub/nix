local awful = require 'awful'
local wibox = require 'wibox'
local taglist = require("ui.bar.modules.workspaces")
require '../../user_likes'

---@diagnostic disable-next-line: undefined-global
screen.connect_signal('request::desktop_decoration', function (s)
    awful.tag(
        {'1', '2', '3', '4', '5'},
        s, awful.layout.layouts[1]
    )

        s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }


    s.mywibox = awful.wibar {
        position = "top",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                taglist(s),
            },
            s.mytasklist, -- Middle widget
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.widget.systray(),
                s.mylayoutbox,
            },
        }
    }

end)
