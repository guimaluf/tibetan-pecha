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

#define	SENTENCE	12
#define WORD		13
#define PARAGRAPH	14
#define	SENTENCE2	15
#define	SENTENCE3	16

#define	Getc(x)		x = nextchar(); if (x == 0) return WORD; else if (x == -1) goto top;
#define Ungetc(c)	current_char--

static int      current_char, current;
static char     current_word[100];
static int	blank_flag = 0, blank_next = 0;
static int	slashes, slashes_next;
char            word_out, nextchar(), pending_punct;
int             word_count, pos = 0;

struct token    token[10];
extern struct tab base_table[];
extern struct fix superfixes[], subfixes[];
extern struct special special[];

tparse()
{
	char            c;
	int             tok, i, j;

	for (i = 0; i < 10; i++) {
		for (j = 0; j < 10; j++)
			token[i].str[j] = 0;
		token[i].char_num = 0;
		token[i].vowel = V_NONE;
		token[i].special = 0;
	}
	printf("\\bgroup\\tibetan ");
	printf("\\def\\u#1{\\vtop{\\baselineskip0pt\\hbox{#1}\\hbox{\\tibsp\\char123}}}");
	printf("\\hyphenpenalty=10000\\parindent=0pt ");
	printf("\\newbox\\fillerbox\\setbox\\fillerbox\\hbox{\\vrule height0.4cm depth0.4cm width0pt}\\def\\filler{\\copy\\fillerbox}");
	while (1) {
		/*
		 * If we get a %, check for another immediately following.
		 * This is the end of tibetan mode.  Otherwise, it is just a
		 * comment, but I figure it should be left in, just in case
		 * some one needs to look at the filter output. 
		 */

		for (i=0; i<100; i++)
			current_word[i] = 0;
		c = getc(input);
		while (isspace(c)) {
			char            c1;
			if (c == '\n') {
				c1 = getc(input);
				if (c1 == '\n') {
					output_special(PARAGRAPH);
					break;
				} else
					ungetc(c1, input);
			} c = getc(input);
		}
		while (isspace(c) || c == '#') {
			if (c == '#') 
				blank_next = 1;
			c = getc(input);
		}
		ungetc(c, input);
		if (fscanf(input, "%s", current_word) == EOF) {
			printf("Missing %%%%\n");
			exit(1);
		}
		current_char = 0;
		if (current_word[0] == '%') {
			if (current_word[1] == '%') {
				output_pending_punct();
				printf("\\egroup ");
				return;
			} else {
				printf("%% %s", current_word + 1);
				while ((c = getc(input)) != '\n')
					putchar(c);
				putchar('\n');
			}
		} current = -1;
		tok = 0;
		tok = tword();
		output(current);
		if (tok != 0)
			output_special(tok);
	}
}
/*
 * Parse the word, as designated by white space. The tokens are put into an
 * array so that some tokens can affect previous ones.  The argument is the
 * number of the current token in array. 
 */
