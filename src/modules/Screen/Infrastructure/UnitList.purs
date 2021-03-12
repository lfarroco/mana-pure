module Screen.Infrastructure.UnitList where

import Prelude
import Character.Application (CharacterIndex)
import Core.Models (size, vec, Vector)
import Data.Array (fromFoldable)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map (values)
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import UI.Button (button)

renderList :: forall state. CharacterIndex -> Array (Element state)
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
              [ \st ve -> RemoveChildren $ createContainerId "unitInfoWrapper"
              , \st ve -> RenderComponent (createContainerId "unitInfoWrapper") (unitInfo v.id v.name)
              ]
        )
    # fromFoldable

unitInfo :: forall st. String -> String -> Element st
unitInfo id name =
  Text
    { pos: vec 0 0
    , text: id <> " // " <> name
    }

unitListScreen :: forall state. CharacterIndex -> Element state
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
        $ [ \st _ -> Destroy $ createContainerId "unitListScreen"
          , \st _ -> RenderScreen "mainScreen" $ createContainerId "__root"
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
