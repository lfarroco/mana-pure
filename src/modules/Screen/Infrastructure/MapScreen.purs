module Screen.Infrastructure.MapScreen where

import Prelude
import Core.Models (size, vec)
import Data.Maybe (Maybe(..))
import Effect.Class.Console (log)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserScene, removeOnUpdate)

mapScreenId :: ContainerId
mapScreenId = createContainerId "mapScreen"

mapScreen :: PhaserScene -> Element
mapScreen scene =
  Container
    { id: mapScreenId
    , pos: vec 0 0
    , size: size 800 600
    , onClick:
        [ \vector -> TweenImage "chara" vector 1000
        ]
    , onCreate:
        [ OnUpdate \time delta ->
            if time < 10000 then
              log $ show time
            else do
              removeOnUpdate scene
        ]
    , children:
        [ Text { pos: vec 200 200, text: "brrrrrrrrr" }
        , Image { id: "chara", pos: vec 100 100, texture: "chara/head", tint: Nothing }
        ]
    }
