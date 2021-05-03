module Test.Theater.Isometric where

import Screen.Theater.Isometric

import Core.Models (boardSquare, size, vec)
import Data.Show (show)
import Effect (Effect)
import Effect.Class.Console (log)
import Prelude (Unit, ($))

isometricTests :: Effect Unit
isometricTests = do
  log $ show $ cartesianToIsometric (vec 400 300) (boardSquare 1 1)
  -- log "Should accept an number equal to the minimum"
  -- quickCheck $ (\n-> (createBoundedNumber (n-1) n  n) ==  BoundedNumber { min :n-1, max: n, value: n})
  -- log "Should accept an number equal to the maximum"
  -- quickCheck $ (\n-> (createBoundedNumber n (n+1) n) ==  BoundedNumber { min :n, max: n+1, value: n})
  -- log "Should apply the lower bound for numbers below the minimum"
  -- quickCheck $ (\n-> (createBoundedNumber (n-1) n (n-2)) ==  BoundedNumber { min :n-1, max: n, value: n-1})
  -- log "Should apply the upper bound for numbers above the maximum"
  -- quickCheck $ (\n-> (createBoundedNumber n (n+1) (n+2)) ==  BoundedNumber { min :n, max: n+1, value: n+1})
 
