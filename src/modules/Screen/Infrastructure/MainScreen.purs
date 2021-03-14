module Screen.Infrastructure.MainScreen where

import Prelude

import Core.Models (size, vec)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import UI.Button (button)

mainScreen :: PhaserState -> Element PhaserState
mainScreen state =
  Container
    { id: createContainerId "mainScreen"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Image { id: "mainScreenBg", pos: vec 500 100, texture: "backgrounds/sunset", tint: Nothing }
        , button "startGameBtn" "go to unit list" (vec 100 200) sz
            [ \st vector -> Destroy $ createContainerId "mainScreen"
            , \st vector -> RenderScreen "unitListScreen" 
            ]
        , button "charaTestBtn" "chara test" (vec 300 200) sz
            [ \st vector -> Destroy $ createContainerId "mainScreen"
            , \st vector -> RenderScreen "charaTest" 
            ]
        , button "mapTestBtn" "map test" (vec 500 200) sz
            [ \st vector -> Destroy $ createContainerId "mainScreen"
            , \ _ _ -> CreateTileMap
            , \st vector -> RenderScreen "mapScreen" 
            ]
        ]
    }
  where
  sz = size 120 50
