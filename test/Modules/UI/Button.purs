module Test.UI.Button where

import Game.Domain.Events (Element)
import UI.Button (button)

testButton :: Element
testButton = button "testId" "test" { x: 100, y: 100 } { width: 100, height: 100 } []
