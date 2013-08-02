haskell-testing-stub
====================

This stub project demonstrates how to organize code tests and benchmarks in a
Haskell project. It shows how to:
  * separate tests and benchmarks from the actual code, so that users don't need
    to install testing and benchmarking libraries
  * use cabal to automate testing and benchmarking
  * use [test-framework](http://hackage.haskell.org/package/test-framework)
    to create a coherent test suite containing both [HUnit]
    (http://hackage.haskell.org/package/HUnit) and [QuickCheck]
    (http://hackage.haskell.org/package/QuickCheck) tests
  * create [QuickCheck](http://hackage.haskell.org/package/QuickCheck) tests
    that run with many different test data sets.
  * use [criterion](http://hackage.haskell.org/package/criterion) to create code
    benchmarks

Visit my blog for a detailed discussion of code [testing]
(http://ics.p.lodz.pl/~stolarek/blog/2012/09/code-testing-in-haskell) and
[benchmarking]
(http://ics.p.lodz.pl/~stolarek/blog/2012/10/code-benchmarking-in-haskell/) in
Haskell. See also comments in the source code.

Running tests
=============

Execute these commands to compile and run tests:

```
cabal configure --enable-tests
cabal build
cabal test
```

Running benchmarks
==================

Execute these commands to compile and run benchmarks:

```
cabal configure --enable-benchmarks
cabal build
cabal bench
```

Compiling the library
=====================

Execute these commands to install the library without benchmarking and testing
code:

```
cabal configure
cabal build
cabal install
```
