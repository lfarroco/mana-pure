module Game.Domain.Element where

import Prelude
import Core.Models (Size, Vector, size, vec)
import Game.Domain.Events (ManaEvent)

data Element
  = Container
    { id :: ContainerId
    , pos :: Vector
    , size :: Size
    , children :: Array Element
    , onClick :: Array (ManaEvent Element ContainerId)
    }
  | Rect { pos :: Vector, size :: Size, color :: String }
  | Image { pos :: Vector, texture :: String }
  | Text { pos :: Vector, text :: String }
  | Chara
    { pos :: Vector
    , id :: String
    , hairStyle :: String
    , hairColor :: String
    , skinColor :: String
    , hat :: String
    , head :: String
    , leftHand :: String
    , rightHand :: String
    , trunk :: String
    , leftFoot :: String
    , rightFoot :: String
    }

newtype ContainerId
  = ContainerId String

derive instance eqContainerId :: Eq ContainerId

derive instance ordContainerId :: Ord ContainerId

createContainerId :: String -> ContainerId
createContainerId id = ContainerId id

emptyContainer :: String -> Element
emptyContainer id =
  Container
    { id: createContainerId id
    , pos: vec 0 0
    , size: size 0 0
    , children: []
    , onClick: []
    }
