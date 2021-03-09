module UI.Button where

import Core.Models (Size, Vector)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent)

button :: String -> String -> Vector -> Size -> Array (ManaEvent Element ContainerId) -> Element
button id text pos size onClick =
  Container
    { id: createContainerId id
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
