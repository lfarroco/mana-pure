module Main where

import Prelude
import Core.Models (vec)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (new)
import Graphics.Phaser (addContainer, createScene, newGame)
import Screen.MainScreen (mainScreen)
import UI.Render (render)

main :: Effect (Fiber Unit)
main = do
  state <- new 0
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    root <- addContainer scene (vec 0 0) # liftEffect
    _ <- render scene state mainScreen root # liftEffect
    --img <- addImage scene 100 100 "backgrounds/sunset" # liftEffect
    -- _ <-
    --   onclick state scene root
    --     # containerOnPointerUp root (ContainerClick "zzzzz")
    --     # liftEffect
    -- _ <- liftEffect $ render scene mainScreen root
    -- _ <- liftEffect $ setContainerSize root $ size 800 600
    -- _ <- liftEffect $ containerOnPointerUp root (\e -> do log "zzz")
    log "Game started" # liftEffect
