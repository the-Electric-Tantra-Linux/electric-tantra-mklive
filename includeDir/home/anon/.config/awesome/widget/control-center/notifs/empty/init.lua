--  _______                  __
-- |    ___|.--------.-----.|  |_.--.--.
-- |    ___||        |  _  ||   _|  |  |
-- |_______||__|__|__|   __||____|___  |
--                   |__|        |_____|
-- ------------------------------------------------- --

-- ------------------------------------------------- --
-- box it renders in
local box =
	wibox.widget {
	{
		{
			layout = wibox.layout.align.horizontal,
			nil,
			{
				text = "Empty",
				font = "Nineteen Ninety Seven Bold 16",
				widget = wibox.widget.textbox,
				align = "center"
			},
			nil
		},
		widget = wibox.container.margin,
		margins = dpi(5)
	},
	shape = beautiful.client_shape_rounded_xl,
	fg = colors.white,
	bg = colors.black,
	widget = wibox.container.background
}

return box
