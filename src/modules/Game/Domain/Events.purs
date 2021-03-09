module Game.Domain.Events where

import Core.Models (Vector)

type ScreenId
  = String

type ParentId
  = String

-- an event that is capable of producing elements of a given type
data ManaEvent element containerId
  = Destroy containerId
  | RenderScreen ScreenId containerId
  | RemoveChildren containerId
  | RenderComponent containerId element -- parentId Element
  | TweenImage String Vector Int -- parentId Element
