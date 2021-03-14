module Game.Domain.Element where

import Prelude
import Core.Models (Size, Vector, size, vec)
import Data.Maybe (Maybe)
import Effect.Ref (Ref)
import Game.Domain.Events (ManaEvent)

data Element gameState
  = Container
    { id :: ContainerId
    , pos :: Vector
    , size :: Size
    , children :: Array (Element gameState)
    , onClick :: Array (Ref gameState -> Vector -> ManaEvent (Element gameState) ContainerId gameState)
    , onCreate :: Array (ManaEvent (Element gameState) ContainerId gameState)
    }
  | Rect { pos :: Vector, size :: Size, color :: String }
  | Image { pos :: Vector, texture :: String, id :: String, tint :: Maybe String }
  | Text { pos :: Vector, text :: String }

newtype ContainerId
  = ContainerId String

derive instance eqContainerId :: Eq ContainerId
derive instance ordContainerId :: Ord ContainerId

createContainerId :: String -> ContainerId
createContainerId id = ContainerId id

emptyContainer :: forall gameState. String -> Element gameState
emptyContainer id =
  Container
    { id: createContainerId id
    , pos: vec 0 0
    , size: size 0 0
    , children: []
    , onClick: []
    , onCreate: []
    }
