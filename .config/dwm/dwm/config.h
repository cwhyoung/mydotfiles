/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx  = 7;        /* border pixel of windows */
static unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;       /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static int showbar            = 1;        /* 0 means no bar */
static int topbar             = 1;        /* 0 means bottom bar */
static const int user_bh            = 20;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */


static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const char *fonts[]          = { "Hack:size=12", "JoyPixels:pixelsize=13:antialias=true:autohint=true", "Inconsolata Nerd Font:size=12" };
static const char dmenufont[]       = "Hack:size=12";
static char tagnormbgcolor[]        = "#222222";
static char tagnormfgcolor[]        = "#fcfaff";
static char tagselfgcolor[]         = "#eeeeee";
static char tagselbgcolor[]         = "#005577";
static char normbordercolor[]       = "#444444";
static char statfgcolor[]           = "#ffff00";
static char statbgcolor[]           = "#292045";
static char deepbluecolor[]         = "#1F1D3A";
static char selbordercolor[]        = "#005577";
static char infofgcolor[]           = "#A6CAD9";
static char infobgcolor[]           = "#1F2635";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#ff0000";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";

static char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { tagnormfgcolor, tagnormbgcolor, normbordercolor },
       [SchemeSel]  = { tagselfgcolor,  tagselbgcolor,  selbordercolor  },

	[SchemeStatus]  = { statfgcolor, statbgcolor,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { tagselfgcolor, tagselbgcolor,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
        [SchemeTagsNorm]  = { tagnormfgcolor, tagnormbgcolor,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
        [SchemeInfoSel]  = { infofgcolor, infobgcolor,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
        [SchemeInfoNorm]  = { infofgcolor, deepbluecolor,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                    instance  title             tags mask  isfloating  isterminal  noswallow  monitor */
	{ "Gimp",                   NULL,     NULL,              0,         1,          0,           0,        -1 },
	{ "Firefox",                NULL,     NULL,              0,         0,          0,          -1,        -1 },
	{ "Qalculate-gtk",          NULL,     NULL,              0,         1,          1,           0,        -1 },
	{ "mpv",                    NULL,     NULL,              0,         1,          1,           0,        -1 },
    { "Pavucontrol",            NULL,     NULL,              0,         1,          0,           0,        -1 },
    { "kitty",                  NULL,     NULL,              0,         0,          1,           0,        -1 },
    { "Steam",                  NULL,  "Steam",              0,         1,          0,           0,        -1 },
	{ "SimpleScreenRecorder",   NULL,     NULL,              1 << 8,    1,          0,           0,        -1 },
    { "privateinternetaccess",  NULL,     NULL,              1 << 8,    1,          0,           0,        -1 },
	{ "St",                     NULL,     NULL,              0,         0,          1,           0,        -1 },
	{ NULL,                     NULL,     "Event Tester",    0,         0,          0,           1,        -1 }, /* xev */
};

#include <X11/XF86keysym.h>
#include "layouts.c"

/* layout(s) */
static float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static int nmaster     = 1;    /* number of clients in master area */
static int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "HHH",      grid },
	{ "|||",      col },   /* Columns layout */
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "|cM|",     centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "[D]",      deck },
	{ NULL,       NULL },

};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define STATUSBAR "dwmblocks"

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", tagnormbgcolor, "-nf", tagnormfgcolor, "-sb", selbordercolor, "-sf", tagselfgcolor, NULL };
static const char *termcmd[]  = { "kitty", NULL };
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };

/*
 * Xresources preferences to load at startup
 */
ResourcePref resources[] = {
		{ "tagnormbgcolor",     STRING,  &tagnormbgcolor },
        { "tagnormfgcolor",     STRING,  &tagnormfgcolor },
		{ "normbordercolor",    STRING,  &normbordercolor },
        { "tagselfgcolor",      STRING,  &tagselfgcolor   },
        { "tagselbgcolor",      STRING,  &tagselbgcolor   },
		{ "statfgcolor",        STRING,  &statfgcolor  },
		{ "statbgcolor",        STRING,  &statbgcolor },
		{ "deepbluecolor",	STRING,  &deepbluecolor },
		{ "selbordercolor",     STRING,  &selbordercolor },
		{ "infofgcolor",        STRING,  &infofgcolor },
		{ "infobgcolor",        STRING,  &infobgcolor },
		{ "borderpx",          	INTEGER, &borderpx },
		{ "snap",      		INTEGER, &snap },
		{ "showbar",          	INTEGER, &showbar },
		{ "topbar",          	INTEGER, &topbar },
		{ "nmaster",          	INTEGER, &nmaster },
		{ "resizehints",       	INTEGER, &resizehints },
		{ "mfact",      	 	FLOAT,   &mfact },
};


static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_grave,  togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_c,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[6]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[7]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[8]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[9]} },
	{ MODKEY|ControlMask,		    XK_comma,  cyclelayout,    {.i = -1 } },
	{ MODKEY|ControlMask,           XK_period, cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ControlMask|ShiftMask, XK_q,      quit,           {1} },

 	/* Spawn programmes section with Super + Alt + key */
	{ MODKEY|Mod1Mask,              XK_d,      spawn,          SHCMD("rofi -show drun -show-icons") },
    { Mod1Mask,                     XK_Tab,    spawn,          SHCMD("rofi -show") },
	{ MODKEY|Mod1Mask,              XK_c,      spawn,          SHCMD("google-chrome-stable") },
	{ MODKEY|Mod1Mask,              XK_x,      spawn,          SHCMD("~/.config/xmenu/xmenu.sh") },
	{ MODKEY|Mod1Mask,              XK_m,      spawn,          SHCMD("mailspring") },
	{ MODKEY|Mod1Mask,              XK_b,      spawn,          SHCMD("brave") },
	{ MODKEY|Mod1Mask,              XK_f,      spawn,          SHCMD("caja") },

	{ 0, XF86XK_AudioMute,		    spawn,		SHCMD("pamixer -t; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioRaiseVolume,	spawn,		SHCMD("pamixer --allow-boost -i 3; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioLowerVolume,	spawn,		SHCMD("pamixer --allow-boost -d 3; kill -44 $(pidof dwmblocks)") },
	{ 0, XF86XK_AudioPrev,		    spawn,		SHCMD("mpc prev") },
	{ 0, XF86XK_AudioNext,		    spawn,		SHCMD("mpc next") },
	{ 0, XF86XK_AudioPlay,		    spawn,		SHCMD("playerctl play-pause") },
	{ 0, XF86XK_Calculator,		    spawn,		SHCMD("qalculate-gtk") },

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[9]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        0,              Button4,        sigstatusbar,   {.i = 4} },
    { ClkStatusText,        0,              Button5,        sigstatusbar,   {.i = 5} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

