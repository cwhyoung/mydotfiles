//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "sb-volume",				0,		10},

	{"", "sb-pacpackages",				1800,		1},

	{"", "sb-forecast",				1800,		2},

	{"", "sb-moonphase",				7000,		3},

	{"", "sb-internet",				10,		4},

	{"", "sb-nettraf",				1,		5},

	{"", "sb-disk",				50,		6},

	{"", "sb-cpu",					1,		7},

	{"", "sb-cpubars",				1,		8},

	{"", "sb-memory",				2,		9},

	{"", "sb-clock",				2,		11},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;

