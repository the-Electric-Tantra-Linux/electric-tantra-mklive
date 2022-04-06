--  ______ __
-- |      |  |.-----.---.-.----.
-- |   ---|  ||  -__|  _  |   _|
-- |______|__||_____|___._|__|
--  _______ __ __
-- |   _   |  |  |
-- |       |  |  |
-- |___|___|__|__|
-- ------------------------------------------------- --
--  icon
local widget_icon =
	wibox.widget {
	layout = wibox.layout.align.vertical,
	expand = "none",
	nil,
	{
		id = "icon",
		image = icons.clearNotifications,
		resize = true,
		widget = wibox.widget.imagebox
	},
	nil
}
-- ------------------------------------------------- --
-- widget template
local widget =
	wibox.widget {
	{
		{
			{
				widget_icon,
				layout = wibox.layout.fixed.horizontal
			},
			margins = dpi(9),
			widget = wibox.container.margin
		},
		widget = clickable_container
	},
	shape = beautiful.client_shape_rounded_xl,
	bg = beautiful.bg_button,
	widget = wibox.container.background
}
-- ------------------------------------------------- --
-- connect signal for mouse entry
widget:connect_signal(
	"mouse::enter",
	function()
		widget.bg = beautiful.accent
	end
)
-- ------------------------------------------------- --
-- connect signal for mouse departure
widget:connect_signal(
	"mouse::leave",
	function()
		widget.bg = beautiful.bg_button
	end
)
-- ------------------------------------------------- --
--  button binding
widget:buttons(
	gears.table.join(
		awful.button(
			{},
			1,
			nil,
			function()
				_G.resetPanelLayout()
			end
		)
	)
)

return widget
