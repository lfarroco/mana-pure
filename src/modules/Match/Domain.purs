module Match.Domain where

import Character.Application (CharacterIndex)
import Character.Domain (Character)
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
    , pos :: TilePosition
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
    , pos :: TilePosition
    }

type TilePosition = {
  x:: Int,
  y:: Int
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
    , pos :: TilePosition
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
