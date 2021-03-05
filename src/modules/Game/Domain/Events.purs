module Game.Domain.Events where

import Prelude
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref)

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

data ManaEvent
  = ContainerClick String

type State
  = Ref Int
