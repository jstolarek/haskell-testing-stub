-- This module is an internal part of the library. There is no encapsulation -
-- all functions are exported from the module. Note that cyclicOneShiftLeft and
-- cyclicOneShiftRight are partial functions. They do not work for empty list.
-- Note also that they will not be part of a public API (see src/Signal.hs)
-- On the other hand cyclicShiftLeft and cyclicShiftRight are total functions.
-- They are reexported in Signal module to create a public API of the library
module Signal.Utils where

cyclicOneShiftLeft :: (Num a) => [a] -> [a]
cyclicOneShiftLeft (x:xs) = xs ++ [x]
cyclicOneShiftLeft [] = []

cyclicOneShiftRight :: (Num a) => [a] -> [a]
cyclicOneShiftRight xs = last xs : init xs

cyclicShiftLeft :: (Num a) => Int -> [a] -> [a]
cyclicShiftLeft _ [] = []
cyclicShiftLeft n xs
    | n > 0     = cyclicShiftLeft (n - 1) . cyclicOneShiftLeft $ xs
    | otherwise = xs

cyclicShiftRight :: (Num a) => Int -> [a] -> [a]
cyclicShiftRight _ [] = []
cyclicShiftRight n xs
    | n > 0     = cyclicShiftRight (n - 1) . cyclicOneShiftRight $ xs
    | otherwise = xs
