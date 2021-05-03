module Screen.Theater.Isometric where

import Prelude
import Core.Models (BoardSquare, Vector)
import Data.Int (toNumber)

tileSize ::
  { height :: Number
  , width :: Number
  }
tileSize =
  { width: 64.0
  , height: 64.0
  }

cartesianToIsometric ::
  Vector ->
  BoardSquare ->
  Vector
cartesianToIsometric center { x, y } =
  let
    x' = toNumber x * tileSize.width

    y' = toNumber y * tileSize.height
  in
    { x: (x' - y') + center.x
    , y: ((x' + y') + center.y) / 2.0
    }
