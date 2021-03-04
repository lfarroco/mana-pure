module Screen.MainScreen where

import Data.List (fromFoldable)
import Data.Maybe (Maybe(..))
import UI.Elements (Element(..), createContainerId)

mainScreen :: Element
mainScreen =
  Container
    { id: createContainerId "mainScreen"
    , pos: { x: 0, y: 0 }
    , children:
        fromFoldable
          [ Image { pos: { x: 500, y: 100 }, texture: "backgrounds/sunset", size: { width: 200, height: 200 } }
          , Text { pos: { x: 0, y: 0 }, text: "aaa" }
          , Text { pos: { x: 110, y: 110 }, text: "bbb" }
          , Text { pos: { x: 220, y: 220 }, text: "ccc" }
          , Text { pos: { x: 330, y: 330 }, text: "ddd" }
          , Rect { pos: { x: 200, y: 500 }, size: { width: 300, height: 200 }, color: "0xff33aa" }
          ]
    , onClick: Nothing
    }
