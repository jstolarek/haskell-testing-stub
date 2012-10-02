module Signal.UtilsTest where

import Test.HUnit
import Test.QuickCheck
import Test.Utils

import Signal.Utils

-- A typical HUnit test. I don't recommend creating such tests - this one
-- is here only to demonstrate how to adapt already existing HUnit tests.
-- Next function shows how to create test functions that neatly integrate
-- with test-framework
testCyclicOneShiftRightHU :: Test
testCyclicOneShiftRightHU = 
    "Cyclic one shift right" ~: [4,1,2,3]  @=? cyclicOneShiftRight [1,2,3,4]

-- A recommended way of creating HUnit tests. Such tests are easy to integrate
-- with test-framework (see MainTestSuite.hs)
testCyclicOneShiftLeftAssertion :: Assertion
testCyclicOneShiftLeftAssertion = 
    [4,1,2,3] @=? cyclicOneShiftRight [1,2,3,4]

-- HUnit test function working with data provider. Notice also that it uses my
-- custom (@=~?) operator, which is an "almost equal" assertion. In this case
-- a standard "is equal" (@=?) assertion would be sufficient, so this is only
-- for demonstration purposes.
testCyclicShiftLeft :: (Int, [Double], [Double]) -> Assertion
testCyclicShiftLeft (n, xs, expected) =
    expected @=~? cyclicShiftLeft n xs

-- This function acts as data provider for testCyclicLeftShift. Each tuple in
-- a list is a separate test data set.
dataCyclicShiftLeft :: [(Int, [Double], [Double])]
dataCyclicShiftLeft =
    [
       ( 0, [],        []        )
     , ( 2, [1,2,3,4], [3,4,1,2] )
     , ( 4, [1,2],     [1,2]     )
    ]

-- Below are standard QuickCheck properties

propCyclicOneShiftIdentity1 :: [Double] -> Property
propCyclicOneShiftIdentity1 xs = 
    not (null xs) ==>
        cyclicOneShiftLeft (cyclicOneShiftRight xs) == xs

propCyclicOneShiftIdentity2 :: [Double] -> Property
propCyclicOneShiftIdentity2 xs = 
    not (null xs) ==>
        cyclicOneShiftRight (cyclicOneShiftLeft xs) == xs

propLeftShiftIdentity :: [Double] -> Bool
propLeftShiftIdentity xs =
    cyclicShiftLeft (length xs) xs == xs

propRightShiftIdentity :: [Double] -> Bool
propRightShiftIdentity xs =
    cyclicShiftRight (length xs) xs == xs
