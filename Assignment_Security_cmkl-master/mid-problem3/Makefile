default: all

all: common_bug

common_bug: common_bug.c
	gcc -ggdb -m32 -mpreferred-stack-boundary=2 -fno-stack-protector -o common_bug common_bug.c

clean:
	rm -f *~ common_bug
