module Game.Infrasctruture.ManaModels where

import Character.Application (CharacterIndex)
import Core.Models (State)
import Data.Map (Map)
import Game.Domain.Events (Element)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene)

type ManaState
  = State PhaserGame PhaserScene PhaserContainer (Map String PhaserContainer)
      (Map String Element) -- screenIndex
      (CharacterIndex)
      (Map String Element) -- components
