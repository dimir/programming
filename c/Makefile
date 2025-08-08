SRCS=$(wildcard *.c)

OBJS=$(SRCS:.c=.o)
EXECS :=$(SRCS:.c=)

LDLIBS = -lz -lcrypt

all: $(OBJS) $(EXECS)

clean:
	rm -f $(OBJS) $(EXECS)
