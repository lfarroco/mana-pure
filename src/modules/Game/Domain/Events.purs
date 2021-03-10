module Game.Domain.Events where

import Core.Models (Vector)

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
