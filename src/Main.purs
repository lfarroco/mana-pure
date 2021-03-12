module Main where

import Prelude

import Core.Models (vec)
import Data.Map (empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Ref (new)
import Game.Domain.Element (createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Assets (assets)
import Game.Infrastructure.Events (runEvent)
import Game.Infrastructure.Renderer (render)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)

main :: Effect (Fiber Unit)
main = do
  game <- newGame 640 360
  mapState <- new $ vec 100 100
  launchAff do
    scene <- createScene { game, name: "main", assets }
    root <- createRootContainer scene
    state <- (new $ initilState game scene root) # liftEffect
    runEvent render state initialEvent # liftEffect
  where
  initialEvent = RenderScreen "mainScreen" $ createContainerId "__root"

  createRootContainer scene = addContainer scene (vec 0 0) # liftEffect

initilState :: PhaserGame -> PhaserScene -> PhaserContainer -> PhaserState
initilState game scene root =
  { game
  , scene
  , root
  , containerIndex:
      empty
        # insert (createContainerId "__root") root
  , imageIndex: empty
  }
