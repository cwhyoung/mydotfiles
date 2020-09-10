#!/bin/sh

cat <<EOF | xmenu | sh &
Applications
	Accessories
		Text Editors
			IMG:/usr/share/icons/hicolor/256x256/apps/kate.png	Kate	kate
		IMG:/usr/share/icons/hicolor/256x256/apps/qalculate.png	Calculator	qalculate-gtk
	Internet
		Email Clients
			IMG:/usr/share/icons/hicolor/32x32/apps/evolution-mail.png	Evolution Email Client	evolution
		Web Browsers
			IMG:/usr/share/icons/hicolor/256x256/apps/firefox.png	FireFox		firefox
			IMG:/usr/share/icons/hicolor/256x256/apps/google-chrome.png	Google Chrome	google-chrome-stable
			IMG:/usr/share/pixmaps/brave.png	Brave Browser	brave %U
			IMG:/usr/share/icons/hicolor/256x256/apps/chromium.png	Chromium	chromium
			IMG:$HOME/.icons/web.png	Epiphany	epiphany
			IMG:/usr/share/icons/hicolor/256x256/apps/opera.png	Opera	opera
		Web TV & Streaming
			IMG:/usr/share/icons/hicolor/256x256/apps/lbry.png	LBRY	lbry
			IMG:/usr/share/icons/hicolor/128x128/apps/freetuxtv.png	FreeTuxTV	/usr/bin/freetuxtv
		Internet Radio
			IMG:/usr/share/icons/hicolor/scalable/apps/de.haeckerfelix.Shortwave.png	Shortwave	shortwave
		Virtual Private Networks
			IMG:/usr/share/pixmaps/pia.png	Private Internet Access	/opt/piavpn/bin/pia-client
		Torrenting and FTP
			IMG:/usr/share/icons/hicolor/16x16/apps/ktorrent.png	KTorrent	ktorrent
			IMG:/usr/share/icons/hicolor/16x16/apps/qbittorrent.png	qBittorrent	qbittorrent
		Internet Messaging - Video Calls
			IMG:/var/lib/flatpak/exports/share/icons/hicolor/256x256/apps/com.skype.Client.png	Skype	/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/skype --file-forwarding com.skype.Client @@u  @@
			IMG:/usr/share/icons/hicolor/16x16/apps/pidgin.png	Pidgin Internet Messenger	pidgin
		Remote Desktops
			IMG:/usr/share/icons/hicolor/32x32/apps/NoMachine-icon.png	NoMachine	nomachine
	File Managers
		IMG:/usr/share/icons/Adwaita/256x256/legacy/system-file-manager.png	Caja	caja
		Dolphin	dolphin
		Nemo	nemo
		PC Man FM	pcmanfm
	Office Software
		LibreOffice
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-startcenter.png	LibreOffice	libreoffice
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-base.png	LibreOffice Base (Database)	libreoffice --base
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-calc.png	LibreOffice Calc (Spreadsheets)	libreoffice --calc
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-draw.png	LibreOffice Writer (Word Processor)	libreoffice --writer
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-draw.png	LibreOffice Draw	libreoffice --draw
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-impress.png	LibreOffice Impress	libreoffice --impress
			IMG:/usr/share/icons/hicolor/16x16/apps/libreoffice-math.png	LibreOffice Math	libreoffice -math
		WPS Office
			IMG:/usr/share/icons/hicolor/256x256/apps/wps-office2019-kprometheus.png	WPS Office 2019	/usr/bin/wps
			IMG:/usr/share/icons/hicolor/256x256/apps/wps-office2019-pdfmain.png	WPS PDF	/usr/bin/wpspdf
			IMG:/usr/share/icons/hicolor/256x256/apps/wps-office2019-wppmain.png	WPS Presentation	/usr/bin/wpp
			IMG:/usr/share/icons/hicolor/256x256/apps/wps-office2019-etmain.png	WPS Spreadsheets	/usr/bin/et
			IMG:/usr/share/icons/hicolor/256x256/apps/wps-office2019-wpsmain.png	WPS Writer	/usr/bin/wps
		FreeOffice
			IMG:/home/w/.local/share/icons/McMojave-circle/apps/scalable/freeoffice-planmaker.png	PlanMaker (Spreadsheets)	/home/share/freeoffice2018/planmaker
			IMG:/home/w/.local/share/icons/McMojave-circle/apps/scalable/freeoffice-textmaker.png	TextMaker (Word Processor)	/home/share/freeoffice2018/textmaker
			IMG:/home/w/.local/share/icons/McMojave-circle/apps/scalable/freeoffice-presentations.png	Presentations	/home/share/freeoffice2018/presentations
		
		IMG:/usr/share/icons/hicolor/256x256/apps/abiword.png	AbiWord	abiword
	PDF & Scanners
		IMG:/usr/share/icons/hicolor/scalable/apps/org.gnome.SimpleScan.png	Document Scanner	/usr/bin/simple-scan
		IMG:/usr/share/pixmaps/gscan2pdf.png	G Scan2 PDF	gscan2pdf
	Games
		IMG:/usr/share/icons/hicolor/256x256/apps/steam.png	Steam	steam
		IMG:/usr/share/pixmaps/zsnes.png	Zsnes	zsnes
		IMG:/usr/share/pixmaps/0ad.png	O A.D	/usr/bin/0ad
		IMG:/usr/share/aisleriot/icons/hicolor/48x48/actions/cards-deal.png	AisleRiot Solitaire	/usr/bin/sol
		IMG:/usr/share/icons/hicolor/512x512/apps/wesnoth-icon.png	Battle for Wesnoth	/usr/bin/wesnoth
		IMG:/usr/share/icons/hicolor/128x128/apps/bomber.png	Bomber	/usr/bin/bomber
		IMG:/usr/share/pixmaps/dosbox.png	Dosbox	/usr/bin/dosbox
		IMG:/usr/share/icons/hicolor/256x256/apps/org.gnome.five-or-more.png	Five or More	/usr/bin/five-or-more
		IMG:/usr/share/icons/hicolor/256x256/apps/org.gnome.Four-in-a-row.png	Four-in-a-row	/usr/bin/four-in-a-row
	Virtual Machines
		IMG:/usr/share/icons/hicolor/256x256/apps/virt-manager.png	Virt Manager	virtmanager
		IMG:/usr/share/pixmaps/VBox.png	Virtual Box	virtualbox
	
	Multimedia
		IMG:/usr/share/icons/hicolor/16x16/apps/org.gnome.Lollypop.png	Lollypop	lollypop
		IMG:/usr/share/icons/hicolor/16x16/apps/mpv.png	mpv Media Player	mpv --player-operation-mode=pseudo-gui --
		IMG:/usr/share/icons/hicolor/16x16/apps/vlc.png	VLC Media Player	/usr/bin/vlc --started-from-file
	Audio Editors
		IMG:/usr/share/icons/hicolor/32x32/apps/audacity.png	Audacity	audacity
	Video Editors
		IMG:/usr/share/pixmaps/cinelerra-gg.xpm	Cinelerra-gg	cinelerra-gg
		IMG:/usr/share/icons/hicolor/scalable/apps/fr.handbrake.ghb.png	Handbrake	/usr/bin/ghb
		IMG:/usr/share/icons/hicolor/16x16/apps/kdenlive.png	Kdenlive	kdenlive
		IMG:/usr/share/icons/hicolor/256x256/apps/com.obsproject.Studio.png	OBS Studio	obs
		IMG:/usr/share/icons/hicolor/64x64/apps/org.shotcut.Shotcut.png	Shotcut	shotcut
		IMG:/usr/share/icons/hicolor/16x16/apps/simplescreenrecorder.png	Simple Screen Recorder	simplescreenrecorder
		IMG:/usr/share/icons/hicolor/256x256/apps/com.ozmartians.VidCutter.png	VidCutter	vidcutter
	Image Editors & Viewers
		IMG:/usr/share/icons/hicolor/scalable/apps/org.gnome.eog.png	Eye of Gnome	/usr/bin/eog
		IMG:/usr/share/icons/hicolor/256x256/apps/gimp.png	GIMP GNU Image Manipulation	gimp
		IMG:/usr/share/icons/hicolor/256x256/apps/krita.png	Krita	krita
