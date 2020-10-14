default: all

all: transfer_fund

transfer_fund: transfer_fund.c
	gcc -ggdb -m32 -mpreferred-stack-boundary=2 -fno-stack-protector -o transfer_fund transfer_fund.c
	cp *.txt /tmp

clean:
	rm -f *~ transfer_fund
