module Main where

import Prelude
import Character.Infrastructure (characterIndex)
import Core.Models (vec)
import Data.Map (empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, new)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Assets (assets)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.UnitList (unitListScreen)
import UI.RenderScreen (runEvent)

initial :: PhaserGame -> PhaserScene -> PhaserContainer -> PhaserState
initial game scene root =
  { game
  , scene
  , root
  , containerIndex: empty
  , screenIndex:
      empty
        # insert "mainScreen" mainScreen
        # insert "unitListScreen" (unitListScreen characterIndex)
  , characterIndex
  }

main :: Effect (Fiber Unit)
main = do
  game <- newGame 640 360
  launchAff do
    scene <- createScene { game, name: "main", assets }
    root <- addContainer scene (vec 0 0) # liftEffect
    state <- liftEffect $ new $ initial game scene root
    modify_ (\st -> st { containerIndex = insert "__root" root st.containerIndex }) state # liftEffect
    runEvent state (RenderScreen "mainScreen" "__root") # liftEffect
    log "Game started" # liftEffect
