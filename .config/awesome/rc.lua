-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--Wiget Library
require("vicious")
-- awesoMPD Widget
--require("awesompd/awesompd")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/blind-alien/theme.lua")

-- Env variables
home = os.getenv("HOME")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Enable or disable widgets:
-- You also have to edit the wiboxes!
useSysInfo = true
usePacman = true
useMpd = true
useWifi = true
useNet = true
useBat = true
useCpu = true
useMem = true
useTemp = true
-----------------

-- Widget Settings
cpuCores = 2 --Number of CPU Cores
thermalZone = "coretemp.0" --Thermal Zone to read cpu temperature from (check vicious docu)
thermalData = "core" --Data Source: "proc", "core" or "sys"
netAdapter = "eth0" --Network adapter to monitor
wifiAdapter = "wlan0" --Wifi adapter for wifi widget
pacUpdate = "yaourt -Sy" --Command to update pacman cache
pacUpgrade = "yaourt -Su" --Command to upgrade system
networkManager = terminal .. " -e wicd-curses"
battery = "BAT0" --Battery to monitor
widthMpd = 420 --Width of MPD widget
-----------------

-- Widget update intervals in seconds
updateCpu = 5
updatePac = 1801
updateMpd = 7
updateWifi = 7
updateNet = 1
updateBat = 31
updateMem = 7
-----------------

-- For Dual-Screen setups:
-- Set "dualScreen" to "2" if you want a different, optimized widget layout for every screen.
-- If you set it to "-1" it will copy the same widget layout to both screens. (default Awesome behavior)
dualScreen = 2
-----------------


screencount = screen.count()

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.magnifier,
  awful.layout.suit.floating,
  awful.layout.suit.max
}
-- }}}

-- {{{ Tags

-- Define a tag table which will hold all screen tags.
tags = {
  --names = { "1", "2", "3", "4", "5", "6"},
  --names  = { "⌘", "♐", "⌥", "ℵ"},
  --names  = { "⠪", "⠫", "⠬", "⠭", "⠮", "⠳"},
  names = { "⠐", "⠡", "⠪", "⠵", "⠻", "⠿" },
  --names  = { " ∙", "⠡", "⠲", "⠵", "⠻", "⠿"},
  --names  = { " ⠐ ", " ⠡ ", " ⠲ ", " ⠵ ", " ⠾ ", " ⠿ "},
  --names  = { "⢷", "⣨", "⡪", "⣌", "⣪", "⡝"},
  layout = {
    layouts[8], layouts[8], layouts[8], layouts[8], layouts[8], layouts[8]
  }
}
for s = 1, screencount do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
awe_menu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

open_menu = {
	{ "terminal", terminal},
	{ "browser", "chromium"},
	{ "files", "thunar"},
}

system_menu = {
	{ "log out", awesome.quit },
	{ "suspend", "sudo pm-suspend"},
	{ "hibernate", "sudo pm-hibernate"},
	{ "reboot", "sudo reboot"},
	{ "shut down", "sudo halt"},
}

monitors_menu = {
	{ "mirror", home .. "/Scripts/Arch/monitors.sh mirror"},
	{ "dual (left)", home .. "/Scripts/Arch/monitors.sh dual-left"},
	{ "dual (right)", home .. "/Scripts/Arch/monitors.sh dual-right"},
	{ "off", home .. "/Scripts/Arch/monitors.sh off"},
}

awe_main_menu = awful.menu({
  items = {
    { "awesome", awe_menu, beautiful.awesome_icon },
    { "open", open_menu },
    { "monitors", monitors_menu },
    { "system", system_menu },
  }
})

mylauncher = awful.widget.launcher({
  image = image(beautiful.awesome_icon),
  menu = awe_main_menu
})
-- }}}

-- Separators

bubble = widget({ type = "textbox" })
spacer = widget({ type = "textbox" })
space = widget({ type = "textbox" })
separator = widget({ type = "textbox" })
bracketl = widget({ type = "textbox" })
bracketr = widget({ type = "textbox" })
vertline = widget({ type = "textbox" })
dash = widget({ type = "textbox" })
bubble.text = " ∘ "
spacer.text = "  "
space.text = " "
--separator.text = "<span font_desc='ClearlyU'> ⡾ </span>"
separator.text = "] ["
vertline.text = "|"
dash.text = "-"
bracketl.text = "["
bracketr.text = "]"


