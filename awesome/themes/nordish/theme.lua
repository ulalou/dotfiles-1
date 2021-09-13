--[[
Config files by MrJakeSir
--]]

local gears = require("gears")
local lain  = require("lain")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Constants
TERMINAL                                        = "kitty"
--BROWSER                                         = "chromium"

-- Nord theme colorscheme
local colors                                    = {}

--
---- Aurora Nord Scheme
colors.green                                    = "#D8EFCFFA"
colors.alpha_zero                               = "#00000000"
colors.red                                      = "#FFB9af"
colors.orange                                   = "#F3cbb8"
colors.yellow                                   = "#fefecf"
colors.pink                                     = "#fedfef"

---- Frost
colors.frost                                    = {}
colors.frost.darkest                            = "#222529"
colors.frost.lightest                           = "#b4d9e3"
colors.frost.aqua                               = "#41464c"
colors.frost.light_green                        = "#8FBCBB"

---- Snow Storm
colors.light                                    = {}
colors.light.lighter                            = "#ECEFF4"
colors.light.darker                             = "#D8DEE9"
colors.light.medium                             = "#E5E9F0"
--
---- Polar night
colors.polar                                    = {}
colors.polar.darkest                            = "#2E3440"
colors.polar.lightest                           = "#1e222a"
colors.polar.darker                             = "#3f434c"
colors.polar.lighter                            = "#434C5E"
colors.bg                                       = "#1b1f27"
local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/nordish"

-- Sets up the wallpaper 
theme.wallpaper                                 = theme.dir .. "/wallpaper.jpg"

-- Font
theme.font                                      = "JetBrainsMono Nerd Font 11"
theme.taglist_font                              = "JetBrainsMono Nerd Font 15"

-- Gaps between windows
-- Otherwise you can change them by using:
--      altkey + ctrl + j           = Increment gaps
--      altkey + ctrl + h           = Decrement gaps
theme.useless_gap                               = 0

--  Foreground variables  --
theme.fg_normal                                 = "#ffffff" -- White
theme.fg_focus                                  = colors.green
theme.fg_urgent                                 = "#000000" -- Black
--  Background variables  --
theme.bg_normal                                 = colors.bg
theme.bg_focus                                  = theme.bg_normal
theme.bg_urgent                                 = colors.red

-- Systray background color
theme.bg_systray                	        = colors.polar.darkest

-- Systray icon spacing 
theme.systray_icon_spacing		        = 10

-- Taglist configuration --
theme.taglist_bg_occupied                       = colors.polar.darkest
theme.taglist_fg_occupied                       = colors.yellow
theme.taglist_bg_empty                          = colors.polar.darkest 
theme.taglist_fg_empty                          = colors.green
theme.taglist_bg_urgent                         = colors.polar.darkest
theme.taglist_fg_urgent                         = colors.pink
theme.taglist_fg_volatile                       = colors.frost.lightest
theme.taglist_bg_volatile                       = colors.polar.darkest
-- Colors
theme.taglist_fg_focus                          = colors.light.medium
theme.taglist_bg_focus                          = colors.polar.darkest
-- Taglist shape, refer to awesome wm documentation if you have 
-- any doubt about this!
theme.taglist_shape                             = gears.shape.rounded_rect

-- Icon spacing between workspace icons 
theme.taglist_spacing				= 0

-- Sets the border to zero
theme.border_width                              = 2

-- If the border is not zero, it'll show 
-- These colors 
theme.border_normal                             = colors.polar.lightest 
theme.border_focus                              = colors.polar.lightest
theme.border_marked                             = colors.polar.lightest

-- Titlebar variables, dont care about theme,
-- In this configuration file we wont use it!
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus

-- Menu variables
theme.menu_height                               = dpi(25)
theme.menu_width                                = dpi(260)

local markup = lain.util.markup

