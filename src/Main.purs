module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console (log)
import Graphics.Phaser (PhaserImage, PhaserScene, PhaserText, addImage, addTween, createScene, delay, imageOnPointerUp, newGame, setImageDisplaySize, setImageOrigin, text)
import UI.Button (button)
import UI.Elements (Element, render)


createImageAt :: PhaserScene -> Effect PhaserImage
createImageAt scene = do
  img <- addImage scene 0 0 "backgrounds/sunset"
  img_ <- setImageOrigin img 0 0
  setImageDisplaySize img_ 800 600 

write :: forall a. MonadEffect a => PhaserScene -> a PhaserText
write scene = liftEffect $ text {
      scene,
      pos: {
      x: 10,
      y: 10},
      text: "Aehoooo", config: { color: "#ffffff", fontSize: 24, fontFamily: "sans-serif" }
      }

bbb :: Element
bbb = button "id" "Click me" {x:100,y: 100} {width:70, height: 30}

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600 
  launchAff do
    scene <- createScene game "main"
    --btn <- liftEffect $ solidColorRect scene {x: 100, y: 100}  {width: 100, height: 100} "0xeaeaea" 
    -- title <- write scene
    -- image <- liftEffect $ createImageAt scene
    -- imageOnPointerUp image
    -- _ <-  liftEffect $ addTween scene image 1000 500 500 2000 "Cubic" 0 false 
    -- delay scene 1000 
    -- liftEffect <<< log $ "done!"
    liftEffect $ render scene bbb Nothing
