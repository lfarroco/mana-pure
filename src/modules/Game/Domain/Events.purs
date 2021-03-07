module Game.Domain.Events where

import Prelude
import Data.Map (Map)
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

data ManaEvent
  = ContainerClick String
  | Destroy String
  | Render ScreenId ParentId

type State a
  = Map String a
