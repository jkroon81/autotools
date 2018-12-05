bin_PROGRAMS = snakeman
snakeman_SOURCES = main.c

noinst_LIBRARIES =
noinst_LTLIBRARIES =

EXTRA_DIST = extra.mk

include subdir1/Makefile.am
include subdir2/Makefile.am
$(eval include $(srcdir)/extra.mk)
