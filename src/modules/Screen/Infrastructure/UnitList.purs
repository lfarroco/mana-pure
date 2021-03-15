module Screen.Infrastructure.UnitList where

import Prelude
import Character.Domain as Character
import Character.Infrastructure (characterIndex)
import Core.Models (size, vec)
import Data.Array (fromFoldable)
import Data.FunctorWithIndex (mapWithIndex)
import Data.Map (values)
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import UI.Button (button)

renderList :: PhaserState -> Array (Element PhaserState)
renderList state =
  let
      name (Character.Name n) = n
  in
  characterIndex
    # values
    # mapWithIndex
        ( \i v ->
            button
              ("unitList_id" <> (show $ i + 1))
              (name v.name)
              (vec 300 (100 + (i * 60)))
              (size 200 50)
              [ \st ve -> RemoveChildren $ createContainerId "unitInfoWrapper"
              , \st ve ->
                  RenderComponent
                    (createContainerId "unitInfoWrapper")
                    (unitInfo v.id v.name)
              ]
        )
    # fromFoldable

unitInfo :: Character.Id -> Character.Name -> Element PhaserState
unitInfo (Character.Id cid) (Character.Name name) =
  Text
    { pos: vec 0 0
    , text: cid <> " // " <> name
    }

unitListScreen :: PhaserState -> Element PhaserState
unitListScreen state =
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
          , \st _ -> RenderScreen "mainScreen"
          ]
    , Container
        { id: createContainerId "unitInfoWrapper"
        , pos: vec 500 200
        , size: size 0 0
        , onClick: []
        , onCreate: []
        , children:
            [ unitInfo (Character.Id "id1") (Character.Name "id1")
            ]
        }
    ]
      <> renderList state
