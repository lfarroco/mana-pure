module Test.Main where

import Prelude

import Effect (Effect)
import Test.Core.BoundedNumber (boundedTests)
import Test.Theater.Isometric (isometricTests)

main :: Effect Unit
main = do
  boundedTests
  isometricTests

