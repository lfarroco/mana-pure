module Screen.Infrastructure.MainScreen where

import Prelude
import Core.Models (size, vec)
import Game.Domain.Events (Element(..), ManaEvent(..))
import UI.Button (button)

mainScreen :: Element
mainScreen =
  Container
    { id: "mainScreen"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , children:
        [ Image { pos: { x: 500, y: 100 }, texture: "backgrounds/sunset", size: { width: 200, height: 200 } }
        , button "startGameBtn" "go to unit list" pos sz
            $ [ Destroy "mainScreen"
              , RenderScreen "unitListScreen" "__root"
              ]
        ]
    }
  where
  pos = vec 100 200

  sz = size 120 50
