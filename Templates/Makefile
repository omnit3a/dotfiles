PROJECT-NAME=default-name

CC=cc
CFLAGS=-Wall -Wextra -O2
LIBS=-I$(INCLUDE-DIR)

SOURCE-DIR=.
INCLUDE-DIR=.

SRCS:=$(shell find . -name '*.c')
OBJS=$(wildcard *.o)

all: link $(PROJECT-NAME)

link: $(SRCS)
	$(CC) -c $^ $(CFLAGS) $(LIBS)

$(PROJECT-NAME): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

run:
	@./$(PROJECT-NAME)
