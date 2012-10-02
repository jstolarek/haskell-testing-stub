module Test.Utils (
    testWithProvider
  , (@=~?)
  , (?=~@)
  , (=~)
 ) where

import qualified Test.Framework                 as TF
import qualified Test.Framework.Providers.HUnit as TFH
import qualified Test.HUnit                     as HU

class AEq a where
    (=~) :: a -> a -> Bool

instance AEq Double where
    x =~ y = abs ( x - y ) < (1.0e-10 :: Double)

instance (AEq a) => AEq [a] where
    xs =~ ys = (length xs == length ys) && 
                (all (\(x,y) -> x =~ y) $ zip xs ys)

instance (AEq a) => AEq (Maybe a) where
    Nothing =~ Nothing = True
    Just x  =~ Just y  = x =~ y
    _       =~ _       = False

-- This function takes the name for the test, a testing function and a data
-- provider and creates a testGroup
testWithProvider :: String -> (a -> HU.Assertion) -> [a] -> TF.Test
testWithProvider testGroupName testFunction =
    TF.testGroup testGroupName . map createTest . zipWith assignName [1::Int ..]
      where 
        createTest (name, dataSet)   = TFH.testCase name $ testFunction dataSet
        assignName setNumber dataSet = ("Data set " ++ show setNumber, dataSet)

-- "Almost equal" assertions for HUnit
(@=~?) :: (Show a, AEq a) => a -> a -> HU.Assertion
(@=~?) expected actual  = expected =~ actual HU.@? assertionMsg
    where
      assertionMsg = "Expected : " ++ show expected ++ 
                     "\nActual   : " ++ show actual

(?=~@) :: (Show a, AEq a) => a -> a -> HU.Assertion
(?=~@) actual expected = actual =~ expected HU.@? assertionMsg
    where
      assertionMsg = "Actual   : " ++ show actual ++
                     "\nExpected : " ++ show expected