-- Status Labels
cpuLabel = {}
for s = 1, cpuCores do
  cpuLabel[s] = widget({ type = "textbox" })
  cpuLabel[s].text = "Core " .. s
end

rlabel = widget({ type = "textbox" })
rlabel.text = "Root:"
hlabel = widget({ type = "textbox" })
hlabel.text = "Home:"


  -- WIDGETS --


-- OS info
if useSysInfo == true then
  sys = widget({ type = "textbox" })
  vicious.register(sys, vicious.widgets.os, "$1 $2")
end


-- Pacman updates
if usePacman == true then
  -- Widget
  pnoghosticon = widget({ type = "imagebox" })
  pnoghosticon.image = image(beautiful.widget_pacnoghost)
  pnoghosticon.visible = true

  pghosticon = awful.widget.launcher({
    image = beautiful.widget_pacghost,
    command = terminal .. " -e " .. pacUpgrade .. " && echo -e 'vicious.force({ pacup, })' | awesome-client"
  })
  pghosticon.visible = false

  -- Icon
  -- picon = widget({ type = "imagebox" })
  -- picon.image = image(beautiful.widget_pacnew)
  -- Use the Pacman icon as launcher to update the package list (change to fit your package-management system)
  picon = awful.widget.launcher({
    image = beautiful.widget_pacnew,
    command = pacUpdate .. " && echo -e 'vicious.force({ pacup, })' | awesome-client"
  })

  runpicon = awful.widget.launcher({
    image = beautiful.widget_pacman_run,
    command = pacUpdate .. " && echo -e 'vicious.force({ pacup, })' | awesome-client"
  })
  runpicon.visible = false

  pacup = widget({ type = "textbox" })
  vicious.register(pacup, vicious.widgets.pkg,
    function(widget, args)
      local nr = tonumber(args[1])
      if nr ~= 0 then
        pnoghosticon.visible = false
        pghosticon.visible = true
        picon.visible = false
        runpicon.visible = true
      else
        pghosticon.visible = false
        pnoghosticon.visible = true
        runpicon.visible = false
        picon.visible = true
      end
    end, updatePac, "Arch")
end




