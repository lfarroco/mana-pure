module Game.Infrasctruture.PhaserState where

import Character.Application (CharacterIndex)
import Core.Models (State)
import Data.Map (Map)
import Game.Domain.Element (ContainerId, Element)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserImage, PhaserScene)

-- application of `State` with Phaser's bindings
type PhaserState
  = State
      PhaserGame
      PhaserScene
      PhaserContainer -- root
      (Map ContainerId PhaserContainer) -- containerIndex
      (Map String Element) -- screenIndex
      (CharacterIndex)
      (Map String PhaserImage) -- imageIndex
