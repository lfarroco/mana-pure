module Main where

import Prelude
import Core.Models (vec)
import Data.Map (empty, insert)
import Data.Maybe (Maybe(..))
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
  game <- newGame 1024 768
  mapState <- new $ vec 100 100
  launchAff do
    scene <- createScene { game, name: "main", assets }
    root <- createRootContainer scene
    state <- (new $ initilState game scene root) # liftEffect
    runEvent render state initialEvent # liftEffect
  where
  initialEvent = RenderScreen "mainScreen"

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
  , characters:
      empty
        # insert "id1" ({ pos: vec 100 100, id: "id1", action: Nothing })
        # insert "id2" ({ pos: vec 400 100, id: "id2", action: Nothing })
  , selectedSquad: Nothing
  }
