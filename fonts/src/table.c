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
	
#include "table.h"

/*
 * This table is used to convert ascii representations of
 * Tibetan words into the TeX font change commands to get the
 * proper glyphs.
 */

/*
 * The base characters are found in the first 32 positions.  
 * The plus indicates a vowel.  The second column is the name of the
 * character.
 * Note: this table has been rearranged
 * so that shorter strings are found first. The second field is 
 * for alphabetical order.
 */

struct	tab base_table[] = {
	{ "k+", 	"ka",		0 },
	{ "kh+",	"kha",		1 },
	{ "g+",		"ga",		2 },
	{ "n+",  	"na",		11 },
	{ "ng+",	"nga",		3 },
	{ "c+", 	"ca",		4 },
	{ "ch+",	"cha",		5 },
	{ "j+",		"ja",		6 },
	{ "ny+",	"nya",		7 },
	{ "t+",		"ta",		8 },
	{ "th+",	"tha",		9 },
	{ "d+",		"da",		10 },
	{ "p+",		"pa",		12 },
	{ "ph+",	"pha",		13 },
	{ "b+",		"ba",		14 },
	{ "m+",		"ma",		15 },
	{ "ts+",	"tsa",		16 },
	{ "tsh+",	"tsha",		17 },
	{ "dz+",	"dza",		18 },
	{ "w+",		"wa",		19 },
	{ "z+",		"za",		21 },
	{ "zh+",	"zha",		20 },
	{ "'+",		"achung",	22 },
	{ "y+",		"ya",		23 },
	{ "r+",		"ra",		24 },
	{ "l+",		"la",		25 },
	{ "s+",		"sa",		27 },
	{ "sh+",	"sha",		26 },
	{ "h+",		"ha",		28 },
	{ "+",		"a",		29 },
	{ "",		"",		-1 },
};

/*
 * A fix table contains the fix char, the base character that it modifies
 * and the character number of the actual glyph in the font.  There are 
 * different tables for super and sub fixes.  The only difference in
 * the way that they are treated is where the fix char is looked for.
 */

struct	fix	superfixes[] = {
	{ 'r',	 "rka",	0,	30 },
	{ 'r',   "rga",	2,	31 },
	{ 'r',	 "rnga",	3,	32 },
	{ 'r',	 "rja",	6,	33 },
	{ 'r',	 "rnya", 	7,	34 },
	{ 'r',   "rta",	8,	35 },
	{ 'r', 	 "rda",	10,	36 },
	{ 'r',	 "rna",	11,	37 },
	{ 'r',	 "rba",	14,	38 },
	{ 'r',	 "rma",	15,	39 },
	{ 'r',	 "rtsa",	16,	40 },
	{ 'r',	 "rdza",	18,	41 },
	{ 'l',	 "lka",	0,	42 },
	{ 'l',	 "lga",	2,	43 },
	{ 'l',	 "lnga",	3,	44 },
	{ 'l',	 "lca",	4,	45 },
	{ 'l',	 "lja",	6,	46 },
	{ 'l',	 "lta",	8,	47 },
	{ 'l', 	 "lda",	10,	48 },
	{ 'l',	 "lpa",	12,	49 },
	{ 'l',   "lba",	14,	50 },
	{ 'l',	 "lha",	28,	51 },
	{ 's',	 "ska",	0,	52 },
	{ 's',	 "sga",	2,	53 },
	{ 's',	 "snga",	3,	54 },
	{ 's',	 "snya",	7,	55 },
	{ 's',	 "sta",	8,	56 },
	{ 's',	 "sda",	10,	57 },
	{ 's',	 "sna", 	11,	58 },
	{ 's',   "spa",	12,	59 },
	{ 's',	 "sba",	14,	60 },
	{ 's',   "sma",	15,	61 },
	{ 's',	 "stsa",	16,	62 },
	{ 'r',	 "rkya",	80,	107},
	{ 'r',   "rgya",	82,	108},
	{ 's',	 "skya",	80,	109},
	{ 's',	 "skra",	87,	110},
	{ 's',	 "sgya",	82,	111},
	{ 's',	 "sgra",	89,	112},
	{ 's',	 "spya",	83,	113},
	{ 's',	 "spra",	94,	114},
	{ 's',	 "sbya",	85,	115},
	{ 's',	 "sbra",	96,	116},
	{ 'r',	 "rmya",	86,	117},
	{ 's',	 "smya",	86,	118},
	{ 's',	 "smra",	97,	119},
	{  0,	 "",		-1,	-1 },
};

struct	fix	subfixes[] = {
	{ 'y',	 "kya",	0,	80 },
	{ 'y',	 "khya",	1,	81 },
	{ 'y',	 "gya",	2,	82 },
	{ 'y',	 "pya",	12,	83 },
	{ 'y',	 "phya",	13,	84 },
	{ 'y', 	 "bya",	14,	85 },
	{ 'y',	 "mya",	15,	86 },
	{ 'r',	 "kra",	0,	87 },
	{ 'r',	 "khra",	1,	88 },
	{ 'r',	 "gra",	2,	89 },
	{ 'r',	 "tra",	8,	90 },
	{ 'r', 	 "thra",	9,	91 },
	{ 'r',	 "dra",	10,	92 },
	{ 'r',   "nra",	11,	93 },
	{ 'r',	 "pra",	12,	94 },
	{ 'r',	 "phra",	13,	95 },
	{ 'r',   "bra",	14,	96 },
	{ 'r',	 "mra",	15,	97 },
	{ 'r',	 "shra",	26,	98 },
	{ 'r',	 "sra",	27,	99 },
	{ 'r',	 "hra",	28,    100 },
	{ 'l',	 "kla",	0,     101 },
	{ 'l',	 "gla",	2,     102 },
	{ 'l',	 "bla",	14,    103 },
	{ 'l',	 "zla",	21,    104 },
	{ 'l',	 "rla",	24,    105 },
	{ 'l',	 "sla",	27,    106 },
	{  0,	"",	-1,	-1 },
};

