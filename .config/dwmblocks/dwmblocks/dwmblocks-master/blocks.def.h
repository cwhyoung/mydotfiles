//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/

	{"", "/home/w/.local/bin/statusbar/sb-volume",				0,		10},


	{"", "/home/w/.local/bin/statusbar/sb-pacpackages",				1800,		1},


	{"", "/home/w/.local/bin/statusbar/sb-forecast",				1800,		2},


	{"", "/home/w/.local/bin/statusbar/sb-moonphase",				7000,		3},

	{"", "/home/w/.local/bin/statusbar/sb-internet",				10,		4},

	{"", "/home/w/.local/bin/statusbar/sb-nettraf",				1,		5},

	{"", "/home/w/.local/bin/statusbar/sb-disk",				1,		6},


	{"^c#FF0000^", "/home/w/.local/bin/statusbar/sb-cpu",				1,		7},

	
	{"", "/home/w/.local/bin/statusbar/sb-cpubars",				1,		8},

//	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		9},

	{"", "/home/w/.local/bin/statusbar/sb-memory",				5,		11},



//	{"", "date '+%b %d (%a) %I:%M%p'",					5,		12},

	{"", "/home/w/.local/bin/statusbar/sb-clock",				5,		13},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
