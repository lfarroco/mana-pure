module UI.Button where

import Prelude
import Core.Models (Size, Vector, size, vec)
import Data.List (fromFoldable)
import Data.Maybe (Maybe(..))
import Game.Domain.Events (ManaEvent)
import UI.Elements (Element(..))

button :: String -> String -> Vector -> Size -> Maybe ManaEvent -> Element
button id text pos size onClick =
  Container
    { id
    , pos
    , size
    , onClick
    , children:
        fromFoldable
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
