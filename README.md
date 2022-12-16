# Stanza wrapper for LibTidy

This adds a stanza wrapper around the libtidy implementation. This allows for parsing
HTML, XHTML, and XML documents.

## Setup

You will need to either install libtidy or clone its repo from github. If you clone
from github, you will need to run the cmake build to generate the static/dynamic
libraries. Then you can modify the `start.sh` script to tell the build system
where it can expect to find these files.

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
