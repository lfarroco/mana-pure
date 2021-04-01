module Game.Infrasctruture.PhaserState where

import Core.Models (State, Vector)
import Data.Map (Map)
import Data.Maybe (Maybe)
import Game.Domain.Element (ContainerId)
import Phaser.Graphics.ForeignTypes (PhaserContainer, PhaserGame, PhaserImage, PhaserScene)

type PhaserState
  = State
      { containerIndex :: Map ContainerId PhaserContainer
      , game :: PhaserGame
      , imageIndex :: Map String PhaserImage
      , root :: PhaserContainer
      , scene :: PhaserScene
      -- Map Scene State
      -- TODO: create new type Action, with possible current actions for characters on map
      , characters :: Map String { pos :: Vector, id :: String, action:: Maybe Vector }
      , selectedSquad:: Maybe String
      }


