pcall(require, "luarocks.loader")

local beautiful = require 'beautiful'
require './user_likes'

require "awful.autofocus"

require "signal.global"
require "configuration"
require "ui"

beautiful.init(theme)
