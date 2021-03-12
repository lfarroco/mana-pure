module Main where

import Prelude
import Character.Infrastructure (characterIndex)
import Core.Models (Vector, vec)
import Data.Map (empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Ref (Ref, new)
import Game.Domain.Element (createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Assets (assets)
import Game.Infrastructure.Events (runEvent)
import Game.Infrastructure.Renderer (render)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.CharaTest (charaTest)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.MapScreen (mapScreen)
import Screen.Infrastructure.UnitList (unitListScreen)

main :: Effect (Fiber Unit)
main = do
  game <- newGame 640 360
  mapState <- new $ vec 100 100 
  launchAff do
    scene <- createScene { game, name: "main", assets }
    root <- createRootContainer scene
    state <- createInitialState game scene root mapState
    runEvent render state (RenderScreen "mainScreen" $ createContainerId "__root") # liftEffect
  where
  createRootContainer scene = addContainer scene (vec 0 0) # liftEffect

  createInitialState game scene root mapState = liftEffect $ new $ (addScreens scene (initial game scene root) mapState)

initial :: PhaserGame -> PhaserScene -> PhaserContainer -> PhaserState
initial game scene root =
  { game
  , scene
  , root
  , containerIndex:
      empty
        # insert (createContainerId "__root") root
  , screenIndex: empty
  , characterIndex
  , imageIndex: empty
  }

addScreens :: PhaserScene -> PhaserState -> Ref Vector -> PhaserState
addScreens scene state mapState =
  state
    { screenIndex =
      state.screenIndex
        # insert "mainScreen" mainScreen
        # insert "unitListScreen" (unitListScreen characterIndex)
        # insert "charaTest" charaTest
        # insert "mapScreen" (mapScreen scene mapState)
    }
