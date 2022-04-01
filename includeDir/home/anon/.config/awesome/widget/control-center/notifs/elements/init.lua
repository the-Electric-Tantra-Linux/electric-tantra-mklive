--  _______ __                              __
-- |    ___|  |.-----.--------.-----.-----.|  |_.-----.
-- |    ___|  ||  -__|        |  -__|     ||   _|__ --|
-- |_______|__||_____|__|__|__|_____|__|__||____|_____|
-- ------------------------------------------------- --
-- declare widget
local elements = {}

-- ------------------------------------------------- --
--  widget constructor
elements.create = function(title, message)
  -- ------------------------------------------------- --
  -- box element
  local box = {}

  -- ------------------------------------------------- --
  -- clear element
  local clear =
    wibox.widget {
    {
      {
        {
          layout = wibox.layout.align.vertical,
          expand = "none",
          nil,
          {
            image = icons.clearNotificationIndividual,
            widget = wibox.widget.imagebox,
            id = "icon",
            resize = true
          },
          nil
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      shape = beautiful.client_shape_rounded,
      widget = wibox.container.background,
      bg = beautiful.bg_button
    },
    forced_width = dpi(30),
    forced_height = dpi(30),
    widget = clickable_container
  }
  -- ------------------------------------------------- --
  -- clear connect signal for mouse entry
  clear:connect_signal(
    "mouse::enter",
    function()
      clear.bg = beautiful.bg_focus
    end
  )
  -- ------------------------------------------------- --
  -- clear mouse signal for departure
  clear:connect_signal(
    "mouse::leave",
    function()
      clear.bg = beautiful.bg_button
    end
  )
  -- ------------------------------------------------- --
  -- clear button bindings
  clear:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          _G.removeElement(box)
        end
      )
    )
  )

  -- ------------------------------------------------- --
  -- notification content template
  local content =
    wibox.widget {
    {
      {
        {
          text = title,
          font = "SF Pro Rounded Heavy 10",
          widget = wibox.widget.textbox
        },
        {
          text = message,
          font = "SF Pro Rounded Heavy  8",
          widget = wibox.widget.textbox
        },
        layout = wibox.layout.align.vertical
      },
      margins = dpi(10),
      widget = wibox.container.margin
    },
    shape = beautiful.client_shape_rounded,
    widget = wibox.container.background
  }
  -- ------------------------------------------------- --
  -- box element template
  box =
    wibox.widget {
    {
      {
        nil,
        {
          image = icons.new_notif,
          widget = wibox.widget.imagebox,
          forced_height = dpi(25),
          id = "icon",
          resize = true
        },
        nil,
        halign = "center",
        valign = "center",
        forced_height = dpi(30),
        layout = wibox.layout.align.vertical
      },
      content,
      {
        {
          nil,
          clear,
          nil,
          halign = "center",
          valign = "center",
          forced_height = dpi(30),
          layout = wibox.layout.align.vertical
        },
        margins = dpi(5),
        widget = wibox.container.margin
      },
      expand = "none",
      layout = wibox.layout.align.horizontal
    },
    shape = beautiful.client_shape_rounded,
    fg = colors.white,
    bg = colors.black,
    border_width = dpi(1),
    border_color = colors.black,
    widget = wibox.container.background
  }

  return box
end

return elements
