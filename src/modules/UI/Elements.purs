module UI.Elements where

import Prelude
import Core.Models (Size, Vector, vec)
import Data.List (List, fromFoldable)
import Data.Maybe (Maybe(..))
import Effect (Effect)

type Event
  = forall a. (a -> Effect Unit) -> a -> Effect Unit

data Element
  = Container
    { id :: ContainerId
    , pos :: Vector
    , children :: List Element
    , onClick :: Maybe Event
    }
  | Rect { pos :: Vector, size :: Size, color :: String }
  | Image { pos :: Vector, size :: Size, texture :: String }
  | Text { pos :: Vector, text :: String }

newtype ContainerId
  = ContainerId String

createContainerId :: String -> ContainerId
createContainerId s = ContainerId s

emptyContainer :: String -> Element
emptyContainer id =
  Container
    { id: createContainerId id
    , pos: vec 0 0
    , children: fromFoldable []
    , onClick: Nothing
    }
