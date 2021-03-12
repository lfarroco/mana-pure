module Core.Models where

import Data.Int (toNumber)

type Vector
  = { x :: Number, y :: Number }

vec :: Int -> Int -> Vector
vec x y = { x: toNumber (x), y: toNumber (y) }

type Size
  = { width :: Number, height :: Number }

size :: Int -> Int -> Size
size width height = { width: toNumber width, height: toNumber height }

type State state
  = state
