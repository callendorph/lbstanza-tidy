# Stanza wrapper for LibTidy

This adds a stanza wrapper around the libtidy implementation. This allows for parsing
HTML, XHTML, and XML documents.

## Setup

This module includes `tidy-html5` as a git submodule for ease of build.

```
sudo apt install cmake build-essentials
git submodule update --init
cd tidy-html5
mkdir output
cd output
cmake ..
make
```

This will place the static/dynamic artifacts in the `tidy-html5/output` directory. The `start.sh` script references this directory and the `tidy-html5/include` folder.

If you want to install libtidy using your OS's package manager, you will need to set the environment variables in `start.sh` to the correct
location to find the headers and libraries.

## Build

```
$> source start.sh
$> make tests
stanza build
stanza build tidy-tests
./tidy-tests
[Test 1] test-basic
[PASS]

[Test 2] test-child-parent
[PASS]

[Test 3] test-node-attr
[PASS]

[Test 4] test-node-text
[PASS]

[Test 5] test-node-seq
[PASS]

[Test 6] test-attr-seq
[PASS]

[Test 7] test-version-basic
Release Date: 2022/01/25
Version : 5.9.20
Platform : Linux
[PASS]

Tests Finished: 7/7 tests passed. 0 tests skipped. 0 tests failed.

Longest Running Tests:
[PASS] test-basic (730 us)
[PASS] test-version-basic (515 us)
[PASS] test-attr-seq (371 us)
[PASS] test-node-text (340 us)
[PASS] test-node-seq (319 us)
[PASS] test-child-parent (297 us)
[PASS] test-node-attr (271 us)
```


## Example

```
  val doc = TidyDoc()
  val stat = get-status(doc)
  #EXPECT(stat == 0)

  val input = "<!DOCTYPE html><html><head><title>SomeStuff</title></head><body><p id=\"asdf\">SomeText</p><p id=\"qwer\">SomeMoreText</p></body></html>"

  val code = parse-str(doc, input)
  #EXPECT(code == 0)

  val body = get-body(doc)
  val pElems = to-tuple(get-children(body))
  ; pElems = [TidyNode(...), TidyNode(...)]
  ;   Where the pElems are the two 'p' nodes in the body.

```

See the unit tests for some more examples.
