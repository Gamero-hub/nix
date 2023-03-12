local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    awful.titlebar(
        c, { 
	    size = 39, 
	    font = "Iosevka Nerd Font Semibold 10",
    }
    ).widget = {
        { -- Left
            wibox.container.margin(awful.titlebar.widget.closebutton(c), 5, 5, 8, 8),
            wibox.container.margin(awful.titlebar.widget.minimizebutton(c), 0, 5, 8, 8),
            wibox.container.margin(awful.titlebar.widget.maximizedbutton(c), 0, 5, 8, 8),
            buttons = buttons,
	        halign = "left",
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal,
    }
end)
