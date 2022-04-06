--  _____                    __
-- |     \.----.-----.-----.|  |--.-----.--.--.
-- |  --  |   _|  _  |  _  ||  _  |  _  |_   _|
-- |_____/|__| |_____|   __||_____|_____|__.__|
--                   |__|
--  _______                     __
-- |_     _|.-----.-----.-----.|  |.-----.
--   |   |  |  _  |  _  |  _  ||  ||  -__|
--   |___|  |_____|___  |___  ||__||_____|
--                |_____|_____|
-- ------------------------------------------------- --
local config_dir = gears.filesystem.get_configuration_dir()
local widget_icon_dir = config_dir .. "themes/icons/svg/"

local device_state = false
-- ------------------------------------------------- --
-- Icons
--
local dropbox_status_blank = widget_icon_dir .. "dropbox.svg"
local dropbox_status_busy2 = widget_icon_dir .. "dropboxstatus-busy2.png"
local dropbox_status_busy1 = widget_icon_dir .. "dropboxstatus-busy1.png"
local dropbox_status_idle = widget_icon_dir .. "dropboxstatus-idle.png"
local dropbox_status_logo = widget_icon_dir .. "dropbox.svg"
local dropbox_status_x = widget_icon_dir .. "dropbox-x.svg"
-- ------------------------------------------------- --
-- Text for toggle button
--
local action_name =
    wibox.widget {
    text = "Dropbox",
    font = "SF Pro Rounded Heavy    10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- text for dropbox status (on of off)
--
local action_status =
    wibox.widget {
    text = "Off",
    font = "SF Pro Rounded Heavy    10",
    align = "left",
    widget = wibox.widget.textbox
}
-- ------------------------------------------------- --
-- Title and status in box
--
local action_info =
    wibox.widget {
    layout = wibox.layout.fixed.vertical,
    action_name,
    action_status
}
-- ------------------------------------------------- --
-- button template
local button_widget =
    wibox.widget {
    nil,
    {
        id = "icon",
        image = icons.dropboxstatus_logo,
        widget = wibox.widget.imagebox,
        resize = true
    },
    nil,
    expand = "none",
    layout = wibox.layout.align.horizontal
}

-- ------------------------------------------------- --
-- button template wrapper for sizing etc
--
local widget_button =
    wibox.widget {
    {
        {
            {
                button_widget,
                widget = wibox.container.place,
                halign = "center",
                valign = "center"
            },
            margins = dpi(10),
            widget = wibox.container.margin
        },
        forced_height = dpi(50),
        widget = clickable_container
    },
    bg = colors.colorA,
    shape = beautiful.client_shape_rounded_small,
    widget = wibox.container.background
}
-- ------------------------------------------------- --
-- update the widget
--
local update_widget = function(device_state)
    if device_state == true then
        action_status:set_text("On")

        button_widget.icon:set_image(icons.dropboxstatus_logo)
    elseif device_state == false then
        action_status:set_text("Off")

        button_widget.icon:set_image(icons.dropboxstatus_x)
    end
end

-- ------------------------------------------------- --
-- checks state of the widget
--
local check_device_state = function(stdout)
    if stdout:match("Dropbox isn't running!") then
        device_state = false
    else
        device_state = true
    end

    update_widget(device_state)
end

-- ------------------------------------------------- --
-- provides on command

local power_on_cmd =
    [[
dropbox start &
	sleep 1
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Dropbox - Powering On',
		title = 'System Notification',
		message = 'Initializing Dropbox...',
		icon = ']] ..
    widget_icon_dir .. "dropboxstatus-logo" .. ".png" .. [['
	})
	"
]]
-- ----- ------------------------------------------------- --
-- power off command
--
local power_off_cmd =
    [[
dropbox stop &https://github.com/endaaman/tym
sleep 1
	# Create an AwesomeWM Notification
	awesome-client "
	naughty = require('naughty')
	naughty.notification({
		app_name = 'Dropbox - Powering Off',
		title = 'System Notification',
		message = 'The dropbox daemon has been disabled.',
		icon = ']] ..
    widget_icon_dir .. "dropboxstatus-x" .. ".png" .. [['
	})
	"
]]
-- ------------------------------------------------- --
-- Toggles the command between on & off + vice versa
local toggle_action = function()
    if device_state then
        awful.spawn.easy_async_with_shell(
            power_off_cmd,
            function(stdout)
                device_state = false
                update_widget(device_state)
            end
        )
    else
        awful.spawn.easy_async_with_shell(
            power_on_cmd,
            function(stdout)
                device_state = true
                update_widget(device_state)
            end
        )
    end
end
-- ------------------------------------------------- --
-- provides buttons
--
widget_button:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_action()
            end
        )
    )
)

action_info:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                toggle_action()
            end
        )
    )
)
-- ------------------------------------------------- --
-- determine state by watching command
--
awful.spawn.easy_async_with_shell(
    "dropbox status &",
    function(stdout)
        check_device_state(stdout)
    end
)
-- ------------------------------------------------- --
-- final wrapper around button/command,
--  DESIGN NOTE: I hace used the align layout and the two nil values as a means of insuring the widget spaces out the icon on the button appropiately
--
local action_widget =
    wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
    widget_button
    --[[    {
        layout = wibox.layout.align.vertical,
        expand = "none",
        nil,
        action_info,
        nil
    } ]]
}

return action_widget
