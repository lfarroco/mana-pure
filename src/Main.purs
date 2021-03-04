module Main where

import Prelude

import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Graphics.Phaser (PhaserImage, PhaserScene, addImage, addTween, createScene, delay, newGame, setImageDisplaySize, setImageOrigin, text)


createImageAt :: PhaserScene -> Effect PhaserImage
createImageAt scene = do
  img <- addImage scene 0 0 "backgrounds/sunset"
  img_ <- setImageOrigin img 0 0
  setImageDisplaySize img_ 800 600 

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600 
  launchAff do
    scene <- createScene game "aaa"
    title <-  liftEffect $ text {
      scene,
      x: 10,
      y:10,
      text: "Aehoooo", config: { color: "#ffffff", fontSize: 24, fontFamily: "sans-serif" }
      }
    image <-  liftEffect $ createImageAt scene
    _ <-  liftEffect $ addTween scene image 1000 100 100 2000 "Cubic" 0 false 
    delay scene 1000
    liftEffect $ log "done!"
