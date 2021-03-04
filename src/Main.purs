module Main where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Graphics.Phaser (createScene, newGame)
import Screen.MainScreen (mainScreen)
import UI.Render (render)

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    liftEffect $ render scene mainScreen Nothing
