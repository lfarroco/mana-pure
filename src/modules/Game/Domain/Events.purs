module Game.Domain.Events where

import Prelude

import Core.Models (Vector)
import Data.Maybe (Maybe)
import Effect (Effect)
import Effect.Ref (Ref)

type ScreenId
  = String

type ParentId
  = String

-- time in ms since the loop has started
type Time = Number

-- difference in ms since the previous frame
type Delta = Number

data ManaEvent element containerId st
  = Destroy containerId
  | RenderScreen ScreenId 
  | RemoveChildren containerId
  | RenderComponent containerId element
  | TweenImage String Vector Number
  | OnUpdate (Ref st -> Time -> Delta -> Effect Unit)
  | RemoveOnUpdate
  -- map events
  | MoveImage String Vector
  | CreateTileMap
  | SetSquadAction String (Maybe Vector)
