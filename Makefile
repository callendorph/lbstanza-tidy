all: build

tests: build tidy-tests
	./tidy-tests

test-%: build tidy-tests
	./tidy-tests -tagged $(@:test-%=%)

build:
	stanza build

tidy-tests: src/*.stanza tests/*.stanza
	stanza build tidy-tests
