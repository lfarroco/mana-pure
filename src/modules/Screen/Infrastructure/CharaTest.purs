module Screen.Infrastructure.CharaTest where

import Prelude

import Core.Models (size, vec)
import Data.Array (mapMaybe)
import Data.Int (toNumber)
import Data.Maybe (Maybe(..))
import Game.Domain.Element (Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))


charaTest :: forall a. Element a
charaTest =
  Container
    { id: createContainerId "charaTest"
    , pos: vec 100 100
    , size: size 0 0
    , onClick: []
    , onCreate: []
    , children:
        [ Rect { pos: vec 0 0, size: size 200 400, color: "0xeaeaea" }
        , chara "1"
        ]
    }

-- export const SKIN_COLOR_LIGHT = 0xecccab;
-- export const SKIN_COLOR_LIGHT_MED = 0xd2996c;
-- export const SKIN_COLOR_MED = 0xc37c4d;
-- export const SKIN_COLOR_DARK_MED = 0xb66b3e;
-- export const SKIN_COLOR_BLACK  = 0x8e4b33;
chara :: forall a. String -> Element a
chara id =
  let
    skinColor = "0xecccab"

    hairColor = "0x88aa8e"

    images =
      [ { id: "lhand/" <> id, texture: "chara/hand", pos: vec 125 130, target: Just $ vec 125 120, duration: 1000, tint: Just skinColor }
      , { id: "lfoot/" <> id, texture: "chara/foot", pos: vec 120 172, target: Nothing, duration: 0, tint: Nothing }
      , { id: "rfoot/" <> id, texture: "chara/foot", pos: vec 90 180, target: Nothing, duration: 0, tint: Nothing }
      , { id: "trunk/" <> id, texture: "chara/trunk_fighter", pos: vec 100 140, target: Just $ vec 100 137, duration: 1000, tint: Nothing }
      , { id: "head/" <> id, texture: "chara/head_male", pos: vec 100 70, target: Just $ vec 100 67, duration: 1000, tint: Just skinColor }
      , { id: "rhand/" <> id, texture: "chara/hand", pos: vec 80 140, target: Just $ vec 80 135, duration: 1000, tint: Just skinColor }
      , { id: "hair/" <> id, texture: "chara/hair/male1", pos: vec 100 70, target: Just $ vec 100 67, duration: 1000, tint: Just hairColor }
      , { id: "requip/" <> id, texture: "equips/iron_sword", pos: vec 80 140, target: Just $ vec 80 135, duration: 1000, tint: Nothing }
      , { id: "lequip/" <> id, texture: "equips/iron_shield", pos: vec 125 130, target: Just $ vec 125 120, duration: 1000, tint: Nothing }
      ]

    standAnimation =
      mapMaybe
        ( \{ id: id_, target, duration } -> case target of
            Just t -> Just $ TweenImage id_ t (toNumber duration)
            Nothing -> Nothing
        )
        images
  in
    Container
      { id: createContainerId $ "chara_" <> id
      , pos: vec 0 0
      , size: size 200 400
      , onClick: []
      , onCreate: standAnimation
      , children:
          map
            ( \{ id: id_, pos, texture, tint } ->
                Image { id: id_, pos, texture, tint }
            )
            images
      }
