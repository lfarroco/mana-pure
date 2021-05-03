module Match.Model.Battlefield where

import Match.Model.City (City)

import Data.Maybe (Maybe)
import Matrix (Matrix)

type Battlefield
  = { tiles :: Matrix Tile
    , cities :: Matrix (Maybe City)
    }

data Tile
  = Grass
  | Mountain
  | Woods
  | Water


