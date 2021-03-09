module Screen.Infrastructure.CharaTest where

import Prelude
import Core.Models (size, vec)
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)

charaTest :: Element
charaTest =
  Container
    { id: createContainerId "charaTest"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , children:
        [ Rect { pos: vec 100 100, size: size 200 400, color: "0xeaeaea" }
        , chara
        ]
    }

chara :: Element
chara =
  Container
    { id: createContainerId "chara"
    , pos: vec 100 100
    , size: size 200 400
    , onClick: []
    , children:
        [ Image { pos: vec 125 130, texture: "chara/hand" }
        , Image { pos: vec 120 172, texture: "chara/foot" }
        , Image { pos: vec 90 180, texture: "chara/foot" }
        , Image { pos: vec 100 140, texture: "chara/trunk_fighter" }
        , Image { pos: vec 100 70, texture: "chara/head_male" }
        , Image { pos: vec 80 140, texture: "chara/hand" }
        ]
    }
