module Signal.UtilsBench where

import Signal.Utils
import System.Random

-- These functions are wrappers around actually benchmarked functions. They
-- unwrap a tuple created by dataShift and pass the parameters from the tuple
-- to benchmarked functions. They should be inlined.
benchCyclicShiftLeft :: (Int, [Double]) -> [Double]
benchCyclicShiftLeft (n, sig) = cyclicShiftLeft n sig

{-# INLINE benchCyclicShiftLeft #-}

benchCyclicShiftRight :: (Int, [Double]) -> [Double]
benchCyclicShiftRight (n, sig) = cyclicShiftRight n sig 

{-# INLINE benchCyclicShiftRight #-}

-- Function that generates data on which benchmarked functions will operate
dataShift :: RandomGen g => g -> Int -> Int -> (Int, [Double])
dataShift gen n sigSize = (n, take sigSize $ randoms gen)
