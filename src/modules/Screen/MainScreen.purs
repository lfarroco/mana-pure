module Screen.MainScreen where

import Prelude
import Core.Models (size, vec)
import Data.List (fromFoldable)
import Data.Maybe (Maybe(..))
import Game.Domain.Events (ManaEvent(..))
import UI.Elements (Element(..), createContainerId)

mainScreen :: Element
mainScreen =
  Container
    { id: createContainerId "mainScreen"
    , pos: vec 0 0
    , size: size 1600 1200
    , onClick: Just $ ContainerClick "hahahahahahaha"
    , children:
        fromFoldable
          [ Image { pos: { x: 500, y: 100 }, texture: "backgrounds/sunset", size: { width: 200, height: 200 } }
          , Rect { pos: { x: 200, y: 200 }, size: { width: 300, height: 200 }, color: "0xff33aa" }
          , Text { pos: { x: 0, y: 0 }, text: "aaa" }
          , Text { pos: { x: 110, y: 110 }, text: "bbb" }
          , Text { pos: { x: 220, y: 220 }, text: "ccc" }
          , Text { pos: { x: 330, y: 330 }, text: "ddd" }
          , Container
              { id: createContainerId "innerContainer"
              , pos: { x: 10, y: 10 }
              , size: size 0 0
              , children:
                  fromFoldable
                    [ Rect { pos: { x: 0, y: 0 }, size: { width: 50, height: 50 }, color: "0xff33aa" }
                    ]
              , onClick: Nothing
              }
          ]
    }
