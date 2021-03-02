module Test.Core.BoundedNumber where

import Core.BoundedNumber (BoundedNumber(..), createBoundedNumber)
import Effect (Effect)
import Effect.Class.Console (log)
import Prelude (Unit, discard, ($), (+), (-), (==))
import Test.QuickCheck (quickCheck)

boundedTests :: Effect Unit
boundedTests = do
  log "BoundedNumber tests"
  log "Should accept an number equal to the minimum"
  quickCheck $ (\n-> (createBoundedNumber (n-1) n  n) ==  BoundedNumber { min :n-1, max: n, value: n})
  log "Should accept an number equal to the maximum"
  quickCheck $ (\n-> (createBoundedNumber n (n+1) n) ==  BoundedNumber { min :n, max: n+1, value: n})
  log "Should apply the lower bound for numbers below the minimum"
  quickCheck $ (\n-> (createBoundedNumber (n-1) n (n-2)) ==  BoundedNumber { min :n-1, max: n, value: n-1})
  log "Should apply the upper bound for numbers above the maximum"
  quickCheck $ (\n-> (createBoundedNumber n (n+1) (n+2)) ==  BoundedNumber { min :n, max: n+1, value: n+1})
  log "Should accept all equal numbers"
  quickCheck $ (\n-> (createBoundedNumber n n n) ==  BoundedNumber { min :n, max: n, value: n})
