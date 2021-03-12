module Test.UI.Button where

import Core.Models (size, vec)
import Game.Domain.Element (Element)
import UI.Button (button)

testButton :: forall t1. Element t1
testButton = button "testId" "test" (vec 100 100) (size 100 100) []
