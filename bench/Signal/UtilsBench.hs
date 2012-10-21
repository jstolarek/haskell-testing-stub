module Signal.UtilsBench where

import Signal.Utils
import System.Random

-- These two functions are wrappers around actually benchmarked functions. They
-- unwrap a tuple created by dataShift and pass the parameters from the tuple to
-- benchmarked functions. They should be inlined.

{-# INLINE benchCyclicShiftLeft #-}
benchCyclicShiftLeft :: (Int, [Double]) -> [Double]
benchCyclicShiftLeft (n, sig) = cyclicShiftLeft n sig

{-# INLINE benchCyclicShiftRight #-}
benchCyclicShiftRight :: (Int, [Double]) -> [Double]
benchCyclicShiftRight (n, sig) = cyclicShiftRight n sig 

-- Function that generates data on which benchmarked functions will operate
dataShift :: RandomGen g => g -> Int -> Int -> (Int, [Double])
dataShift gen n sigSize = (n, take sigSize $ randoms gen)
