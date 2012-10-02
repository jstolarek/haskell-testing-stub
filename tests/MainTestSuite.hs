module Main (
    main
 ) where

import Test.Framework
import Test.Framework.Providers.QuickCheck2
import Test.Framework.Providers.HUnit
import Test.Utils

import Signal.UtilsTest

main :: IO ()
main = defaultMain tests

tests :: [Test]
tests =
  [
    testGroup "Signal shifts"
    [
       testGroup        "Migrated from HUnit"     $ 
                                   hUnitTestToTests testCyclicOneShiftRightHU
     , testProperty     "L/R one shift composition" propCyclicOneShiftIdentity1
     , testProperty     "R/L one shift composition" propCyclicOneShiftIdentity2
     , testProperty     "Left shift identity"       propLeftShiftIdentity
     , testProperty     "Right shift identity"      propRightShiftIdentity
     , testWithProvider "Cyclic left shift"         testCyclicShiftLeft
                                                    dataCyclicShiftLeft
    ]
  ]
