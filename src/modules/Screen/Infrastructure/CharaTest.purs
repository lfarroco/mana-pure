module Screen.Infrastructure.CharaTest where

import Prelude
import Core.Models (size, vec)
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))

charaTest :: Element
charaTest =
  Container
    { id: createContainerId "charaTest"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Rect { pos: vec 100 100, size: size 200 400, color: "0xeaeaea" }
        , chara "1"
        ]
    }

chara :: String -> Element
chara id =
  Container
    { id: createContainerId $ "chara_" <> id
    , pos: vec 100 100
    , size: size 200 400
    , onClick: []
    , onCreate:
        [ TweenImage $ "chara_lhand_" <> id
        ]
    , children:
        [ Image { id: "chara_lhand_" <> id, pos: vec 125 130, texture: "chara/hand" }
        , Image { id: "chara_lfoot_" <> id, pos: vec 120 172, texture: "chara/foot" }
        , Image { id: "chara_rfoot_" <> id, pos: vec 90 180, texture: "chara/foot" }
        , Image { id: "chara_trunk_" <> id, pos: vec 100 140, texture: "chara/trunk_fighter" }
        , Image { id: "chara_head_" <> id, pos: vec 100 70, texture: "chara/head_male" }
        , Image { id: "chara_rhand_" <> id, pos: vec 80 140, texture: "chara/hand" }
        ]
    }
