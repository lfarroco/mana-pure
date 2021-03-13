module Match.Battlefield where

import Core.Models (IndexOf, BoardSquare)
import Match.City as City
import Matrix (columns, Matrix)

type Battlefield
  = { tiles :: Matrix Tile
    , cities :: Matrix City.Id
    }

data TileType
  = Grass
  | Mountain
  | Woods
  | Water

type Tile
  = { type_ :: TileType
    , pos :: BoardSquare
    }

