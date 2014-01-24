module Main (
    main
 ) where

import Test.Tasty
import Test.Tasty.QuickCheck
import Test.Tasty.HUnit
import Test.Utils

import Signal.UtilsTest

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
    testGroup "Signal shifts"
    [
       testGroup        "Migrated from HUnit"     $
                                   hUnitTestToTests testCyclicOneShiftRightHU
     , testProperty     "L/R one shift composition" propCyclicOneShiftIdentity1
     , testProperty     "R/L one shift composition" propCyclicOneShiftIdentity2
     , testProperty     "Left shift identity"       propLeftShiftIdentity
     , testProperty     "Right shift identity"      propRightShiftIdentity
     , testCase         "Cyclic left shift by one"  testCyclicOneShiftLeftAssertion
     , testWithProvider "Cyclic left shift "        testCyclicShiftLeft
                                                    dataCyclicShiftLeft
    ]