/*
 * The following are a table of special characters.
 * The second argument is a TeX command.  Remember that the default font
 * is \tibetan, and you must switch back after if you`ve switched over to
 * the special font (\tibsp).
 */
struct special special[] = {
/*
 * the first part of this table is to produce all the wazur combinations;
 * the wazur characters are stored in the main font (\tibetan) and not in
 * the special font (\tibsp).
 */
	{ "kwa",	"\\char63",	63 },
	{ "khwa",	"\\char64",	64 },
	{ "gwa",	"\\char65",	65 },
	{ "grwa",	"\\char66",	66 },
	{ "rgwa",	"\\char67",	67 },
	{ "nywa",	"\\char68",	68 },
	{ "dwa",	"\\char69",	69 },
	{ "tshwa",	"\\char70",	70 },
	{ "rtswa",	"\\char71",	71 },
	{ "zhwa",	"\\char72",	72 },
	{ "zwa",	"\\char73",	73 },
	{ "rwa",	"\\char74",	74 },
	{ "lwa",	"\\char75", 	75 },
	{ "shwa",	"\\char76",	76 },
	{ "hwa",	"\\char77",	77 },
	{ "phywa",	"\\char78",	78 },
	{ "cwa",	"\\char79",	79 },
	{ "twa",	"\\char120",	120 },
	{ "tswa",	"\\char121",	121 },
	{ "swa",	"\\char122",	122 },
/* 
 * next come the five aspirates with the "ha" subjoined.
 * "lha" is processed separately above, since it is really
 * a "ha" with a "la" superfix.
 *
 * the retroflex "dxha" uses an "x" following the "d" to
 *indicate that it is reversed.
 */
	{ "dha",		"\\tibsp\\char20\\tibetan", 148 },
	{ "gha",		"\\tibsp\\char21\\tibetan", 149 },
	{ "dxha",		"\\tibsp\\char22\\tibetan", 150 },
	{ "bha",		"\\tibsp\\char23\\tibetan", 151 },
	{ "dzha",		"\\tibsp\\char24\\tibetan", 152 },

/*
 * next comes the six retroflex consonants.  they are indicated
 * by using an "x" following the consonant modified to show that
 * they are reversed.
 */
	{ "thxa",		"\\tibsp\\char25\\tibetan", 153 },
	{ "txa",		"\\tibsp\\char26\\tibetan", 154 },
	{ "dxa",		"\\tibsp\\char27\\tibetan", 155 },
	{ "nxa",		"\\tibsp\\char28\\tibetan", 156 },
	{ "kshxa",		"\\tibsp\\char29\\tibetan", 157 },
	{ "shxa",		"\\tibsp\\char30\\tibetan", 158 },
/*
 * next come the numbers. 
 *
 */
	{ "0",		"\\tibsp\\char0\\tibetan",	128 },
	{ "1",		"\\tibsp\\char1\\tibetan",	129 },
	{ "2",		"\\tibsp\\char2\\tibetan",	130 },
	{ "3",		"\\tibsp\\char3\\tibetan",	131 },
	{ "4",		"\\tibsp\\char4\\tibetan",	132 },
	{ "5",		"\\tibsp\\char5\\tibetan",	133 },
	{ "6",		"\\tibsp\\char6\\tibetan",	134 },
	{ "7",		"\\tibsp\\char7\\tibetan",	135 },
	{ "8",		"\\tibsp\\char8\\tibetan",	136 },
	{ "9",		"\\tibsp\\char9\\tibetan",	137 },
/*
 * here are a couple of odd characters with the "u" vowel
 *
 */
	{ "tsu",	"\\tibsp\\char14\\tibetan",	16 },
	{ "cu",		"\\tibsp\\char13\\tibetan",	4 },
/*
 * here are the "tsa," "tsha," and "dza" characters
 * generated by using the modified vowels with the stroke
 * above the references included
 */
	{ "tse",	"\\tibsp\\accent120\\tibetan\\char4", 16 },
	{ "tsi",	"\\tibsp\\accent119\\tibetan\\char4", 16 },
	{ "tso",	"\\tibsp\\accent118\\tibetan\\char4", 16 },

	{ "tshe",	"\\tibsp\\accent120\\tibetan\\char5", 17 },
	{ "tshi",	"\\tibsp\\accent119\\tibetan\\char5", 17 },
	{ "tsho",	"\\tibsp\\accent118\\tibetan\\char5", 17 },

	{ "dze",	"\\tibsp\\accent120\\tibetan\\char6", 18 },
	{ "dzi",	"\\tibsp\\accent119\\tibetan\\char6", 18 },
	{ "dzo",	"\\tibsp\\accent118\\tibetan\\char6", 18 },
/*
 * here are some punctuation characters.  the "tsheg" and the
 * "shad" are automatically generated as word and sentence
 * boundaries.   they may also be acessed as special characters.
 * The "tsheg" may be got at with a
 * "," character in the text.  The "swasti" is the word with the
 * TeX escape, but  should be finished with a "/".
 * Thus: "\swasti/"
 */

	{ ",",	"\\tibsp\\char114\\tibetan",	 	114 },
	{ "\\swasti",	"\\tibsp\\char116\\tibetan",	116 },
	{ 0,		""	},
};
