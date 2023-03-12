local beautiful = require 'beautiful'
local gears = require 'gears'

require '../user_likes'
beautiful.init(theme)

screen.connect_signal('request::wallpaper', function (s)
   if beautiful.wallpaper then
      gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)
   end
end)
