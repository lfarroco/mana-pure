module Test.Main where

import Effect (Effect)
import Prelude
import Test.Core.BoundedNumber (boundedTests)
--import Test.UI.Button (testButton)

main :: Effect Unit
main = do
  boundedTests

