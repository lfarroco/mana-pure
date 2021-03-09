module Game.Infrasctruture.PhaserState where

import Character.Application (CharacterIndex)
import Core.Models (State)
import Data.Map (Map)
import Game.Domain.Events (Element)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene)

-- `State` applied with Phaser's bindings
type PhaserState
  = State
      PhaserGame
      PhaserScene
      PhaserContainer -- root
      (Map String PhaserContainer) -- containerIndex
      (Map String Element) -- screenIndex
      (CharacterIndex)
