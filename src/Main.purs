module Main where

import Prelude
import Character.Infrastructure (characterIndex)
import Core.Models (vec)
import Data.Map (empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (new)
import Game.Domain.Element (createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Assets (assets)
import Game.Infrastructure.Events (runEvent)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.CharaTest (charaTest)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.UnitList (unitListScreen)
import UI.RenderScreen (render)

main :: Effect (Fiber Unit)
main = do
  game <- newGame 640 360
  launchAff do
    scene <- createScene { game, name: "main", assets }
    root <- createRootContainer scene
    state <- createInitialState game scene root
    runEvent render state (RenderScreen "mainScreen" $ createContainerId "__root") # liftEffect
    log "Game started" # liftEffect
  where
  createRootContainer scene = addContainer scene (vec 0 0) # liftEffect

  createInitialState game scene root = liftEffect $ new $ initial game scene root

initial :: PhaserGame -> PhaserScene -> PhaserContainer -> PhaserState
initial game scene root =
  { game
  , scene
  , root
  , containerIndex:
      empty
        # insert (createContainerId "__root") root
  , screenIndex:
      empty
        # insert "mainScreen" mainScreen
        # insert "unitListScreen" (unitListScreen characterIndex)
        # insert "charaTest" charaTest
  , characterIndex
  }
