module UI.Elements where

import Prelude
import Core.Models (Size, Vector, size, vec)
import Data.List (List, fromFoldable)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Game.Domain.Events (ManaEvent)

type Event
  = forall a. (a -> Effect Unit) -> a -> Effect Unit

data Element
  = Container
    { id :: ContainerId
    , pos :: Vector
    , size :: Size
    , children :: List Element
    , onClick :: Maybe ManaEvent
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
    , onClick: Nothing
    }
