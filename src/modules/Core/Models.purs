module Core.Models where

import Data.Int (toNumber)
import Data.Map (Map)

type IndexOf a
  = Map String a

-- When a vector refers to a position on screen,
-- where numbers may not be integers
type Vector
  = { x :: Number, y :: Number }

vec :: Int -> Int -> Vector
vec x y = { x: toNumber (x), y: toNumber (y) }

-- When a vector refers to a position on a board,
-- like in checkers
type BoardSquare
  = { x :: Int
    , y :: Int
    }

boardSquare :: Int -> Int -> BoardSquare
boardSquare x y = { x, y }

type Size
  = { width :: Number, height :: Number }

size :: Int -> Int -> Size
size width height = { width: toNumber width, height: toNumber height }
