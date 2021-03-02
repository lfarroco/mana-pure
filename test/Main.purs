module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Class.Console (log)
import Test.Core.BoundedNumber

main :: Effect Unit
main = do
  boundedTests
