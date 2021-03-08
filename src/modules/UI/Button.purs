module UI.Button where

import Core.Models (Size, Vector)
import Game.Domain.Events (ManaEvent)
import UI.Elements (Element(..))

button :: String -> String -> Vector -> Size -> Array ManaEvent -> Element
button id text pos size onClick =
  Container
    { id
    , pos
    , size
    , onClick
    , children:
        [ Rect
            { pos: { x: 0, y: 0 }
            , size: { width: size.width, height: size.height }
            , color: "0x888888"
            }
        , Text
            { pos: { x: 10, y: 10 }
            , text
            }
        ]
    }
