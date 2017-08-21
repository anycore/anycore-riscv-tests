/*
 *  lndir:  The C Program!
 *
 *  Copyright (c) 1993 by Salvatore Valente <svalente@athena.mit.edu>
 *
 *  You can freely distribute this program.  There is no warranty.
 *  See the file "COPYING" for more information.
 *
 */

/* -----------------------------------------------------------------

this creates the source tree in the current working directory.

% lndir /usr/src/usr.bin/fileutils
creates a directory called "fileutils" in the current working directory,
and links all children from the source tree using absolute pathnames.

% lndir ../../fileutils
creates a directory called "fileutils" in the current working directory,
and links all children from the source tree using relative pathames.

for example, if the file "../../fileutils/README" exists, then it will
be linked as in the new fileutils directory as "../../../fileutils/README".
the extra .. offsets the fact that it's in a child of the cwd.

----------------------------------------------------------------- */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <sys/types.h>
#include <stdio.h>
#include <sys/stat.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#else
extern int mkdir (char *filename, int mode);
extern int symlink (char *, char *);
#endif
#ifdef HAVE_STRING_H
#include <string.h>
#else
extern int strlen (char *str);
extern int strcmp (char *s1, char *s2);
extern char *strcpy (char *dest, char *src);
extern char *strcat (char *dest, char *src);
extern char *strrchr (char *str, char c);
#endif
#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#else
extern void *malloc (int bytes);
extern void free (void *ptr);
#endif
#if defined(DIRENT) || defined(_POSIX_VERSION)
#include <dirent.h>
#define NLENGTH(dirent) (strlen((dirent)->d_name))
#else
#define dirent direct
#define NLENGTH(dirent) ((dirent)->d_namlen)
#ifdef SYSNDIR
#include <sys/ndir.h>
#endif
#ifdef SYSDIR
#include <sys/dir.h>
#endif
#ifdef NDIR
#include <ndir.h>
#endif
#endif
#include "queue.h"

#if !defined(S_ISDIR) && defined(S_IFDIR)
#define S_ISDIR(mode) (((mode) & S_IFMT) == S_IFDIR)
#endif

static int pointer_in_queue (Queue, Pointer);
static char *xstrdup (char *);

