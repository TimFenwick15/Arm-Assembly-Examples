CC=arm-linux-gnueabihf-gcc
CFLAGS=-static -I.
SRC_DIR=src
BIN_DIR=bin

# Make a list of everything in SRC_DIR, where sed s replaces regex matches with anything after the /. This means files in our SCR_DIR get built without us needing to add them to the makefile
OBJS=$(shell ls $(SRC_DIR) | sed 's/\.[sc]//')

# The rule at the top of the file is run by default. So you can call 'make' instead of 'make all'
all: $(OBJS)

# This is a general rule for .s files, % is a filename wildcard, $@ is LHS of the rule, $^ is RHS of the rule
%: $(SRC_DIR)/%.s
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $^

# This is a general rule for .c files
%: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/$@ $^

clean:
	rm $(addprefix $(BIN_DIR)/, $(OBJS))

