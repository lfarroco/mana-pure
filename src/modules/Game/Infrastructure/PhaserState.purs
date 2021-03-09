module Game.Infrasctruture.PhaserState where

import Character.Application (CharacterIndex)
import Core.Models (State)
import Data.Map (Map)
import Game.Domain.Element (Element)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene)

-- application of `State` with Phaser's bindings
type PhaserState
  = State
      PhaserGame
      PhaserScene
      PhaserContainer -- root
      (Map String PhaserContainer) -- containerIndex
      (Map String Element) -- screenIndex
      (CharacterIndex)
