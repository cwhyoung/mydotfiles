//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "/home/w/.local/bin/statusbar/sb-volume",				0,		10},

	{"", "/home/w/.local/bin/statusbar/sb-pacpackages",				1800,		1},

	{"", "/home/w/.local/bin/statusbar/sb-forecast",				1800,		2},

	{"", "/home/w/.local/bin/statusbar/sb-moonphase",				7000,		3},

	{"", "/home/w/.local/bin/statusbar/sb-internet",				10,		4},

	{"", "/home/w/.local/bin/statusbar/sb-nettraf",				1,		5},

	{"", "/home/w/.local/bin/statusbar/sb-disk",				50,		6},

	{"", "/home/w/.local/bin/statusbar/sb-cpu",					1,		7},

	{"", "/home/w/.local/bin/statusbar/sb-cpubars",				1,		8},

	{"", "/home/w/.local/bin/statusbar/sb-memory",				2,		9},

	{"", "/home/w/.local/bin/statusbar/sb-clock",				2,		11},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
