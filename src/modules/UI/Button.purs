module UI.Button where

import Prelude
import Core.Models (Vector, Size)
import Data.List (fromFoldable)
import Data.Maybe (Maybe(..))
import UI.Elements (Element(..))

button :: String -> String -> Vector -> Size -> Element
button id text pos size =
  Container
    { id
    , pos
    , size
    , onClick: Nothing
    , children:
        fromFoldable
          [ Rect
              { pos: { x: 0, y: 0 }
              , size: { width: size.width + 20, height: size.height + 20 }
              , color: "0xeaeaeaea"
              }
          , Text
              { pos: { x: 10, y: 10 }
              , text
              }
          ]
    }
