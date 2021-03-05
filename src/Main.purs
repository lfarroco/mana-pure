module Main where

import Prelude
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (modify, new)
import Graphics.Phaser (addImage, createScene, imageOnPointerUp, newGame)

main :: Effect (Fiber Unit)
main = do
  ref <- new 0
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    img <- liftEffect $ addImage scene 100 100 "backgrounds/sunset"
    _ <-
      liftEffect
        $ imageOnPointerUp img
            ( \e -> do
                newVal <- modify (\n -> n + 1) ref
                log $ show newVal
            )
    --root <- liftEffect $ addContainer scene $ vec 0 0
    -- _ <- liftEffect $ render scene mainScreen root
    -- _ <- liftEffect $ setContainerSize root $ size 800 600
    -- _ <- liftEffect $ containerOnPointerUp root (\e -> do log "zzz")
    liftEffect $ pure unit
