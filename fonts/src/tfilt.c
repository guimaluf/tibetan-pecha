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
#include "table.h"
#include "token.h"

main(argc, argv)
	int             argc;
	char          **argv;
{
	char            c;

	if (argc != 2) {
		fprintf(stderr, "usage: %s input_file\n", argv[0]);
		exit(11);
	}
	if ((input = fopen(argv[1], "r")) == NULL) {
		perror(argv[1]);
		exit(12);
	}
	/*
	 * Now the hard part begins. 
	 */

	printf("\\font\\tibetan=tib\\font\\tibsp=tibsp ");
	while ((c = getc(input)) != EOF) {
		if (c == '%') {
			if ((c = getc(input)) == '%')
				tparse();
			else if (c == EOF)
				exit(0);
			else
				putchar('%');
		} else
			putchar(c);
	}
	exit(0);
}
