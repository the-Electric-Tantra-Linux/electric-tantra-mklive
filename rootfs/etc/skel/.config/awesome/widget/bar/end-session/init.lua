--  _______           __
-- |    ___|.-----.--|  |
-- |    ___||     |  _  |
-- |_______||__|__|_____|

--  _______                     __
-- |     __|.-----.-----.-----.|__|.-----.-----.
-- |__     ||  -__|__ --|__ --||  ||  _  |     |
-- |_______||_____|_____|_____||__||_____|__|__|

--  ________ __     __               __
-- |  |  |  |__|.--|  |.-----.-----.|  |_
-- |  |  |  |  ||  _  ||  _  |  -__||   _|
-- |________|__||_____||___  |_____||____|
--                     |_____|
-- ------------------------------------------------- --
local return_button = function(color, lspace, rspace)
	local widget_button =
		wibox.widget {
		{
			{
				{
					{
						image = icons.power,
						widget = wibox.widget.imagebox
					},
					top = dpi(4),
					bottom = dpi(4),
					left = dpi(12),
					right = dpi(12),
					widget = wibox.container.margin
				},
				shape = gears.shape.rounded_bar,
				bg = color.color,
				widget = wibox.container.background
			},
			forced_width = icon_size,
			forced_height = icon_size,
			widget = clickable_container
		},
		top = dpi(3),
		bottom = dpi(3),
		left = dpi(lspace),
		right = dpi(rspace),
		widget = wibox.container.margin
	}

	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					_G.exit_screen_show()
				end
			)
		)
	)

	return widget_button
end

return return_button
