module UI.Button where

import Core.Models (Size, Vector, vec)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent)

button :: String -> String -> Vector -> Size -> Array (Vector -> ManaEvent Element ContainerId) -> Element
button id text pos size onClick =
  Container
    { id: createContainerId id
    , pos
    , size
    , onClick
    , onCreate: []
    , children:
        [ Rect
            { pos: vec 0 0
            , size: { width: size.width, height: size.height }
            , color: "0x888888"
            }
        , Text
            { pos: vec 10 10
            , text
            }
        ]
    }
