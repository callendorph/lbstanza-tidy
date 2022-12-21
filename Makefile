all: build

tests: tidy-tests
	./tidy-tests

test-%: tidy-tests
	./tidy-tests -tagged $(@:test-%=%)

build:
	stanza build

tidy-tests: src/*.stanza tests/*.stanza
	stanza build tidy-tests

PYPARSE_HEADERS=/mnt/c/Users/callendorph/Documents/AFT/Jitx/lbstanza-wrappers/venv/lib/python3.5/site-packages/pycparser_fake_libc
PPFLAGS=-std=c99 -I$(PYPARSE_HEADERS) -include ./headers/ulong.h
tidy-headers: tidy-html5/include/*.h ./headers/*.h
	gcc -E $(PPFLAGS) ./tidy-html5/include/*.h > ./tidyfull.h

tidy-enums: tidy-headers
	python convery.py --input ./tidyfull.h enums --pkg-prefix tidy/Enums --out-dir ./src/Enums/ --skip Bool --skip memory_order --skip tidyStrings
	python convert.py --input ./tidyfull.h func-decl --pkg-prefix tidy --output src/Wrapper.stanza --func-form both

clean:
	rm -f ./pkgs/*.pkg
	rm -f ./test-pkgs/*.pkg

.phony: clean