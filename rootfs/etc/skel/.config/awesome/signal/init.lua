--  _______ __                     __
-- |     __|__|.-----.-----.---.-.|  |
-- |__     |  ||  _  |     |  _  ||  |
-- |_______|__||___  |__|__|___._||__|
--             |_____|
-- These daemons are props to elenapan.
-- https://github.com/elenapan/dotfiles
--require("signal.battery")
require("signal.volume")
require("signal.brightness")
require("signal.ram")
require("signal.cpu")
require("signal.temp")
require("signal.disk")
require("signal.network")
collectgarbage("collect")
