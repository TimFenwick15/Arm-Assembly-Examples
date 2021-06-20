CC=arm-linux-gnueabihf-gcc
CFLAGS=-static -I.
OBJS=hello print syswrite
BIN_DIR=bin

# The rule at the top of the file is run by default. So you can call 'make' instead of 'make all'
all: $(OBJS)

# This is a general rule for .s files, % is a filename wildcard, $@ is LHS of the rule, $^ is RHS of the rule
%: %.s
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $^

# This is a general rule for .c files
%: %.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $^

clean:
	rm $(addprefix $(BIN_DIR)/, $(OBJS))

