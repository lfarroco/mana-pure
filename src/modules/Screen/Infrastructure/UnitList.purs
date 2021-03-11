module Screen.Infrastructure.UnitList where

import Prelude
import Character.Application (CharacterIndex)
import Core.Models (size, vec)
import Data.Array (fromFoldable)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map (values)
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)

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
              [ \_ -> RemoveChildren $ createContainerId "unitInfoWrapper"
              , \_ -> RenderComponent (createContainerId "unitInfoWrapper") (unitInfo v.id v.name)
              ]
        )
    # fromFoldable

unitInfo :: String -> String -> Element
unitInfo id name =
  Text
    { pos: vec 0 0
    , text: id <> " // " <> name
    }

unitListScreen :: CharacterIndex -> Element
unitListScreen charaIndex =
  Container
    { id: createContainerId "unitListScreen"
    , pos: vec 0 0
    , size: size 800 600
    , onClick: []
    , onCreate: []
    , children
    }
  where
  pos = vec 100 100

  sz = size 120 50

  children =
    [ button "unitListBtn" "go back" pos sz
        $ [ \_ -> Destroy $ createContainerId "unitListScreen"
          , \_ -> RenderScreen "mainScreen" $ createContainerId "__root"
          ]
    , Container
        { id: createContainerId "unitInfoWrapper"
        , pos: vec 500 200
        , size: size 0 0
        , onClick: []
        , onCreate: []
        , children:
            [ unitInfo "id1" "id1"
            ]
        }
    ]
      <> renderList charaIndex
