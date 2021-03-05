module Main where

import Prelude
import Core.Models (size, vec)
import Effect (Effect)
import Effect.Aff (Fiber, forkAff, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Graphics.Phaser (addContainer, containerOnPointerUp, createScene, newGame, setContainerSize)
import Screen.MainScreen (mainScreen)
import UI.Render (render)
)
main :: Effect (Fiber (Fiber Unit))
main = do
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    root <- liftEffect $ addContainer scene $ vec 0 0
    _ <- liftEffect $ setContainerSize root $ size 800 600
    _ <- liftEffect $ render scene mainScreen root
    forkAff do
      containerOnPointerUp root
      log "done"

