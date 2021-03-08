module Screen.Infrastructure.UnitList where

import Debug.Trace
import Prelude
import Character.Application (CharacterIndex)
import Character.Infrastructure (characterIndex)
import Core.Models (size, vec)
import Data.Array (fromFoldable)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map (values)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)
import UI.Elements (Element(..))

renderList :: CharacterIndex -> Array Element
renderList index =
  index
    # values
    # mapWithIndex
        ( \i v ->
            button
              ("unitList_id" <> (show $ i + 1))
              (v.name)
              (vec 300 (100 + (i * 60)))
              (size 200 50)
              [ RenderUnitInfo $ "id" <> show (i + 1) ]
        )
    # fromFoldable

cc :: Array Element
cc = renderList characterIndex

unitListScreen :: CharacterIndex -> Element
unitListScreen charaIndex =
  Container
    { id: "unitListScreen"
    , pos: vec 0 0
    , size: size 800 600
    , onClick: []
    , children
    }
  where
  pos = vec 100 100

  sz = size 120 50

  children =
    [ button "unitListBtn" "go back" pos sz
        $ [ Destroy "unitListScreen"
          , Render "mainScreen" "__root"
          ]
    , Container
        { id: "unitInfoWrapper"
        , pos: vec 500 200
        , size: size 0 0
        , onClick: []
        , children:
            [ UnitInfo "id1"
            ]
        }
    ]
      <> spy "list" (renderList charaIndex)
