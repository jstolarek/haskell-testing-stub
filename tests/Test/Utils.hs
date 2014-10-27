module Test.Utils (
    hUnitTestToTests
  , testWithProvider
  , (@=~?)
  , (?=~@)
  , (=~)
 ) where

import qualified Test.Tasty       as TF
import qualified Test.Tasty.HUnit as TFH
import qualified Test.HUnit       as HU
import qualified Test.HUnit.Base  as HUB

class AEq a where
    (=~) :: a -> a -> Bool

instance AEq Double where
    x =~ y = abs ( x - y ) < (1.0e-8 :: Double)

instance (AEq a) => AEq [a] where
    xs =~ ys = (length xs == length ys) &&
                (all (\(x,y) -> x =~ y) $ zip xs ys)

instance (AEq a) => AEq (Maybe a) where
    Nothing =~ Nothing = True
    Just x  =~ Just y  = x =~ y
    _       =~ _       = False

-- migrated from test-framework-hunit, beause tasty-hunit does not
-- have this function
hUnitTestToTests :: HUB.Test -> [TF.TestTree]
hUnitTestToTests = go ""
  where
    go desc (HUB.TestCase a)    = [TFH.testCase desc a]
    go desc (HUB.TestLabel s t)
      | null desc = go s t
      | otherwise = go (desc ++ ":" ++ s) t
    go desc (HUB.TestList ts)
        -- If the list occurs at the top level (with no description above it),
        -- just return that list straightforwardly
      | null desc = concatMap (go desc) ts
        -- If the list occurs with a description, turn that into a honest-to-god
        -- test group. This is heuristic, but likely to give good results
      | otherwise = [TF.testGroup desc (concatMap (go "") ts)]

-- This function takes the name for the test, a testing function and a data
-- provider and creates a testGroup
testWithProvider :: String -> (a -> HU.Assertion) -> [a] -> TF.TestTree
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
