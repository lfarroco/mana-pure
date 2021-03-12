module Screen.Infrastructure.MapScreen where

import Prelude

import Core.Models (size, vec)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))

mapScreenId :: ContainerId
mapScreenId = createContainerId "mapScreen"


mapScreen :: forall a. (Element a) 
mapScreen =
  Container
    { id: mapScreenId
    , pos: vec 0 0
    , size: size 800 600
    , onClick:
        [ \state vector ->
            TweenImage "chara" vector 1000.0
        ]
    , onCreate:
        [ OnUpdate \state time delta -> do pure unit
        ]
    , children:
        [ Text { pos: vec 200 200, text: "brrrrrrrrr" }
        , Image { id: "chara", pos: vec 100 100, texture: "chara/head_male", tint: Nothing }
        ]
    }
