PROJECT-NAME=default-name

CC=cc
CFLAGS=-Wall -Wextra -O2 -I$(INCLUDE-DIR)
LIBS=

SOURCE-DIR=.
INCLUDE-DIR=.

SRCS:=$(shell find . -name '*.c')

all: link $(PROJECT-NAME)

link: $(SRCS)
	$(CC) -c $^ $(CFLAGS) $(LIBS)

$(PROJECT-NAME):
	$(CC) -o $@ *.o $(CFLAGS) $(LIBS)
