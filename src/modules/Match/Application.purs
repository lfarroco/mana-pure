module Match.Application where

import Data.Map (empty, insert, lookup)
import Data.Maybe (Maybe(..))
import Match.Domain (Battlefield, Tile, TileIndex, TileType, TilePosition)

createBattlefield :: Battlefield
createBattlefield =
  { tiles: empty
  , cities: ""
  }

createTile :: TileType -> TilePosition -> Tile
createTile type_ pos =
  { type: type_
  , pos
  }

addTile :: TilePosition -> Tile -> TileIndex -> TileIndex
addTile { x, y } tile map_ =
  let
    next = case lookup y map_ of
      Just xn -> insert x tile xn
      Nothing -> insert x tile empty
  in
    insert y next map_