-- MPD Widget
if useMpd == true then
  -- PLAY, STOP, PREV/NEXT Buttons
  -- requires modification of /usr/share/awesome/lib/awful/widget/launcher.lua
  --  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn(args.command) end))
  --  to:
  --  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn_with_shell(args.command) end))
  music_play = awful.widget.launcher({
    image = beautiful.widget_play,
    command = "mpc toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_pause = awful.widget.launcher({
    image = beautiful.widget_pause,
    command = "mpc toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })
  music_pause.visible = false

  music_stop = awful.widget.launcher({
    image = beautiful.widget_stop,
    command = "mpc stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_prev = awful.widget.launcher({
    image = beautiful.widget_prev,
    command = "mpc prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })

  music_next = awful.widget.launcher({
    image = beautiful.widget_next,
    command = "mpc next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
  })


  mpdicon = widget({ type = "imagebox" })
  mpdicon.image = image(beautiful.widget_mpd)
  -- Initialize widget
  mpdwidget = widget({ type = "textbox" })
  --mpdwidget.wrap = "none"
  mpdwidget.width = widthMpd
  --mpdwidget.wrap = "word_char"
  -- Register Widget
  --vicious.register(mpdwidget, vicious.widgets.mpd, "(${state}) : ${Artist} - ${Title} ]", 13)
  -- Set the maximum width of the MPD widget inside the string.format function as "%.<length>s"
  vicious.register(mpdwidget, vicious.widgets.mpd,
    function(widget, args)
    --local maxlength = 85
      local font = beautiful.font
      local string = args["{Artist}"] .. " - " .. args["{Title}"]
      --local string = "[" .. args["{state}"] .. "]" .. " : " .. args["{Artist}"] .. " - " .. args["{Title}"]

      --[[                if maxlength < string.len(string) then
        return "<span font_desc='" .. font .. "'>" .. string.sub(string, 0, maxlength-6)  .. "</span> ..."
      else
        return "<span font_desc='" .. font .. "'>" .. string .. "</span>"
      end]]

      if args["{state}"] == "Play" then
        music_play.visible = false
        music_pause.visible = true
      else
        music_play.visible = true
        music_pause.visible = false
      end
      return string
    end, updateMpd)
end



-- WIFI Widget
if useWifi == true then
  wifiwidget = widget({ type = "textbox" })
  wifiwidget.width = 25
  wifiwidget.align = "right"
  --wifiimage = widget({ type = "imagebox" })
  wifiimage0 = awful.widget.launcher({
    image = beautiful.widget_wifi0,
    command = networkManager
  })
  wifiimage0.image.visible = true

  wifiimage1 = awful.widget.launcher({
    image = beautiful.widget_wifi1,
    command = networkManager
  })
  wifiimage1.image.visible = false

  wifiimage2 = awful.widget.launcher({
    image = beautiful.widget_wifi2,
    command = networkManager
  })
  wifiimage2.image.visible = false

  wifiimage3 = awful.widget.launcher({
    image = beautiful.widget_wifi3,
    command = networkManager
  })
  wifiimage3.image.visible = false

  wifiimage4 = awful.widget.launcher({
    image = beautiful.widget_wifi4,
    command = networkManager
  })
  wifiimage4.image.visible = false

  -- Register Widget
  -- change to the desired network adapter if needed
  --vicious.register(wifiwidget, vicious.widgets.wifi, "~ ${link}%", 5, "wlan0")
  vicious.register(wifiwidget, vicious.widgets.wifi,
    function(widget, args)
      if tonumber(args["{link}"]) > 75 then
        wifiimage0.visible = false
        wifiimage1.visible = false
        wifiimage2.visible = false
        wifiimage3.visible = false
        wifiimage4.visible = true
      elseif tonumber(args["{link}"]) > 50 then
        wifiimage0.visible = false
        wifiimage1.visible = false
        wifiimage2.visible = false
        wifiimage3.visible = true
        wifiimage4.visible = false
      elseif tonumber(args["{link}"]) > 25 then
        wifiimage0.visible = false
        wifiimage1.visible = false
        wifiimage2.visible = true
        wifiimage3.visible = false
        wifiimage4.visible = false
      elseif tonumber(args["{link}"]) > 0 then
        wifiimage0.visible = false
        wifiimage1.visible = true
        wifiimage2.visible = false
        wifiimage3.visible = false
        wifiimage4.visible = false
      else
        wifiimage0.visible = true
        wifiimage1.visible = false
        wifiimage2.visible = false
        wifiimage3.visible = false
        wifiimage4.visible = false
      end
      return string.format("%02d%%", tonumber(args["{link}"]))
    end, updateWifi, wifiAdapter)
end



-- NETWORK Widget
if useNet == true then
  dnicon = widget({ type = "imagebox" })
  upicon = widget({ type = "imagebox" })
  dnicon.image = image(beautiful.widget_down)
  upicon.image = image(beautiful.widget_up)
  -- Initialize widget
  netdnwidget = widget({ type = "textbox" })
  netdnwidget.width = 55
  --netdnwidget.align = "right"

  netupwidget = widget({ type = "textbox" })
  netupwidget.width = 55
  --netupwidget.align = "right"
  -- Register widget
  -- change to the desired network adapter if needed
  --vicious.register(netdnwidget, vicious.widgets.net, "${eth0 down_kb} kB/s", 1)
  --vicious.register(netupwidget, vicious.widgets.net, "${eth0 up_kb} kB/s", 1)

  -- The following code formats the output to fill with zeroes at the beginning i.e. 013 kB/s instead of 13 kB/s.
  -- It also automatically switches to MB/s if there is more than 999 kB/s
  vicious.register(netdnwidget, vicious.widgets.net,
    function(widget, args)
      if tonumber(args["{" .. netAdapter .. " down_kb}"]) > 999 then
        return string.format("%04.1f MB/s", tonumber(args["{" .. netAdapter .. " down_mb}"]))
      else
        return string.format("%03d kB/s", tonumber(args["{" .. netAdapter .. " down_kb}"]))
      end
    end, updateNet)

  vicious.register(netupwidget, vicious.widgets.net,
    function(widget, args)
      if tonumber(args["{" .. netAdapter .. " up_kb}"]) > 999 then
        return string.format("%04.1f MB/s", tonumber(args["{" .. netAdapter .. " up_mb}"]))
      else
        return string.format("%03d kB/s", tonumber(args["{" .. netAdapter .. " up_kb}"]))
      end
    end, updateNet)
end



-- BATTERY widget
if useBat == true then
  baticon = widget({ type = "imagebox" })
  --baticon.image = image(beautiful.widget_batfull)
  --Initialize widget
  batwidget = widget({ type = "textbox" })
  batwidget.width = 25
  batwidget.align = "right"
  --Register widget
  --vicious.register(batwidget, vicious.widgets.bat, "$1$2", 31, "BAT1")
  vicious.register(batwidget, vicious.widgets.bat,
    function(widget, args)
      if string.match(args[1], "[+↯]") then
        baticon.image = image(beautiful.widget_ac)
      elseif tonumber(args[2]) > 40 then
        baticon.image = image(beautiful.widget_batfull)
      elseif tonumber(args[2]) > 20 then
        baticon.image = image(beautiful.widget_batlow)
      else
        baticon.image = image(beautiful.widget_batempty)
      end
      if tonumber(args[2]) == 100 then
        return "Full"
      end
      return args[2] .. "%"
    end, updateBat, battery)
end



-- {{{ CPU
if useTemp == true then
  -- Core Temp
  tempwidget = widget({ type = "textbox" })
  tempwidget.width = 26
  tempwidget.align = "right"
  vicious.register(tempwidget, vicious.widgets.thermal, "$1 C", updateCpu, { thermalZone, thermalData })
  --vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 5, { "thermal_zone0", "sys" })

  -- Icon
  tempicon = widget({ type = "imagebox" })
  tempicon.image = image(beautiful.widget_temp)
end

-- Readout
if useCpu == true then
  -- Icon
  cpuicon = widget({ type = "imagebox" })
  cpuicon.image = image(beautiful.widget_cpu)

  -- Core 1 Meter
  cpubar = {}
  freq = {}
  displayCores = {}
  displayCpu = {}

  for s = 1, cpuCores do
    cpubar[s] = awful.widget.progressbar()
    cpubar[s]:set_width(50)
    cpubar[s]:set_height(6)
    cpubar[s]:set_vertical(false)
    cpubar[s]:set_background_color("#434343")
    --cpubar:set_color(beautiful.fg_normal)
    cpubar[s]:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
    --Delete the following line if you want to put the widget on the left side of the wibox
    cpubar[s].layout = awful.widget.layout.horizontal.rightleft
    vicious.register(cpubar[s], vicious.widgets.cpu, "$" .. s, updateCpu)
    awful.widget.layout.margins[cpubar[s].widget] = { top = 6 }

    -- Frequency
    freq[s] = widget({ type = "textbox" })
    freq[s].width = 44
    freq[s].align = "right"
    --vicious.register(freq1, vicious.widgets.cpufreq, "$2 GHz", 9, "cpu0")
    vicious.register(freq[s], vicious.widgets.cpufreq,
      function(widget, args)
        return string.format("%03.1f GHz", args[2])
      end, updateCpu, "cpu" .. s - 1)

  -- Cache that shit
  vicious.cache(vicious.widgets.cpu)
  end
end
-- }}} CPU




-- {{{ MEM
if useMem == true then
  -- Icon
  memicon = widget({ type = "imagebox" })
  memicon.image = image(beautiful.widget_mem)
  -- Percentage
  --mem = widget({ type = "textbox" })
  --vicious.register(mem, vicious.widgets.mem, "$1%")

  -- Meter
  membar = awful.widget.progressbar()
  membar:set_width(50)
  membar:set_height(6)
  membar:set_vertical(false)
  membar:set_background_color("#434343")
  --membar:set_color(beautiful.fg_normal )
  membar:set_gradient_colors({ beautiful.fg_normal, beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })

  --This bar should be placed on the right side of the wibox unless
  --it's a dual-screen config in which case the default (leftright)
  --layout is used... change that if you need!
  if screencount ~= dualScreen then
    membar.layout = awful.widget.layout.horizontal.rightleft
  end

  --Register the widget
  vicious.register(membar, vicious.widgets.mem, "$1", updateMem)

  -- Align progressbars
  awful.widget.layout.margins[membar.widget] = { top = 6 }

  -- MEM Usage
  --mem_total = widget({ type = "textbox" })
  --vicious.register(mem_total, vicious.widgets.mem, "$3 MB", 9)
  --mem_used = widget({ type = "textbox" })
  --vicious.register(mem_total, vicious.widgets.mem, "$2 MB", 9,)

  -- Cache that shit
  vicious.cache(vicious.widgets.mem)
end
-- }}} MEM


-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, "%A %b %d at %I:%m%P")
awful.widget.layout.margins[mytextclock] = { top = -1 }

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(awful.button({}, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev))
mytasklist = {}
mytasklist.buttons = awful.util.table.join(awful.button({}, 1, function(c)
  if not c:isvisible() then
    awful.tag.viewonly(c:tags()[1])
  end
  client.focus = c
  c:raise()
end),
  awful.button({}, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width = 250 })
    end
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end))


