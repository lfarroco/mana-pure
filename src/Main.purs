module Main where

import Prelude
import Core.Models (ManaState, vec)
import Data.Map (Map, empty, insert)
import Effect (Effect)
import Effect.Aff (Fiber, launchAff)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, new)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, createScene, newGame)
import Screen.Infrastructure.MainScreen (mainScreen)
import UI.Render (render)

type Mana
  = ManaState PhaserGame PhaserScene (Map String PhaserContainer)

initial :: PhaserGame -> PhaserScene -> Mana
initial game scene = { game, scene, containers: empty }

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
    _ <- render scene state mainScreen root # liftEffect
    log "Game started" # liftEffect
