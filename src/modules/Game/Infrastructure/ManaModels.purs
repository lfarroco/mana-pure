module Game.Infrasctruture.ManaModels where

import Core.Models (State)
import Data.Map (Map)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene)
import UI.Elements (Element)

type Mana
  = State PhaserGame PhaserScene PhaserContainer (Map String PhaserContainer) (Map String Element)
