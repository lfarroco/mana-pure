module Screen.Infrastructure.MapScreen where

import Prelude

import Core.Models (Vector, size, vec)
import Data.Maybe (Maybe(..))
import Effect.Class.Console (log)
import Effect.Ref (Ref, read)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserScene, removeOnUpdate)

mapScreenId :: ContainerId
mapScreenId = createContainerId "mapScreen"

mapScreen :: PhaserScene -> Ref Vector -> Element
mapScreen scene state =
  Container
    { id: mapScreenId
    , pos: vec 0 0
    , size: size 800 600
    , onClick:
        [ \vector ->
            let
              a = read state
            in
              TweenImage "chara" vector 1000.0
        ]
    , onCreate:
        [ OnUpdate \time delta ->
            if time < 10000.0 then
              log $ show time
            else do
              -- c <- getImage "chara"
              removeOnUpdate scene
        ]
    , children:
        [ Text { pos: vec 200 200, text: "brrrrrrrrr" }
        , Image { id: "chara", pos: vec 100 100, texture: "chara/head_male", tint: Nothing }
        ]
    }
