-- This module creates the public API for the library. It import all
-- internal modules and reexports only selected functions.
module Signal (
    cyclicShiftLeft
  , cyclicShiftRight
 ) where

import Signal.Utils
