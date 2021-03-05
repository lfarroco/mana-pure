module Main where

import Prelude
import Core.Models (vec)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (new)
import Graphics.Phaser (addContainer, createScene, newGame)
import Screen.Infrastructure.MainScreen (mainScreen)
import UI.Render (render)

main :: Effect (Fiber Unit)
main = do
  state <- new 0
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    root <- addContainer scene (vec 0 0) # liftEffect
    _ <- render scene state mainScreen root # liftEffect
    log "Game started" # liftEffect