local clock = awful.widget.watch(
    "date +' %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

function theme.at_screen_connect(s)
    
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end

    gears.wallpaper.maximized(wallpaper, s, true)

    -- All tags open with layout 1
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    
    
    -- Custom rounded background widget
    -- You can modify however you want
    -- Syntax:
    --  round_bg_widget(widget, background_colour, foreground)
    function round_bg_widget(widget, bg, fg)
      local widget = wibox.widget {
            
            -- Set up 
            {
                widget,
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
		
		return widget
    end
    -- The function ends
    
    function add_app(app, text, fg, bg, desc)     
            -- Set up 
        local popup = awful.popup {
          widget = {
              {
                text = desc,
                widget = wibox.widget.textbox
              },
              margins = 20,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
        }
        local widget = wibox.widget {
            {
                {
                text = text,
                font = "JetBrainsMono Nerd Font 15",
                widget = wibox.widget.textbox
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
        -- When pressed the widget, it will
        -- change its color and spawn the app
        widget:connect_signal("button::press",
            function()
                widget.fg = colors.frost.lightest
                awful.spawn.with_shell(app)
            end
        )

        -- This function will be called when the button  is 
        -- released
        widget:connect_signal("button::release",
            function()
                widget.fg = fg
            end
        )

        -- When its on hover, it will change its color
        widget:connect_signal("mouse::enter",
            function()
                popup:move_next_to(mouse.current_widget_geometry)
                popup.visible = true
                widget.fg = colors.light.lighter
            end
        )
        
        widget:connect_signal("mouse::leave",
            function()
                widget.fg = fg
                popup.visible = false
            end
        )
        return widget
    end
    ---------- Simple widget separator ----------
    local sep   = wibox.widget.textbox("  ")
    
    ---------- If you want to change the size of the spacing,
    --         change the font size, instead of 5. Just play with it!
    sep.font    = "JetBrainsMono Nerd Font 10"
    
    local k = awful.widget.keyboardlayout()
    k:connect_signal("button::press",
      function()
        awful.spawn.with_shell("python3 $HOME/.config/awesome/keyboard.py")
      end
    )
    function on_hover_msg(widget, message)
      local popup = awful.popup {
          widget = {
              {
                text = message,
                widget = wibox.widget.textbox
              },
              margins = 20,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
      }
      widget:connect_signal("mouse::enter",
        function()
          popup:move_next_to(mouse.current_widget_geometry)
          popup.visible = true
        end
      )

      widget:connect_signal("mouse::leave",
        function()
          popup.visible = false
        end
      )

      return widget
    end


    local menu = wibox.widget {
            {
                {
                    image  = theme.dir .. "/awesome.svg",
                    resize = true,
                    widget = wibox.widget.imagebox
                },
                --Margin 
                left   = 5,
                spacing = 20, 
                right  = 5,
                widget = wibox.container.margin,
            },
            
            bg         = colors.polar.darkest .. "AF",
            fg         = theme.bg_normal,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
    
    -- When pressed the widget, it will
    -- change its color and spawn the menu
    menu:connect_signal("button::press",
        function()
          awful.util.mymainmenu:toggle()
        end
    )

    local appsep= wibox.widget.textbox("  ")
    appsep.font = "JetBrainsMono Nerd Font 5"
    
    -- Systray -- 
    local systray = round_bg_widget(
      wibox.widget.systray(),
      colors.polar.darkest,
      colors.green
    )

    --
    -- Volume widget
    --
    vol = wibox.widget{
            -- Set up 
           {
                {
                     
                    layout=wibox.layout.fixed.horizontal,
                    {
                        {
                          text="",
                          font="JetBrainsMono Nerd Font 15",
                          widget=wibox.widget.textbox
                        },
                        fg = colors.frost.lightest,
                        widget = wibox.container.background,
                    },

                    {
                        {
                          {
                            volume_widget{
                              main_color=colors.frost.lightest,
                              widget_type = 'horizontal_bar',
                              bg_color=colors.polar.lighter
                            },
                            top = 1, right = 5,
                            bottom=2, left = 5,
                            widget = wibox.container.margin
                          },
                          
                          bg = colors.polar.darkest,
                          shape  = gears.shape.rounded_bar,
                          shape_clip = true,
                          widget = wibox.container.background
                        },
                        widget = wibox.container.margin,
                    },
                    widget = wibox.container.background
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 0,
                bottom = 0,
                right  = 10,
                widget = wibox.container.margin,
            },

            bg         = colors.polar.darkest,
            fg         = colors.green,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
    }
    
    function fetch_popup(app, text, fg, bg)
      local widget = wibox.widget {
            {
                {
                text = text,
                font = "JetBrainsMono Nerd Font 15",
                widget = wibox.widget.textbox
                },
                -- Margin 
                left   = 10,
                spacing = 20,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            
            bg         = bg,
            fg         = fg,

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
      }
      -- Popup   
      local popup = awful.popup{
          widget = {
              {
                {
                  {
                    image          = theme.dir .. "/awesome.svg",
                    resize         = true,
                    forced_width   = 128,
                    forced_height  = 128,
                    widget         = wibox.widget.imagebox
                  },
                  margins = 20,
                  widget = wibox.container.margin
                },
                {
                  {
                    awful.widget.watch(
                    [[bash -c "neofetch --stdout | python3 $HOME/.config/awesome/match.py -pipe -p '.+\[3\dm(.+)\n'"]], 16
                    ),
                    margins = 20,
                    widget = wibox.container.margin
                  },
                  shape = gears.shape.rounded_rect,
                  widget = wibox.container.background,
                  bg = colors.polar.darkest .. "ea"
                },
                shape = gears.shape.rounded_rect,
                widget = wibox.container.background,
                layout = wibox.layout.fixed.horizontal
              },
              margins = 20,
              widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
      }

      -- When pressed the widget, it will
      -- change its color and spawn the app
      widget:connect_signal("button::press",
          function()
              widget.fg = colors.frost.lightest
              awful.spawn.with_shell(app)
          end
      )

      -- This function will be called when the button  is 
      -- released
      widget:connect_signal("button::release",
          function()
              widget.fg = fg
          end
      )

      -- When its on hover, it will change its color
      widget:connect_signal("mouse::enter",
          function()
              popup:move_next_to(mouse.current_widget_geometry)
              popup.visible = true
              widget.fg = colors.light.lighter
          end
      )
      
      widget:connect_signal("mouse::leave",
          function()
              widget.fg = fg
              popup.visible = false
          end
      )

      return widget
    end

    -- Creates the wibox 
    s.mywibox = awful.wibar(
      { 
        position = "top",
        screen = s,
        height = dpi(25),
        width = s.workarea.width-40-theme.border_width-7,
        bg = theme.bg_normal,
        fg = theme.fg_normal,
        border_width = 5,
        border_color = colors.polar.lightest,
      }
    )

    local time = round_bg_widget(wibox.container.margin(clock,
               dpi(4),
               dpi(8)),
               colors.polar.darkest,
               colors.frost.lightest
            )
    
    function calendar(widget)
      local popup = awful.popup {
          widget = {
            {
              {
                text = "── Calendar ──",
                align="center",
                widget = wibox.widget.textbox
              },
              widget = wibox.container.background
            },
            {
              {
                {
                  text = "",
                  align = "center",
                  font = "JetBrainsMono Nerd Font 60",
                  widget = wibox.widget.textbox
                },
                right = 20,
                left = 30,
                widget = wibox.container.margin
              },
              {
                {
                  {
                    
                    {
                      {
                        text = "Today is a great day!",
                        widget = wibox.widget.textbox
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.red,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %B",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.green,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %d",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                     {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.pink,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %Y",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.yellow,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %A",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },
                      {
                        {
                          {
                            text = "",
                            widget = wibox.widget.textbox
                          },
                          fg = colors.frost.lightest,
                          widget = wibox.container.background,
                        },
                        {
                          format = " %H:%M%p ",
                          refresh = 60,
                          widget = wibox.widget.textclock
                        },
                        margins = 5,
                        widget = wibox.container.margin,
                        layout = wibox.layout.fixed.horizontal
                      },                    
                      expand = 'none',
                      widget = wibox.container.background,
                      layout = wibox.layout.fixed.vertical
                    },

                    margins = 10,
                    widget = wibox.container.margin,
                  },

                  bg = colors.polar.darkest.."5a",
                  shape = gears.shape.rounded_rect,
                  widget = wibox.container.background
                },
                margins = 10,
                widget = wibox.container.margin
              },
              layout = wibox.layout.fixed.horizontal,

            },
            layout = wibox.layout.fixed.vertical,
            widget = wibox.container.margin
          },
          bg = theme.bg_normal,
          fg = theme.fg_normal,
          ontop=true,
          shape        = gears.shape.rounded_rect,
          visible      = false,
      }
      widget:connect_signal("mouse::enter",
        function()
          popup:move_next_to(mouse.current_widget_geometry)
          popup.visible = true
        end
      )

      widget:connect_signal("mouse::leave",
        function()
          popup.visible = false
        end
      )

      return widget
    end 
    local time = calendar(time)
    s.mywibox.y = 10
    
---------------------------------------
--                                    --
--            Widget setup            --
--                                    --
----------------------------------------
    
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand='none',

        { -- Left widgets
            appsep, appsep, appsep,
            menu, appsep, appsep, appsep,
            s.mypromptbox,
            -- Workspaces
            wibox.widget{
                {
                    awful.widget.taglist{
                      screen = s,
                      filter = awful.widget.taglist.filter.all,
                      buttons = awful.util.taglist_buttons
                    },

                    left   = 3,
                    top    = 2,
                    bottom = 2,
                    right  = 3,
                    widget = wibox.container.margin
                },
                shape = gears.shape.rounded_bar,
                bg = colors.polar.darkest,
                
                widget = wibox.container.background
            },

            -- Separator 
            {
                text="    ",
                font="JetBrainsMono Nerd Font 10",
                widget = wibox.widget.textbox
            },
            
            layout = wibox.layout.fixed.horizontal,
        },
        { -- center widgets
            layout = wibox.layout.fixed.horizontal,
            on_hover_msg(vol, "System volume\nWheel up to increase volume\nWheel down to decrease volume\nClick to mute"),
            sep,
            time,
            appsep,
            on_hover_msg(round_bg_widget(
               {
                layout = wibox.layout.fixed.horizontal,
                {
                  text = "",
                  font = "JetBrainsMono Nerd Font 12",
                  widget = wibox.widget.textbox,
                },
                
                k,
                
               },
               colors.polar.darkest,
               colors.frost.lightest
               
            ), "Keyboard Layout\nclick to swap map"),
            appsep,
            on_hover_msg(round_bg_widget(
               {
                layout = wibox.layout.fixed.horizontal,
                {
                  text = " ﬿",
                  font = "JetBrainsMono Nerd Font 12",
                  widget = wibox.widget.textbox
                },
                
                awful.widget.layoutbox()
                
               },
               colors.polar.darkest,
               colors.frost.lightest
            ), "Current layout"),
            appsep,
            -- Systray 
            on_hover_msg(systray, "System tray"),
            appsep,
        },

        {
          -- right widgets
          layout = wibox.layout.fixed.horizontal,
          add_app(
              TERMINAL .." -e nmtui",
              "",
              colors.yellow,
              colors.polar.darkest,
              "Internet configuration"
          ),
          appsep,
          fetch_popup(
              TERMINAL .." -e htop",
              "",
              colors.green,
              colors.polar.darkest
              --"Prueba"
          ),
          appsep,
          add_app(
              "shutdown now",
              "",
              colors.red,
              colors.polar.darkest,
              "Shutdowns the computer"
          ),
          appsep,
          add_app(
              "reboot",
              "",
              colors.red,
              colors.polar.darkest,
              "Reboots the computer"
          ),
          appsep,
          add_app(
              "systemctl suspend",
              "鈴",
              colors.red,
              colors.polar.darkest,
              "Suspends the computer"
          ), appsep, appsep, appsep
        }
    }
    awful.screen.padding(screen[s], {top = 25, left = 20,
                                    right = 20, bottom = 10})
end

-- Returns the theme 
return theme
