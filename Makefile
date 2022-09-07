.PHONY: all clean

all: weedis

clean:
	rm -f weedis *.o

test: weedis
	./weedis -test

weedis: vm.h weedis.c common.h common.c test.h test.c
	cc -o weedis weedis.c common.c test.c
