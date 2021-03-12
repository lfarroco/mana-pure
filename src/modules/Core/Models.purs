module Core.Models where

import Data.Int (toNumber)

type Vector
  = { x :: Number, y :: Number }

vec :: Int -> Int -> Vector
vec x y = { x: toNumber (x), y: toNumber (y) }

type Size
  = { width :: Int, height :: Int }

size :: Int -> Int -> Size
size width height = { width, height }

type State game scene root cont screenIndex characterIndex imageIndex
  = { game :: game
    , root :: root
    , scene :: scene
    , containerIndex :: cont
    , screenIndex :: screenIndex
    , characterIndex :: characterIndex
    , imageIndex :: imageIndex
    }
