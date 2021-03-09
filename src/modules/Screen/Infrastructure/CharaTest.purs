module Screen.Infrastructure.CharaTest where

import Prelude
import Core.Models (size, vec)
import Data.Array (mapMaybe)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))

charaTest :: Element
charaTest =
  Container
    { id: createContainerId "charaTest"
    , pos: vec 0 0
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Rect { pos: vec 100 100, size: size 200 400, color: "0xeaeaea" }
        , chara "1"
        ]
    }

chara :: String -> Element
chara id =
  let
    images =
      [ { id: "chara/lhand/" <> id, texture: "chara/hand", pos: vec 125 130, target: Just $ vec 125 120, duration: 500 }
      , { id: "chara/lfoot/" <> id, texture: "chara/foot", pos: vec 120 172, target: Nothing, duration: 0 }
      , { id: "chara/rfoot/" <> id, texture: "chara/foot", pos: vec 90 180, target: Nothing, duration: 0 }
      , { id: "chara/trunk/" <> id, texture: "chara/trunk_fighter", pos: vec 100 140, target: Just $ vec 100 137, duration: 500 }
      , { id: "chara/head/" <> id, texture: "chara/head_male", pos: vec 100 70, target: Just $ vec 100 67, duration: 500 }
      , { id: "chara/rhand/" <> id, texture: "chara/hand", pos: vec 80 140, target: Just $ vec 80 135, duration: 500 }
      ]

    standAnimation =
      mapMaybe
        ( \{ id, target, duration } -> case target of
            Just t -> Just $ TweenImage id t duration
            Nothing -> Nothing
        )
        images
  in
    Container
      { id: createContainerId $ "chara_" <> id
      , pos: vec 100 100
      , size: size 200 400
      , onClick: []
      , onCreate: standAnimation
      , children:
          map
            ( \{ id, pos, texture } ->
                Image { id, pos, texture }
            )
            images
      }
