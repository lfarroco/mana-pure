module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Graphics.Phaser (addImage, createScene, newGame)


main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600 
  launchAff do
    scene <- createScene game "aaa"
    _ <-  liftEffect $ addImage scene 0 0 "backgrounds/sunset"
    liftEffect $ log "done!"

  

