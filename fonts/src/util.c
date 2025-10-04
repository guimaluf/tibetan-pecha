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
	
#include <stdio.h>
#include <ctype.h>
#include "token.h"
#include "table.h"

extern struct tab base_table[];
extern struct fix superfixes[], subfixes[];

/*
 * Look up m_str in the table.  If m_char isn't -1, see if the m_str can
 * modify m_char. 
 */
match(table, m_str, m_char)
	int             table;
	char           *m_str;
	int             m_char;
{
	struct tab     *base = base_table;
	struct fix     *super = superfixes, *sub = subfixes;
	int             i = 0, miss;
	int             len, j;

	switch (table) {
	case BASE:
		while (base[i].char_num != -1) {
			miss = 0;
			len = strlen(m_str);
			for (j = 0; j < len; j++) {
				if (base[i].glyph[j] != '+') {
					if (m_str[j] != base[i].glyph[j]) {
						miss = 1;
						break;
					}
				} else if (vowel(m_str[j]) == V_NONE) {
					miss = 1;
					break;
				}
			}
			if (!miss)
				return (base[i].char_num);
			i++;
		}
		return (ERROR);
		break;
	case SUPER:
		while (super[i].char_num != -1) {
			if (super[i].fix_char == m_str[0])
				if (super[i].base_char == m_char)
					return (super[i].char_num);
			i++;
		}
		return (ERROR);
	case SUB:
		while (sub[i].char_num != -1) {
			if (sub[i].fix_char == m_str[0])
				if (sub[i].base_char == m_char)
					return (sub[i].char_num);
			i++;
		}
		return (ERROR);
	}
}




super(c)
	char            c;
{
	switch (c) {
	case 'r':
	case 'l':
	case 's':
		return (1);
	default:
		return (0);
	}
}

sub(c)
	char            c;
{
	switch (c) {
	case 'w':
	case 'y':
	case 'r':
	case 'l':
		return (1);
	default:
		return (0);
	}
}

vowel(c)
	char            c;
{
	switch (c) {
	case 'a':
		return (V_A);
	case 'e':
		return (V_E);
	case 'i':
		return (V_I);
	case 'o':
		return (V_O);
	case 'u':
		return (V_U);
	default:
		return (V_NONE);
	}
}

error(s, pos)
	char           *s;
	int             pos;
{
	printf("%s at %d\n", s, pos);
}
