haskell-testing-stub
====================

This stub project demonstrates how to organize code tests and benchmarks in a
Haskell project. It shows how to:
  * separate tests and benchmarks from the actual code, so that users don't need
    to install testing and benchmarking libraries
  * use cabal to automate testing and benchmarking
  * use test-framework to create a coherent test suite containing both HUnit 
    and QuickCheck tests
  * create HUnit tests that run with many different test data sets.
  * use criterion to create code benchmarks

Visit my blog for a detailed discussion of code [testing]
(http://ics.p.lodz.pl/~stolarek/blog/2012/09/code-testing-in-haskell) and
[benchmarking]
(http://ics.p.lodz.pl/~stolarek/blog/2012/10/code-benchmarking-in-haskell/) in 
Haskell.
See also comments in the source code.