for s = 1, screencount do
  -- Set a screen margin for borders
  awful.screen.padding(screen[s], { top = 0 })
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
  mylayoutbox[s].resize = false
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
  awful.widget.layout.margins[mytaglist[s]] = { top = -2 }


  -- WARNING: In order to properly view the tasklist some lua files have been modified. For the
  -- tasklist_floating_icon icon to be placed on the left side of the task name instead of the
  -- right alignment, /usr/share/awesome/lib/awful/widget/tasklist.lua in function new(label, buttons) the
  -- variable widgets.textbox has to be modified like this:
  -- remove bg_align = "right" and
  -- modify the left margin from 2 to icon width + 2 (i.e.: 18).

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(function(c)
    return awful.widget.tasklist.label.currenttags(c, s,
      -- WARNING: Requires modified /usr/share/awesome/lib/awful/widget/tasklist.lua !!!
      -- This basically hides the application icons on the tasklist. If you don't want this or
      -- prefer not to change your tasklist.lua remove the following line!
      { hide_icon = true })
  end, mytasklist.buttons)

  awful.widget.layout.margins[mytasklist[s]] = { top = 2 }




  -- WIBOXES --

  -- Here we create the wiboxes if it's not a dual-screen layout
  if screencount ~= dualScreen then
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 18 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
      {
        space,
        mytaglist[s],
        spacer,
        mypromptbox[s],
              displaySysInfo,
        layout = awful.widget.layout.horizontal.leftright
      },

      spacer,
      mytextclock,
      space,
      mylayoutbox[s],
      spacer,
      s == 1 and mysystray or nil,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft

    }

    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 18 })

    mybottomwibox[s].widgets = {
      {
        space, music_play, music_pause, music_stop, music_prev, music_next, space, mpdwidget,
        layout = awful.widget.layout.horizontal.leftright
      },

      spacer,
      bracketr,
      spacer, batwidget, spacer, baticon, spacer,
      separator,
      spacer, wifiwidget, spacer, wifiimage0, wifiimage1, wifiimage2, wifiimage3, wifiimage4, spacer,
      separator,
      spacer, tempwidget, spacer, tempicon, spacer,
      separator,
      spacer, freq[1], spacer, cpubar[1], spacer,
        --cpuLabel[1], spacer,
        cpuicon, spacer,
      separator,
      spacer, membar, spacer, memicon, spacer,
      separator,
      spacer, netupwidget, spacer, upicon, spacer, separator, spacer, netdnwidget, spacer, dnicon, spacer,
      separator,
      space, pghosticon, pnoghosticon, runpicon, picon, space,
      bracketl,
      layout = awful.widget.layout.horizontal.rightleft
    }
  end

