module Game.Domain.Events where

import Prelude
import Core.Models (Vector)
import Effect (Effect)

type ScreenId
  = String

type ParentId
  = String

data ManaEvent element containerId
  = Destroy containerId
  | RenderScreen ScreenId containerId
  | RemoveChildren containerId
  | RenderComponent containerId element
  | TweenImage String Vector Int
  | OnUpdate (Int -> Int -> Effect Unit)
  | RemoveOnUpdate
