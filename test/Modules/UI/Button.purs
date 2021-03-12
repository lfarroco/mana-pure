module Test.UI.Button where

import Prelude
import Core.Models (size, vec)
import Game.Domain.Element (Element)
import UI.Button (button)

testButton :: Element
testButton = button "testId" "test" (vec 100 100) (size 100 100) []