Terminals
	IMG:/usr/share/pixmaps/Alacritty.png	Alacritty Terminal Emulator	WINIT_X11_SCALE_FACTOR=1 alacritty
	IMG:/usr/share/icons/hicolor/32x32/apps/terminator.png	Terminal - Terminator	terminator
	Terminal - urxvt	urxvt
	Terminal - st	st

System Tools
	IMG:/usr/share/icons/hicolor/128x128/apps/grsync.png	GrSync	grsync
	IMG:/usr/share/pixmaps/veracrypt.xpm	VeraCrypt	veracrypt
	IMG:/usr/share/icons/hicolor/128x128/apps/ark.png	ARK (Zip files, compression)	/usr/bin/ark
	IMG:/usr/share/icons/hicolor/256x256/apps/brasero.png	Brasero	/usr/bin/brasero
	IMG:/usr/share/icons/hicolor/scalable/apps/org.gnome.DiskUtility.png	Gnome Disks	gnome-disks

Settings
	IMG:/usr/share/icons/hicolor/32x32/apps/timeshift.png	Timeshift Backup and Restore	doas timeshift-gtk
	IMG:/usr/share/icons/hicolor/32x32/apps/grub-customizer.png	Grub Customizer	doas grub-customizer
	IMG:/usr/share/pixmaps/nvidia-settings.png	Nvidia Settings	nvidia-settings
	IMG:/usr/share/icons/hicolor/256x256/apps/blueman.png	Bluetooth Manager	blueman-manager
	IMG:/usr/share/icons/hicolor/64x64/apps/smb4k.png	Network Manager	nm-connection-editor
	IMG:/usr/share/pixmaps/bleachbit.png	BleachBit	bleachbit
	IMG:/usr/share/icons/hicolor/64x64/actions/kmix.png	PulseAudio Volume Control	/usr/bin/pavucontrol-qt

Log Out	$HOME/.config/xmenu/close-button.sh
Reload Window Manager	$HOME/.config/xmenu/reload.sh
Sleep	systemctl suspend
Restart	reboot
Shutdown	poweroff
EOF
