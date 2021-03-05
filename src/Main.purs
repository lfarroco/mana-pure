module Main where

import Prelude
import Control.Monad.Trans.Class (lift)
import Core.Models (size, vec)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify, new)
import Graphics.Phaser (PhaserContainer, PhaserScene, addContainer, addImage, containerOnPointerUp, createScene, imageOnPointerUp, newGame, setContainerSize)
import Screen.MainScreen (mainScreen)
import UI.Render (render)

type State
  = Ref Int

onclick :: forall t4. State -> PhaserScene -> PhaserContainer -> t4 -> Effect Unit
onclick state scene container e = do
  newVal <- modify (\n -> n + 1) state
  _ <- render scene mainScreen container
  log $ show newVal

main :: Effect (Fiber Unit)
main = do
  state <- new 0
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    root <- addContainer scene (vec 0 0) # liftEffect
    _ <- setContainerSize root (size 1600 1200) # liftEffect
    --img <- addImage scene 100 100 "backgrounds/sunset" # liftEffect
    _ <-
      onclick state scene root
        # containerOnPointerUp root
        # liftEffect
    -- _ <- liftEffect $ render scene mainScreen root
    -- _ <- liftEffect $ setContainerSize root $ size 800 600
    -- _ <- liftEffect $ containerOnPointerUp root (\e -> do log "zzz")
    log "Game started" # liftEffect
