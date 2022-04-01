-- .--------.-----.-----.--.--.
-- |        |  -__|     |  |  |
-- |__|__|__|_____|__|__|_____|
--            __     __               __
-- .--.--.--.|__|.--|  |.-----.-----.|  |_
-- |  |  |  ||  ||  _  ||  _  |  -__||   _|
-- |________||__||_____||___  |_____||____|
--                      |_____|
-- ------------------------------------------------- --
local return_button = function(color, lspace, rspace, tspace, bspace)
	local widget_button =
		wibox.widget {
		{
			{
				{
					{
						image = icons.menu,
						widget = wibox.widget.imagebox
					},
					top = dpi(4),
					bottom = dpi(4),
					left = dpi(12),
					right = dpi(12),
					widget = wibox.container.margin
				},
				shape = beautiful.client_shape_rounded,
				widget = wibox.container.background
			},
			widget = clickable_container
		},
		left = dpi(lspace),
		right = dpi(rspace),
		top = dpi(tspace),
		bottom = dpi(bspace),
		widget = wibox.container.margin
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn.with_shell("rofi -no-lazy-grab -show drun -theme ~/.config/awesome/config/rofi/centered.rasi")
				end
			),
			awful.button(
				{},
				3,
				nil,
				function()
					control_center_toggle()
				end
			)
		)
	)

	return widget_button
end

return return_button
