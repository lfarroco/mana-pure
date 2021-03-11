module Screen.Infrastructure.MainScreen where

import Prelude
import Core.Models (size, vec)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)

mainScreen :: Element
mainScreen =
  Container
    { id: createContainerId "mainScreen"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Image { id: "mainScreenBg", pos: { x: 500, y: 100 }, texture: "backgrounds/sunset", tint: Nothing }
        , button "startGameBtn" "go to unit list" pos sz
            [ \_ -> Destroy $ createContainerId "mainScreen"
            , \_ -> RenderScreen "unitListScreen" $ createContainerId "__root"
            ]
        , button "charatest" "chara test" (vec 300 200) sz
            [ \_ -> Destroy $ createContainerId "mainScreen"
            , \_ -> RenderScreen "charaTest" $ createContainerId "__root"
            ]
        , button "mapTeste" "map test" (vec 500 200) sz
            [ \_ -> Destroy $ createContainerId "mainScreen"
            , \_ -> RenderScreen "mapScreen" $ createContainerId "__root"
            ]
        ]
    }
  where
  pos = vec 100 200

  sz = size 120 50
