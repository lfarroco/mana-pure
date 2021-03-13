module Match.Application where

import Prelude
import Core.Models (BoardSquare)
import Data.Maybe (Maybe(..))
import Match.Battlefield (Battlefield, TileType, Tile)
import Matrix (Matrix, empty, set)

createBattlefield :: Battlefield
createBattlefield =
  { tiles: empty
  , cities: empty
  }

createTile :: TileType -> BoardSquare -> Tile
createTile type_ pos =
  { type_
  , pos
  }
