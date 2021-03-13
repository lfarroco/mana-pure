module Match.Application.Battlefield where

import Data.Maybe (Maybe(..))
import Match.Domain.Battlefield (Battlefield, Tile(..))
import Match.Domain.City (City)
import Matrix (empty, repeat, set)

createBattlefield :: Int -> Int -> Battlefield
createBattlefield width height =
  { tiles: repeat width height (Grass)
  , cities: empty
  }

setTile :: Int -> Int -> Tile -> Battlefield -> Battlefield
setTile x y tile bf =
  let
    updated = set y x tile bf.tiles
  in
    case updated of
      Just t -> bf { tiles = t }
      Nothing -> bf

addCity :: City -> Battlefield -> Battlefield
addCity city bf =
  let
    setIn { x, y } = set x y (Just city)
  in
    case setIn city.pos bf.cities of
      Just v -> bf { cities = v }
      Nothing -> bf
