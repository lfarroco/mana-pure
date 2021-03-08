module Game.Infrasctruture.ManaModels where

import Character.Domain (Character)
import Core.Models (State)
import Data.Map (Map)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene)
import UI.Elements (Element)

type ManaState
  = State PhaserGame PhaserScene PhaserContainer (Map String PhaserContainer) (Map String Element) (Map String Character)
