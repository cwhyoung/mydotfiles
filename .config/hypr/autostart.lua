-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
 hl.on("hyprland.start", function ()
   hl.exec_cmd("quickshell -p ~/mydotfiles/.config/quickshell/NewBar.qml & hyprpaper &")
   hl.exec_cmd("$HOME/.config/hypr/hypr-wallpaper.sh")
   hl.exec_cmd("hypridle")
   hl.exec_cmd("/usr/lib/pam_kwallet_init")
   hl.exec_cmd("qdbus6 org.kde.kwalletd6 /modules/kwalletd6 org.kde.KWallet.open kdewallet 0 login")
 end)
