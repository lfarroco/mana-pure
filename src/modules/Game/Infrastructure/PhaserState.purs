module Game.Infrasctruture.PhaserState where

import Core.Models (State, Vector)
import Data.Map (Map)
import Game.Domain.Element (ContainerId)
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserImage, PhaserScene)

type PhaserState
  = State
      { containerIndex :: Map ContainerId PhaserContainer
      , game :: PhaserGame
      , imageIndex :: Map String PhaserImage
      , root :: PhaserContainer
      , scene :: PhaserScene
      , characters :: Map String { pos :: Vector, id :: String }
      }
