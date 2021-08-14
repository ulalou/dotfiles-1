--[[
Config files by MrJakeSir
--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

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
colors.polar.lightest                           = "#35383f"
colors.polar.darker                             = "#33353b"
colors.polar.lighter                            = "#434C5E"

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome/themes/nordish"

-- Sets up the wallpaper 
theme.wallpaper                                 = theme.dir .. "/wallpaper.jpg"

-- Font
theme.font                                      = "Comic Mono 10"
theme.taglist_font                              = "Comic Mono 12"

-- Gaps between windows
-- Otherwise you can change them by using:
--      altkey + ctrl + j           = Increment gaps
--      altkey + ctrl + h           = Decrement gaps
theme.useless_gap                               = 8

--  Foreground variables  --
theme.fg_normal                                 = "#ffffff"
theme.fg_focus                                  = colors.green
theme.fg_urgent                                 = "#000000"


--  Background variables  --
theme.bg_normal                                 = colors.polar.lightest 
theme.bg_focus                                  = theme.bg_normal
theme.bg_urgent                                 = colors.red

-- Systray background color
theme.bg_systray                				= colors.polar.darker

-- Systray icon spacing 
theme.systray_icon_spacing		            	= 10

-- Taglist configuration --

-- Colors
theme.taglist_fg_focus                          = "#000000"
theme.taglist_bg_focus                          = colors.green

-- Taglist shape, refer to awesome wm documentation if you have 
-- any doubt about this!
theme.taglist_shape                             = gears.shape.rounded_rect

-- Icon spacing between icons 
theme.taglist_spacing				            = 4

--[[ 
--
-- Tasklist Configuration,
-- NOTE: If you want a tasklist in your wibar,
-- UNCOMMENT THESE LINES!
theme.tasklist_bg_focus                         = "#00000000"
theme.tasklist_fg_focus                         = "#00000000"
theme.tasklist_fg_normal                        = "#00000000"
--]]

-- Sets the border to zero
theme.border_width                              = 0

-- If the border is not zero, it'll show 
-- These colors 
theme.border_normal                             = colors.orange 
theme.border_focus                              = colors.green
theme.border_marked                             = colors.green

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

-- Icons 
--theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"
--theme.awesome_icon                              = theme.dir .. "/icons/awesome.png"

-- Tiling
theme.layout_tile                               = theme.dir .. "/icons/tile.png"
theme.layout_tileleft                           = theme.dir .. "/icons/tileleft.png"
theme.layout_tilebottom                         = theme.dir .. "/icons/tilebottom.png"
theme.layout_tiletop                            = theme.dir .. "/icons/tiletop.png"
theme.layout_fairv                              = theme.dir .. "/icons/fairv.png"
theme.layout_fairh                              = theme.dir .. "/icons/fairh.png"
theme.layout_spiral                             = theme.dir .. "/icons/spiral.png"
theme.layout_dwindle                            = theme.dir .. "/icons/dwindle.png"
theme.layout_max                                = theme.dir .. "/icons/max.png"
theme.layout_fullscreen                         = theme.dir .. "/icons/fullscreen.png"
theme.layout_magnifier                          = theme.dir .. "/icons/magnifier.png"
theme.layout_floating                           = theme.dir .. "/icons/floating.png"
theme.widget_mem                                = theme.dir .. "/icons/mem.png"
theme.widget_cpu                                = theme.dir .. "/icons/cpu.png"

local markup = lain.util.markup
local separators = lain.util.separators


-- Textclock
local clockicon = wibox.widget.imagebox(theme.widget_clock)
local clock = awful.widget.watch(
    "date +' %R'", 60,
    function(widget, stdout)
        widget:set_markup(" " .. markup.font(theme.font, stdout))
    end
)

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { clock },
    notification_preset = {
        font = "Comic Mono 10",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})


-- Memory lain widget  
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        -- You can change its format here 
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
    
})



-- CPU lain widget 
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

