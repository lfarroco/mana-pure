module Game.Domain.Events where

import Prelude
import Core.Models (Vector, Size, size, vec)
import Effect (Effect)
import Effect.Class.Console (log)

newtype ScreenName
  = ScreenName String

createScreenName :: String -> ScreenName
createScreenName s = ScreenName s

data GameEvents
  = StartGame
  | ChangeScreen ScreenName

processEvent :: GameEvents -> Effect Unit
processEvent e = case e of
  StartGame -> do log "startGame"
  ChangeScreen (ScreenName s) -> do log s

type ScreenId
  = String

type ParentId
  = String

-- an event that is capable of producing elements of a given type using a given type of state
data ManaEvent
  = ContainerClick String
  | Destroy String
  | RenderScreen ScreenId ParentId
  | RemoveChildren String
  | RenderComponent String Element -- parentId Element

data Element
  = Container
    { id :: ContainerId
    , pos :: Vector
    , size :: Size
    , children :: Array Element
    , onClick :: Array ManaEvent
    }
  | Rect { pos :: Vector, size :: Size, color :: String }
  | Image { pos :: Vector, size :: Size, texture :: String }
  | Text { pos :: Vector, text :: String }
  -- Unit List Screen
  | UnitInfo String

type ContainerId
  = String

emptyContainer :: String -> Element
emptyContainer id =
  Container
    { id
    , pos: vec 0 0
    , size: size 0 0
    , children: []
    , onClick: []
    }
