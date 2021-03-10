module Match.Domain where

import Character.Application (CharacterIndex)
import Character.Domain (Character)
import Core.Models (Vector)
import Data.Map (Map)

type Player
  = { name :: String
    , color :: String
    , characters :: CharacterIndex
    , squads :: SquadIndex
    , pieces :: Piece
    }

type PlayerIndex
  = Map String Player

type Squad
  = { characters :: CharacterIndex
    , player :: String
    , board :: Map Int (Map Int Character)
    }

type SquadIndex
  = Map String Squad

type Piece
  = { character :: Character
    , pos :: Vector
    }

type Unknown
  = String

data TileType
  = Grass
  | Mountain
  | Woods
  | Water

type Tile
  = { type :: TileType
    , pos :: Vector
    }

type TileIndex
  = Map Int (Map Int Tile)

type Battlefield
  = { tiles :: TileIndex
    , cities :: Unknown
    }

type City
  = { name :: String
    , type_ :: CityType
    , pos :: Vector
    , controlledBy :: Player
    }

data CityType
  = Castle
  | Town
  | Village

type Match
  = { players :: PlayerIndex
    , battlefield :: Battlefield
    }
