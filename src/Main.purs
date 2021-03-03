module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Graphics.Phaser (PhaserImage, PhaserScene, addImage, addTween, createScene, delay, newGame, setImageDisplaySize)


createImageAt :: PhaserScene -> Effect PhaserImage
createImageAt scene = do
  img <- addImage scene 0 0 "backgrounds/sunset"
  setImageDisplaySize img 800 600 

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600 
  launchAff do
    scene <- createScene game "aaa"
    image <-  liftEffect $ createImageAt scene
    _ <-  liftEffect $ addTween scene image 1000 100 100 2000 "Cubic" 0 false 
    delay scene 1000
    liftEffect $ log "done!"