int main (int argc, char *argv[])
{
    char *srcdir, *srcfile, *destdir, *destfile, *whoami, *cp, *err;
    int len, depth, x;
    Queue s_dirs, d_dirs, depth_list, used_inodes;
    DIR *dir;
    struct stat st;
    struct dirent *ent;
    Pointer inode;

    whoami = argv[0];
    srcdir = argv[1];
    cp = strrchr (whoami, '/');
    if (cp) whoami = cp + 1;

    if (argc != 2) {
	fprintf (stderr, "usage: %s srcdir\n", whoami);
	return (-1);
    }
    if (stat (srcdir, &st) < 0) {
	perror (srcdir);
	return (-1);
    }
    if (! S_ISDIR (st.st_mode)) {
	fprintf (stderr, "%s: not a directory\n", srcdir);
	return (-1);
    }
    /* remove slash from end of srcdir */
    srcdir = xstrdup (srcdir);
    len = strlen (srcdir);
    if (srcdir[len - 1] == '/') srcdir[len-1] = 0;
    /* get the initial destdir from the initial srcdir */
    cp = strrchr (srcdir, '/');
    if (cp) destdir = xstrdup (cp + 1);
    else destdir = xstrdup (srcdir);

    s_dirs = q_new ();
    d_dirs = q_new ();
    q_push (s_dirs, srcdir);
    q_push (d_dirs, destdir);

    used_inodes = q_new ();
    q_push (used_inodes, (Pointer) st.st_ino);

    depth_list = NULL;
    depth = 0;
    if (*srcdir != '/') {
	depth_list = q_new ();
	depth = 1;
	q_push (depth_list, (Pointer) depth);
    }

    while ((srcdir = q_pop (s_dirs)) != NULL) {
	printf ("%s:\n", srcdir);
	if (depth_list) depth = (int) q_pop (depth_list);
	/* create the destination directory */
	destdir = q_pop (d_dirs);
	if (mkdir (destdir, 00755) < 0) {
	    len = strlen (destdir) + 10;
	    err = (char *) malloc (len * sizeof (char));
	    strcpy (err, "mkdir ");
	    strcat (err, destdir);
	    perror (err);
	    free (err);
	    free (srcdir);
	    free (destdir);
	    continue;
	}
	/* avoid symlinks into the destination tree */
	if (lstat (destdir, &st) == 0)
	    q_push (used_inodes, (Pointer) st.st_ino);
	/* read from the source directory */
	if ((dir = opendir (srcdir)) == NULL) {
	    len = strlen (srcdir) + 10;
	    err = (char *) malloc (len * sizeof (char));
	    strcpy (err, "opendir ");
	    strcat (err, srcdir);
	    perror (err);
	    free (err);
	    free (srcdir);
	    free (destdir);
	    continue;
	}
	while ((ent = readdir (dir)) != NULL) {
	    /* xxx is it safe to assume the filename is null terminated? */
	    cp = ent->d_name;
	    if (! strcmp (cp, ".")) continue;
	    if (! strcmp (cp, "..")) continue;
	    if (! strcmp (cp, "RCS")) continue;
	    if (! strcmp (cp, "SCCS")) continue;
	    if (! strcmp (cp, "CVS")) continue;
	    /* stat the src file */
	    len = strlen (srcdir) + strlen (cp) + 2;
	    srcfile = (char *) malloc (len * sizeof (char));
	    strcpy (srcfile, srcdir);
	    strcat (srcfile, "/");
	    strcat (srcfile, cp);
	    if (lstat (srcfile, &st) < 0) {
		perror (srcfile);
		free (srcfile);
		continue;
	    }
	    /* create the dest file */
	    len = strlen (destdir) + strlen (cp) + 2;
	    destfile = (char *) malloc (len * sizeof (char));
	    strcpy (destfile, destdir);
	    strcat (destfile, "/");
	    strcat (destfile, cp);
	    /* if the source is a directory, add it to the list */
	    if (S_ISDIR (st.st_mode)) {
		/* check if we did this directory all ready */
		inode = (Pointer) st.st_ino;
		if (pointer_in_queue (used_inodes, inode)) {
		    fprintf (stderr, "%s: did this directory all ready.\n",
			     srcfile);
		    free (srcfile);
		    free (destfile);
		    continue;
		}
		q_push (used_inodes, inode);
		if (depth_list) q_push (depth_list, (Pointer) (depth + 1));
		q_push (s_dirs, srcfile);
		q_push (d_dirs, destfile);
	    }
	    /* if the source is not a directory, symlink it */
	    else {
		/* if the source is a symlink, create the same symlink */
		if (S_ISLNK (st.st_mode)) {
		    char buf[1024];
		    len = readlink (srcfile, buf, sizeof (buf));
		    if (len > 0) {
			buf[len] = 0;
			free (srcfile);
			srcfile = xstrdup (buf);
		    }
		}
		else if (depth) {
		    len = strlen (srcfile) + (3 * depth) + 1;
		    cp = (char *) malloc (len * sizeof (char));
		    *cp = 0;
		    for (x = 0; x < depth; x++) strcat (cp, "../");
		    strcat (cp, srcfile);
		    free (srcfile);
		    srcfile = cp;
		}
		if (symlink (srcfile, destfile) < 0) {
		    len = strlen (destfile) + 10;
		    err = (char *) malloc (len * sizeof (char));
		    strcpy (err, "symlink ");
		    strcat (err, destfile);
		    perror (err);
		    free (err);
		}
		free (srcfile);
		free (destfile);
	    }
	}
	closedir (dir);
	free (srcdir);
	free (destdir);
    }
    return 0;
}

static int pointer_in_queue (Queue q, Pointer p)
{
    int x;

    for (x = 0; x < q_size (q); x++)
	if (p == q_peek (q, x)) return 1;
    return 0;
}

static char *xstrdup (char *str)
{
    char *dup;

    dup = (char *) malloc ((strlen (str) + 1) * sizeof (char));
    strcpy (dup, str);
    return dup;
}

#ifndef HAVE_STRING_H
char *strrchr (char *str, char c)
{
    char *cp;

    cp = NULL;
    for (; *str; str++)
	if (*str == c) cp = str;
    return cp;
}
#endif
