module Screen.Infrastructure.MainScreen where

import Prelude
import Core.Models (size, vec)
import Data.List (fromFoldable)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)
import UI.Elements (Element(..))

mainScreen :: Element
mainScreen =
  Container
    { id: "mainScreen"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , children:
        fromFoldable
          [ Image { pos: { x: 500, y: 100 }, texture: "backgrounds/sunset", size: { width: 200, height: 200 } }
          , button "startGameBtn" "go to unit list" pos sz
              $ [ Destroy "mainScreen"
                , Render "unitList"
                ]
          ]
    }
  where
  pos = vec 100 200

  sz = size 120 50
