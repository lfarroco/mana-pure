module UI.Elements where

import Core.Models (Size, Vector, size, vec)
import Data.List (List, fromFoldable)
import Game.Domain.Events (ManaEvent)

data Element
  = Container
    { id :: ContainerId
    , pos :: Vector
    , size :: Size
    , children :: List Element
    , onClick :: Array ManaEvent
    }
  | Rect { pos :: Vector, size :: Size, color :: String }
  | Image { pos :: Vector, size :: Size, texture :: String }
  | Text { pos :: Vector, text :: String }

type ContainerId
  = String

emptyContainer :: String -> Element
emptyContainer id =
  Container
    { id
    , pos: vec 0 0
    , size: size 0 0
    , children: fromFoldable []
    , onClick: []
    }
