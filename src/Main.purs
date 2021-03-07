module Main where

import Prelude
import Core.Models (ManaState, vec)
import Data.Map (Map, empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, new)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.UnitList (unitList)
import UI.Elements (Element)
import UI.Render (runEvent)

type Mana
  = ManaState PhaserGame PhaserScene (Map String PhaserContainer) (Map String Element)

initial :: PhaserGame -> PhaserScene -> Mana
initial game scene =
  { game
  , scene
  , containers: empty
  , sceneIndex:
      empty
        # insert "mainScreen" mainScreen
        # insert "unitList" unitList
  }

setContainer :: Mana -> String -> PhaserContainer -> Mana
setContainer state s c = state { containers = insert s c state.containers }

main :: Effect (Fiber Unit)
main = do
  game <- newGame 800 600
  launchAff do
    scene <- createScene game "main"
    state <- liftEffect $ new $ initial game scene
    root <- addContainer scene (vec 0 0) # liftEffect
    modify_ (\s -> setContainer s "__root" root) state # liftEffect
    runEvent state scene root (Render "mainScreen") # liftEffect
    log "Game started" # liftEffect
