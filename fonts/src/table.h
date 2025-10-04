/*
 *	Copyright 1987 Jeff Sparkes
 *	Department of Computer Science
 *	Memorial University of Newfoundland
 *	St. John's, Nfld.
 *	garfield!jeff1,	jeff1@garfield.mun.cdn
 *
 *	Permission is granted to distribute and/or modify this code, provided
 *	this copyright notice remains intact.
 *	If you use it, let me know.  If change it let me know.  If you
 *	make money from it, send me a share.
 */
	
struct fix {
	char            fix_char;
	char           *doc;
	short           base_char;
	short           char_num;
};

struct tab {
	char           *glyph;
	char           *doc;
	short           char_num;
};

struct special {
	char           *word;
	char           *cmd;
	short		char_num;
};
