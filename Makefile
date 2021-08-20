CC = gcc
CFLAGS += -std=c11 -Wpedantic -Wall -Wextra -Wmissing-prototypes -Wstrict-prototypes -Wconversion -Wshadow -Wcast-qual -Wnested-externs
CFLAGS += -fsanitize=address -fno-omit-frame-pointer -g
CFLAGS += -I./lua/src -L./lua/src
LDFLAGS = -llua -lm -ldl
OBJECTS = main.o

all: demo

main.o:

demo: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -o demo $(LDFLAGS)

clean:
	rm -f *.o demo

# Direct:
# gcc -std=c11 -Wall -Wpedantic -o demo main.c -I./lua/src -L./lua/src -llua -lm -ldl

