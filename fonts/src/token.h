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
	
/*
 * Input file.  I didn't know where else to put it. 
 */
FILE           *input;

/*
 * A token returned by the parser.  
 */
struct token {
	char            str[1024];
	char            vowel;
	char		special;
	int             char_num;
};

/*
 * Vowel flags 
 */
#define	V_NONE	000
#define V_A	001
#define V_E	002
#define V_I	004
#define V_O	010
#define V_U	020
#define	SPECIAL	127

/*
 * Flags to match different tables. 
 */

#define	BASE	0
#define	SUPER	1
#define	SUB	2
#define	ERROR	-1


int             tword();