end

if screencount == dualScreen then
  -- Here we create the wiboxes if it is a dual screen configuration:
  mywibox[1] = awful.wibox({ position = "top", screen = 1, border_width = 0, height = 18 })
  -- Add widgets to the wibox - order matters
  mywibox[1].widgets = {
    {
      space,
      mytaglist[1],
      spacer,
      mypromptbox[1],
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer,
    mytextclock,
    space,
    mylayoutbox[1],
    spacer,
    mytasklist[1],
    layout = awful.widget.layout.horizontal.rightleft
  }

  mybottomwibox[1] = awful.wibox({ position = "bottom", screen = 1, border_width = 0, height = 18 })

  mybottomwibox[1].widgets = {
    {
      space, music_play, music_pause, music_stop, music_prev, music_next, space, mpdwidget,
      layout = awful.widget.layout.horizontal.leftright
    },

    space,
    s == 1 and mysystray or nil,
    layout = awful.widget.layout.horizontal.rightleft
  }

  mywibox[2] = awful.wibox({ position = "top", screen = 2, border_width = 0, height = 18 })

  mywibox[2].widgets = {
    {
      space,
      mytaglist[2],
      spacer,
      mypromptbox[2],
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer,
    mytextclock,
    space,
    mylayoutbox[2],
    spacer,
    mytasklist[2],
    layout = awful.widget.layout.horizontal.rightleft
  }

  mybottomwibox[2] = awful.wibox({ position = "bottom", screen = 2, border_width = 0, height = 18 })

  mybottomwibox[2].widgets = {
    {
      spacer,
      bracketl,
      spacer, sys, spacer,
      separator,
      space, runpicon, picon, pghosticon, pnoghosticon, space,
      separator,
      spacer, dnicon, spacer, netdnwidget, spacer, separator, spacer, upicon, spacer, netupwidget, spacer,
      separator,
      spacer, memicon, spacer, membar, spacer,
      bracketr,
      layout = awful.widget.layout.horizontal.leftright
    },

    spacer,
    bracketr,
    spacer, tempwidget, spacer, tempicon, spacer,
    separator,
    spacer, freq[2], spacer, cpubar[2], spacer,
      cpuLabel[2], spacer,
      cpuicon, spacer,
    separator,
    spacer, freq[1], spacer, cpubar[1], spacer,
      cpuLabel[1], spacer,
      cpuicon, spacer,
    bracketl,
    layout = awful.widget.layout.horizontal.rightleft
  }

end

-- }}}





