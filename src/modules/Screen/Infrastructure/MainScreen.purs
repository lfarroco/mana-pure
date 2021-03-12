module Screen.Infrastructure.MainScreen where

import Prelude
import Core.Models (size, vec)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)

mainScreen :: forall a. Element a
mainScreen =
  Container
    { id: createContainerId "mainScreen"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Image { id: "mainScreenBg", pos: vec 500 100, texture: "backgrounds/sunset", tint: Nothing }
        , button "startGameBtn" "go to unit list" pos sz
            [ \state vector -> Destroy $ createContainerId "mainScreen"
            , \state vector -> RenderScreen "unitListScreen" $ createContainerId "__root"
            ]
        , button "charaTestBtn" "chara test" (vec 300 200) sz
            [ \state vector -> Destroy $ createContainerId "mainScreen"
            , \state vector -> RenderScreen "charaTest" $ createContainerId "__root"
            ]
        , button "mapTestBtn" "map test" (vec 500 200) sz
            [ \state vector -> Destroy $ createContainerId "mainScreen"
            , \state vector -> RenderScreen "mapScreen" $ createContainerId "__root"
            ]
        ]
    }
  where
  pos = vec 100 200

  sz = size 120 50
