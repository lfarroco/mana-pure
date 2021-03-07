module Screen.Infrastructure.UnitList where

import Prelude
import Core.Models (size, vec)
import Data.List (fromFoldable)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)
import UI.Elements (Element(..))

unitList :: Element
unitList =
  Container
    { id: "unitList"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , children:
        fromFoldable
          [ button "unitListBtn" "go back" pos sz
              $ [ Destroy "unitList"
                , Render "mainScreen"
                ]
          ]
    }
  where
  pos = vec 100 100

  sz = size 120 50
