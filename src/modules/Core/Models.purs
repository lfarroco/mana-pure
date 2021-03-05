module Core.Models where

type Vector
  = { x :: Int, y :: Int }

vec :: Int -> Int -> Vector
vec x y = { x, y }

type Size
  = { width :: Int, height :: Int }

size :: Int -> Int -> Size
size width height = { width, height }
