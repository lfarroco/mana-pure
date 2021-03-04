module UI.Elements where

import Prelude
import Core.Models (Vector, Size)
import Data.List (List)
import Data.Maybe (Maybe)
import Effect (Effect)

type Event
  = forall a. (a -> Effect Unit) -> a -> Effect Unit

newtype ContainerId
  = ContainerId String

createContainerId :: String -> ContainerId
createContainerId s = ContainerId s

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
