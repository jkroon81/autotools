bin_PROGRAMS = snakeman subdir1/snakeman2
snakeman_SOURCES = main.c
subdir1_snakeman2_SOURCES = subdir1/main.c
subdir1_snakeman2_LDADD = subdir1/libfoo.a subdir1/libbar.la
noinst_LIBRARIES = subdir1/libfoo.a
subdir1_libfoo_a_SOURCES = subdir1/foo.c
noinst_LTLIBRARIES = subdir1/libbar.la
subdir1_libbar_la_SOURCES = subdir1/bar.c
