--  ______         __   __
-- |   __ \.---.-.|  |_|  |_.-----.----.--.--.
-- |   __ <|  _  ||   _|   _|  -__|   _|  |  |
-- |______/|___._||____|____|_____|__| |___  |
--                                     |_____|
--  ________ __     __               __
-- |  |  |  |__|.--|  |.-----.-----.|  |_
-- |  |  |  |  ||  _  ||  _  |  -__||   _|
-- |________|__||_____||___  |_____||____|
--                     |_____|
-- ------------------------------------------------- --
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local clickable_container = require("utils.clickable-container")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("themes.icons")

local battery_text =
	wibox.widget {
	font = "SF Pro Rounded Heavy   15",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- create the icon portion of the text, which uses a nerd font to display the icon
local battery_icon =
	wibox.widget {
	font = "SF Pro Rounded Heavy   18",
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}

local return_button = function(color, lspace, rspace)
	local widget_button =
		wibox.widget {
		{
			{
				{
					{
						{battery_icon, margins = dpi(7), widget = wibox.container.margin},
						{battery_text, margins = dpi(1), widget = wibox.container.margin},
						widget = wibox.container.margin,
						layout = wibox.layout.fixed.horizontal
					},
					top = dpi(1),
					bottom = dpi(1),
					left = dpi(16),
					right = dpi(16),
					widget = wibox.container.margin
				},
				shape = beautiful.client_shape_rounded,
				bg = color.color,
				widget = wibox.container.background
			},
			widget = clickable_container
		},
		top = dpi(3),
		bottom = dpi(3),
		left = dpi(lspace),
		right = dpi(rspace),
		widget = wibox.container.margin
	}
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --

	--  respond to the signal changing
	awesome.connect_signal(
		"signal::battery",
		function(percentage, state)
			local value = percentage
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- default output
			local bat_icon = ""
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			--charge dependent output
			if value >= 90 and value <= 100 then
				bat_icon = ""
			elseif value >= 70 and value < 90 then
				bat_icon = ""
			elseif value >= 60 and value < 70 then
				bat_icon = ""
			elseif value >= 50 and value < 60 then
				bat_icon = ""
			elseif value >= 30 and value < 50 then
				bat_icon = ""
			elseif value >= 15 and value < 30 then
				bat_icon = ""
			else
				bat_icon = ""
			end
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- if charging
			--
			if state == 1 then
				bat_icon = ""
			end
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- if full
			--
			if state == 4 then
				bat_icon = ""
			end
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- ------------------------------------------------- --
			-- color the icon output
			battery_icon.markup = "<span foreground='#f4f4f7'>" .. bat_icon .. "</span>"
			battery_text.markup = "<span foreground='#f4f4f7'>" .. string.format("%1d", value) .. "%" .. "</span>"
		end
	)
	widget_button:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					awful.spawn("xfce4-power-manager")
				end
			)
		)
	)
	local battery_tooltip =
		awful.tooltip {
		objects = {widget_button},
		text = "None",
		mode = "outside",
		align = "right",
		margin_leftright = dpi(8),
		margin_topbottom = dpi(8),
		preferred_positions = {"right", "left", "top", "bottom"}
	}
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	-- ------------------------------------------------- --
	local get_battery_info = function()
		awful.spawn.easy_async_with_shell(
			"upower -i $(upower -e | grep BAT)",
			function(stdout)
				if stdout == nil or stdout == "" then
					battery_tooltip:set_text("No battery detected!")
					return
				end

				-- Remove new line from the last line
				battery_tooltip:set_text(stdout:sub(1, -2))
			end
		)
	end
	get_battery_info()

	return widget_button
end

return return_button
