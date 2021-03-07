module Core.Models where

type Vector
  = { x :: Int, y :: Int }

vec :: Int -> Int -> Vector
vec x y = { x, y }

type Size
  = { width :: Int, height :: Int }

size :: Int -> Int -> Size
size width height = { width, height }

type ManaState game scene root cont sceneIndex
  = { game :: game
    , root :: root
    , scene :: scene
    , containers :: cont -- rename to `containerIndex`
    , sceneIndex :: sceneIndex
    }