tword()
{
	char            c, c1, s[10];
	int             ind = 0;
	int             i, mtch;

top:
	ind = 0;
	c = Getc(c);
	while (1) {
		/*
		 * Check for end of word delimiters.  If it's also end of
		 * sentence, then do the appropriate thing. 
		 */
		switch (c) {
			
		case '#':
			/* don't output the word separator */
			blank_next = 1;
			return(WORD);
		case '/':
			slashes_next = 0;
			c1 = nextchar();
			while (c1 == '/') {
				slashes_next++;
				c1 = nextchar();
			}
			/*
			 * If the slashes are at the end of a word,
			 * keep the count in slashes_next, and
			 * return an end of sentence.
			 */
			if (isspace(c1) || c1 == 0 || c1 == -1) {
				return (SENTENCE);
			}
			/* 
			 * Otherwise, the slashes are at the beginning
			 * so output them now.
			 */
			output_pending_punct();
			for (i=0; i<=slashes_next; i++) 
				printf("\\tibsp\\char115\\tibetan");
			c = c1;
			slashes_next = 0;
			continue;
		case '!':
			output(current);
			return (SENTENCE2);
		case '|':
			output(current);
			return (SENTENCE3);
		case '%':
			Ungetc(c);
			return (0);
		case '\n':
			return (WORD);
		default:
			break;
		}

		if (isspace(c)) {
			return (WORD);
		} current++;
		/*
		 * If we've found a superfix, parse the next token. If it is
		 * a token that the superfix can modify, then use the
		 * modified char_num, otherwise the superfix is merely a
		 * vowel-less base character 
		 */
		if (super(c)) {
			int	cur;

			if ((c1 = current_word[current_char++]) == 0) {
				Ungetc(c1);
				goto not_super;
			}
			if (sub(c1) || (c == 's' && c1 == 'h') ||
			    (vowel(c1) != V_NONE)) {
				Ungetc(c1);
				goto not_super;
			}
			if (!isalpha(c1)) {
				Ungetc(c1);
				goto not_super;
			}
			Ungetc(c1);
			sprintf(s, "%c", c);
			cur = current;
			/* fix so that next_char doesn't overwrite with special */
			token[current].char_num = 0;
			tword();
			/*
			 * For some reason, // at the end get bypassed
			 */
			while(!isalpha(current_word[current_char]))
				current_char--;
			current_char++;
			if ((token[cur].char_num =
			     match(SUPER, s, token[cur+1].char_num))
			    != -1) {
				int	j;

				sprintf(token[cur].str, "%c%s", c, token[cur + 1].str);
				token[cur+1].str[0] = 0;
				token[cur].vowel = token[cur+1].vowel;
				token[cur+1].char_num = -1;
				token[cur+1].special = 0;
				token[cur+1].vowel = V_NONE;
				return (tword());
			} else {
				token[cur].char_num = match(BASE, s, -1);
				strcat(token[cur].str, s);
				token[cur].vowel = V_NONE;
				return (tword());
			}
		}
not_super:
		mtch = 0;
		while (1) {
			/*
			 * Match the g.y case. 
			 */
			if (c == '.') {
				token[current].str[ind] = 0;
				token[current].vowel = V_A;
				return (tword());
			}
			/*
			 * Check for a subfix.. 
			 */
			if (sub(c)) {
				int             t, t1;
				sprintf(s, "%c", c);
				t = match(SUB, s, token[current].char_num);
				if (t != ERROR) {
					c1 = Getc(c1);
					if ((t1 = vowel(c1)) == V_NONE) {
						Ungetc(c1);
						Ungetc(c);
						token[current].vowel = V_NONE;
						return(tword());
					} else {
						token[current].vowel = t1;
						token[current].char_num = t;
						strcat(token[current].str, s);
						return (tword());
					}
				}
			
			}
			token[current].vowel = vowel(c);
			/*
			 * We've matched the a+ glyph. 
			 */
			if (mtch == 0 && token[current].vowel != V_NONE) {
				if (ind == 0) {
					/*
					 * We've matched a single vowel
					 * glyph. 
					 */
					return (tword());
				}
				token[current].str[ind++] = c;
				token[current].str[ind] = 0;
				break;
				/*
				 * We've hit a vowel, which is the end of the
				 * glyph. 
				 */
			} else if (token[current].vowel != V_NONE) {
				token[current].str[ind] = 0;
				return (tword());
				/*
				 * Check to see if what we have so far + the
				 * next is a glyph.  If not, then this
				 * character is the beginning of the next
				 * one. 
				 */
			} else {
				int             n;
				token[current].str[ind++] = c;
				token[current].str[ind] = 0;
				if ((n = match(BASE, token[current].str, -1)) != ERROR) {
					token[current].char_num = n;
					mtch++;
				} else if (mtch != 0) {
					token[current].str[--ind] = 0;
					Ungetc(c);
					return (tword());
				} else {
					bad_word();
					return (0);
				}
			}
			c = Getc(c);
		}
	}
}

