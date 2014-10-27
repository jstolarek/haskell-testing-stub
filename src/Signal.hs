-- This module creates the public API for the library. It imports all
-- internal modules and re-exports only selected functions.
module Signal (
    cyclicShiftLeft
  , cyclicShiftRight
 ) where

import Signal.Utils
