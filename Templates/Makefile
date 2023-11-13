PROJECT-NAME=default-name

CC=cc
CFLAGS=-Wall -Wextra -O2 -I$(INCLUDE-DIR)
LIBS=

SOURCE-DIR=.
INCLUDE-DIR=.

SRCS:=$(shell find $(SOURCE-DIR) -name '*.c')
OBJS=$(wildcard *.o)

all: link $(PROJECT-NAME)

link: $(SRCS)
	gcc -c $^

$(PROJECT-NAME): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

run:
	@./$(PROJECT-NAME)
