module Main (
    main
 ) where

import Criterion.Main
import Criterion.Types
import System.Random

import qualified BenchParam        as P
import qualified Signal.UtilsBench as U

main :: IO ()
main = defaultMainWith benchConfig . benchmarks $ mkStdGen 123456

-- This function assembles all benchmarks. let-binding is used because the same
-- data is shared between different functions, but in general this is not
-- necessary
benchmarks :: RandomGen g => g -> [Benchmark]
benchmarks gen =
    let paramCyclicShift = U.dataShift gen P.shiftSize P.sigSize
    in [
      bgroup "Signal shifts"
      [
        bench "Left shift"  $ nf U.benchCyclicShiftLeft  paramCyclicShift
      , bench "Right shift" $ nf U.benchCyclicShiftRight paramCyclicShift
      ]
    ]

-- This configuration enables garbage collection between benchmarks. It is a
-- good idea to do so. Otherwise GC might distort your results
benchConfig :: Config
benchConfig = defaultConfig {
             forceGC = True
           }