output(count)
	int             count;
{
	int             i, shift, cn, ch;
	char            fs[20];

	/*
	 * Indicate that output has occurred. 
	 */
	output_pending_punct();
	blank_flag = blank_next;
	blank_next = 0;
	slashes = slashes_next;
	slashes_next = 0;
	word_out = 1;
	for (i = 0; i <= count; i++) {
		/*
		 * Check for a single vowel glyph.  The output is different
		 * for a single vowel since it has nothing to modify. 
		 */
		shift = 0;
		if (token[i].special == SPECIAL) {
			printf("%s%%\n", token[i].str);
			continue;
		}
		if (token[i].char_num > 127) {
			cn = token[i].char_num - 128;
			strcpy(fs, "\\tibsp");
		} else {
			cn = token[i].char_num;
			strcpy(fs, "\\tibetan");
		}
		if (token[i].str[0] == 0)
			if (token[i].vowel != V_NONE)
				shift = 1;
			else
				continue;
		/* save the character so that we can find the last one */
		ch = token[i].char_num;
		switch (token[i].vowel) {
		case V_A:
		case V_NONE:
			if (shift)
				printf("\\char29");
			else
				printf("\\char%d", cn);
			break;
		case V_E:
			if (shift)
				printf("\\tibsp\\accent127\\tibetan\\char29");
			else
				printf("\\tibsp\\accent127%s\\char%d", fs, cn);
			break;
		case V_I:
			if (shift)
				printf("\\tibsp\\accent126\\tibetan\\char29");
			else
				printf("\\tibsp\\accent126%s\\char%d", fs, cn);
			break;
		case V_O:
			if (shift)
				printf("\\tibsp\\accent125\\tibetan\\char29");
			else
				printf("\\tibsp\\accent125%s\\char%d", fs, cn);
			break;
		case V_U:
			if (shift)
				printf("\\u{\\char29}");
			else
				printf("\\u{\\char%d}", cn);
			break;
		default:
			break;
		}
	}
	for (i = 0; i < 10; i++) {
		int             j;
		for (j = 0; j < 10; j++)
			token[i].str[j] = 0;
		token[i].char_num = -1;
		token[i].vowel = V_NONE;
		token[i].special = 0;
	}
}

output_special(c)
	char            c;
{
	/*
	 * Don't output any special markers unless output has done something
	 * since the last time we've been called. 
	 */
	if (word_out) {
		switch (c) {
		case SENTENCE:
			if (pending_punct == 0 || pending_punct == WORD)
				pending_punct = SENTENCE;
			break;
		case SENTENCE2:
			if (pending_punct == 0 || pending_punct == WORD)
				pending_punct = SENTENCE2;
			break;
		case SENTENCE3:
			if (pending_punct == 0 || pending_punct == WORD)
				pending_punct = SENTENCE3;
			break;
		case WORD:
			if (pending_punct == 0)
				pending_punct = WORD;
			break;

		case PARAGRAPH:
			output_pending_punct();
			printf("\n\n");
			break;
		default:
			break;
		}
	}
}

output_pending_punct()
{
	int	i;

	switch (pending_punct) {
	/* this controls the amount of space at the end of sentences */
	case SENTENCE:
		for (i=0; i<slashes; i++)
			printf("\\tibsp\\char115\\tibetan");
		printf("\\filler\\tibsp\\char115\\hskip1cm plus1cm minus.5cm\\tibetan\n"); 
		break;
	case SENTENCE2:
		printf("\\filler\\tibsp\\char121\\hskip1cm plus1cm minus.5cm\\tibetan\n"); 
		break;
	case SENTENCE3:
		printf("\\filler\\hskip1cm plus1cm minus.5cm\\tibetan\n"); 
		break;
	case WORD:
		if (blank_flag) {
			printf("\\filler\\tenrm\\ \\tibetan\n");
			blank_flag = 0;
		} else
			printf("\\filler\\tibsp\\char114\\tenrm\\ \\tibetan\n");
		break;
	default:
		break;
	}
	pending_punct = 0;
}

char
nextchar()
{
	int             i;

	i = 0;
	while (special[i].word != NULL) {
		if (strncmp(special[i].word, current_word + current_char, strlen(special[i].word)) == 0) {
			current_char += strlen(special[i].word);
			if (current == -1) {
				current = 0;
				token[current].char_num = special[i].char_num;
				token[current].special = SPECIAL;
				strcpy(token[current].str, special[i].cmd);
				token[current].vowel = vowel(special[i].word[
					strlen(special[i].word)+1]);
				current++;
				return (-1);
			}
			if (token[current].char_num == -1) {
				token[current].char_num = special[i].char_num;
				token[current].special = SPECIAL;
				strcpy(token[current].str, special[i].cmd);
				token[current].vowel = vowel(special[i].word[
					strlen(special[i].word+1)]);
				current++;
				return (-1);
			} else {
				current++;
				token[current].char_num = special[i].char_num;
				token[current].special = SPECIAL;
				strcpy(token[current].str, special[i].cmd);
				token[current].vowel = vowel(special[i].word[
					strlen(special[i].word+1)]);
				current++;
				return (-1);
			}
		}
		i++;
	}
	return (current_word[current_char++]);
}

bad_word()
{
	fprintf(stderr, "bad character in word <%s>\n", current_word);
}
