-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
 hl.on("hyprland.start", function ()
   hl.exec_cmd("nm-applet")
   hl.exec_cmd("quickshell & hyprpaper ")
   hl.exec_cmd("hypridle.conf")
   hl.exec_cmd("/usr/lib/pam_kwallet_init")
 end)