-- {{{ Mouse bindings
root.buttons(awful.util.table.join(awful.button({}, 3, function() awe_main_menu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(awful.key({ modkey, }, "Left", awful.tag.viewprev),
  awful.key({ modkey, }, "Right", awful.tag.viewnext),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore),

  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "w", function() awe_main_menu:show({ keygrabber = true }) end),

  --Volume manipulation
  awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 5+") end),
  awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 5-") end),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift" }, "q", awesome.quit),

  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1) end),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),
  awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),

  -- Prompt
  awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end),

  awful.key({ modkey }, "x",
    function()
      awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end))

clientkeys = awful.util.table.join(awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey, }, "o", awful.client.movetoscreen),
  awful.key({ modkey, "Shift" }, "r", function(c) c:redraw() end),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),
  awful.key({ modkey, }, "n", function(c) c.minimized = not c.minimized end),
  awful.key({ modkey, }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical = not c.maximized_vertical
    end))

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screencount do
  keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewonly(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.movetotag(tags[client.focus.screen][i])
        end
      end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.toggletag(tags[client.focus.screen][i])
        end
      end))
end

clientbuttons = awful.util.table.join(awful.button({}, 1, function(c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      size_hints_honor = false,
      focus = true,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
  {
    rule = { class = "MPlayer" },
    properties = { floating = true }
  },
  {
    rule = { class = "pinentry" },
    properties = { floating = true }
  },
  {
    rule = { class = "gimp" },
    properties = { floating = true }
  },
  -- Set Firefox to always map on tags number 2 of screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function(c, startup)
-- Add a titlebar
-- awful.titlebar.add(c, { modkey = modkey })

-- Enable sloppy focus
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

  if not startup then
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Put windows in a smart way, only if they does not set an initial position.
    if not c.size_hints.user_position and not c.size_hints.program_position then
      awful.placement.no_overlap(c)
      awful.placement.no_offscreen(c)
    end
  end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- {{{ Tag signal handler - selection
-- - ASCII tags 1 [2] 3 4...
--   - start with tag 1 named [1] in tag setup
--[[
for s = 1, screencount do
    for t = 1, #tags[s] do
        tags[s][t]:add_signal("property::selected", function ()
            if tags[s][t].selected then
                tags[s][t].name = "[" .. tags[s][t].name .. "]"
            else--]]
--tags[s][t].name = tags[s][t].name:gsub("[%[%]]", "")
--[[ end
        end)
    end
end
--]]
-- }}}



