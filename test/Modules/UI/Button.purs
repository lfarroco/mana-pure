module Test.UI.Button where


import UI.Button (button)
import UI.Elements (Element)

testButton :: Element
testButton = 
    button "testId" "test" {x:100 , y:100} {width: 100, height:  100}