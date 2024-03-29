CC = gcc

NAME = flisp
SRCS = $(NAME).c builtins.c string.c equalhash.c table.c iostream.c
OBJS = $(SRCS:%.c=%.o)
DOBJS = $(SRCS:%.c=%.do)
EXENAME = $(NAME)
LIBTARGET = lib$(NAME)
LLTDIR = ../llt
LLT = $(LLTDIR)/libllt.a

# OS flags: LINUX, WIN32, MACOSX
# architecture flags: __CPU__=xxx, BITS64, ARCH_X86, ARCH_X86_64
CONFIG = -DLINUX -DARCH_X86_64 -DBITS64 -D__CPU__=686
FLAGS = -falign-functions -Wall -Wno-strict-aliasing -I$(LLTDIR) $(CFLAGS) -DUSE_COMPUTED_GOTO $(CONFIG)
LIBFILES = $(LLT)
LIBS = $(LIBFILES) -lm

DEBUGFLAGS = -g -DDEBUG $(FLAGS)
SHIPFLAGS = -O2 -DNDEBUG $(FLAGS)

default: release test

test:
	./flisp unittest.lsp

%.o: %.c
	$(CC) $(SHIPFLAGS) -c $< -o $@
%.do: %.c
	$(CC) $(DEBUGFLAGS) -c $< -o $@

flisp.o:  flisp.c cvalues.c types.c flisp.h print.c read.c equal.c
flisp.do: flisp.c cvalues.c types.c flisp.h print.c read.c equal.c
flmain.o: flmain.c flisp.h
flmain.do: flmain.c flisp.h

$(LLT):
	cd $(LLTDIR) && make

$(LIBTARGET).da: $(DOBJS)
	rm -rf $@
	ar rs $@ $(DOBJS)

$(LIBTARGET).a: $(OBJS)
	rm -rf $@
	ar rs $@ $(OBJS)

debug: $(DOBJS) $(LIBFILES) $(LIBTARGET).da flmain.do
	$(CC) $(DEBUGFLAGS) $(DOBJS) flmain.do -o $(EXENAME) $(LIBS) $(LIBTARGET).da
	make test

release: $(OBJS) $(LIBFILES) $(LIBTARGET).a flmain.o
	$(CC) $(SHIPFLAGS) $(OBJS) flmain.o -o $(EXENAME) $(LIBS) $(LIBTARGET).a

clean:
	rm -f *.o
	rm -f *.do
	rm -f $(EXENAME)
