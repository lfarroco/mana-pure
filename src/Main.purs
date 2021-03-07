module Main where

import Prelude
import Core.Models (vec)
import Data.Map (empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, new)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.ManaModels (Mana)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.UnitList (unitList)
import UI.Render (runEvent)

initial :: PhaserGame -> PhaserScene -> PhaserContainer -> Mana
initial game scene root =
  { game
  , scene
  , root
  , containers: empty
  , sceneIndex:
      empty
        # insert "mainScreen" mainScreen
        # insert "unitList" unitList
  }

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    root <- addContainer scene (vec 0 0) # liftEffect
    state <- liftEffect $ new $ initial game scene root
    modify_ (\st -> st { containers = insert "__root" root st.containers }) state # liftEffect
    runEvent state (Render "mainScreen" "__root") # liftEffect
    log "Game started" # liftEffect