--[[
--
--      On screet connect function 
--      This will initialize everything in
--      the screen 
--
--
--      SED: SCR_CNT
--]]


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
    --  round_bg_widget(widget, background_colour)
    function round_bg_widget(widget, bg)
      local widget = wibox.widget {
            
            -- Set up 
            {
                widget,
                -- Margin 
                left   = 10,
                spacing = 10,
                top    = 3,
                bottom = 3,
                right  = 10,
                widget = wibox.container.margin,
            },
            bg         = bg,
            fg         = "#000000",

            -- Sets the shape 
            shape      = gears.shape.rounded_rect,
            shape_clip = true,
            widget     = wibox.container.background,
        }
		
		return widget
    end
    -- The function ends

    
    ---------- Systray ----------
    local systray = round_bg_widget(wibox.widget {
        {
            -- Margin 
            wibox.widget.systray(),
            left   = 10,
            top    = 2,
            bottom = 2,
            right  = 10,
            widget = wibox.container.margin,
        },
        bg         = colors.polar.darker,
      
        -- Sets a rounded shape 
        shape      = gears.shape.rounded_rect,
        shape_clip = true,
        widget     = wibox.container.background,
    }, colors.polar.darker)
    

    ---------- Simple widget separator ----------
    local sep   = wibox.widget.textbox(" ")
    
    ---------- If you want to change the size of the spacing,
    --         change the font size, instead of 5. Just play with it!
    sep.font    = "Comic Mono 5"
    
    
    -- Creates the wibox 
    s.mywibox = awful.wibar(
                { 
                position = "top",
                align='center',
    			screen = s,
			    height = dpi(25),
                width  = dpi(860),
                shape  = gears.shape.rounded_rect,

                -- Sets an invisible background but the
                -- widgets keep showing 
			    bg = "#00000000",
			    fg = theme.fg_normal,
			    opacity = 1.0,
			    })
    
    -- Separates the wibox from the top a little bit,
    -- it you want it in the top, comment this line,
    -- or if you want to change its position, change
    -- its value
    s.mywibox.y = 8

----------------------------------------
--                                    --
--            Widget setup            --
--                                    --
----------------------------------------

    s.mywibox:setup {
        
        
        layout = wibox.layout.align.horizontal,
        
        { -- Left widgets
            
            layout = wibox.layout.fixed.horizontal,
            -- Separator 
            sep,sep, sep,

            -- Tasklist configuration
            {
              awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons),
              shape = gears.shape.rounded_bar,   
              bg = colors.polar.darker,   
              shape_clip = true,

              shape_border_width = 1,
              shape_border_color = theme.bg_normal,
              widget = wibox.container.background 
            },
            sep,
            -- s.mytaglist,
            s.mypromptbox,
            spr,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
	        
            -- Keyboard layout widget 
            -- You can comment this widget 
            -- if you dont want it, in my 
            -- case i need this because 
            -- i use two different keyboard 
            -- distributions
            round_bg_widget(
              awful.widget.keyboardlayout(),
              colors.red
            ),
            sep,

            -- Sets the system memory widget
            round_bg_widget(
              
              -- Margin widget to add spacing
              wibox.container.margin(wibox.widget { 
                memicon,
                mem.widget,
                layout = wibox.layout.align.horizontal 
              },
              dpi(2),
              dpi(3)
              ),

              -- Sets the color 
              colors.orange
            ),

            sep,
            
            -- CPU usage widget
            round_bg_widget(
				wibox.container.margin(wibox.widget {
                  cpuicon,
                  cpu.widget,
                  layout = wibox.layout.align.horizontal },
                  dpi(3),
                  dpi(4)),

                -- Sets the color 
				colors.yellow
			),
			sep,

            -- System time
			round_bg_widget(wibox.container.margin(clock,
                                                   dpi(4),
                                                   dpi(8)),
                                                   colors.green),
            
            sep,
            
            -- This widget displays the current layout
            round_bg_widget(
				s.mylayoutbox,
				colors.pink
			),
            sep,

            -- Systray 
            systray,
            
          
        },
    }
end

-- Returns the theme 
return theme
