module Hero.Animation where

import Prelude
import Core.Models (Vector, vec)
import Data.Foldable (class Foldable, for_)
import Data.Int (toNumber)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser.Container as Container
import Graphics.Phaser.GameObject (getScene, setScale, setTint)
import Graphics.Phaser.Image as Image
import Graphics.Phaser.Scene (getData, setData)
import Graphics.Phaser.Tween (TweenProperty(..), addTween)
import Phaser.Graphics.ForeignTypes (PhaserContainer, PhaserImage, PhaserScene)

skinColor :: String
skinColor = "0xecccab"

hairColor :: String
hairColor = "0x88aa8e"

images ::
  String ->
  Boolean ->
  Array
    { id :: String
    , pos :: Vector
    , texture :: String
    , tint :: Maybe String
    , scale :: Maybe Vector
    }
images id front =
  if front then
    [ { id: "lhand/" <> id, texture: "chara/hand", pos: vec 125 130, tint: Just skinColor, scale: Nothing }
    , { id: "lfoot/" <> id, texture: "chara/foot", pos: vec 120 172, tint: Nothing, scale: Nothing }
    , { id: "rfoot/" <> id, texture: "chara/foot", pos: vec 90 180, tint: Nothing, scale: Nothing }
    , { id: "trunk/" <> id, texture: "chara/trunk_fighter", pos: vec 100 140, tint: Nothing, scale: Nothing }
    , { id: "head/" <> id, texture: "chara/head_male", pos: vec 100 70, tint: Just skinColor, scale: Nothing }
    , { id: "hair/" <> id, texture: "chara/hair/male1", pos: vec 100 70, tint: Nothing, scale: Nothing }
    , { id: "lequip/" <> id, texture: "equips/iron_shield", pos: vec 125 130, tint: Nothing, scale: Nothing }
    , { id: "rhand/" <> id, texture: "chara/hand", pos: vec 80 140, tint: Just skinColor, scale: Nothing }
    , { id: "requip/" <> id, texture: "equips/iron_sword", pos: vec 80 140, tint: Nothing, scale: Nothing }
    ]
  else
    [ { id: "lfoot/" <> id, texture: "chara/foot", pos: vec 120 172, tint: Nothing, scale: Nothing }
    , { id: "rfoot/" <> id, texture: "chara/foot", pos: vec 90 180, tint: Nothing, scale: Nothing }
    , { id: "lequip/" <> id, texture: "equips/iron_shield", pos: vec 45 120, tint: Nothing, scale: Nothing }
    , { id: "lhand/" <> id, texture: "chara/hand", pos: vec 60 125, tint: Just skinColor, scale: Nothing }
    , { id: "rhand/" <> id, texture: "chara/hand", pos: vec 120 130, tint: Just skinColor, scale: Nothing }
    , { id: "requip/" <> id, texture: "equips/iron_sword", pos: vec 135 125, tint: Nothing, scale: Just { x: -1.0, y: 1.0 } }
    , { id: "trunk/" <> id, texture: "chara/trunk_fighter_back", pos: vec 100 140, tint: Nothing, scale: Nothing }
    , { id: "head/" <> id, texture: "chara/head_back", pos: vec 105 80, tint: Just skinColor, scale: Nothing }
    , { id: "hair/" <> id, texture: "chara/hair/male1_back", pos: vec 105 70, tint: Nothing, scale: Nothing }
    ]




data Animation
  = Stand
  | Slash

type BodyPart
  = { id :: String, duration :: Int, prop :: TweenProperty }

-- TODO: sum vectors to get target movement
stand :: String -> Boolean -> Array BodyPart
stand id front =
  if front then
    [ { id: "lhand/" <> id, prop: TweenVector $ vec 125 120, duration: 1000 }
    , { id: "trunk/" <> id, prop: TweenVector $ vec 100 135, duration: 1000 }
    , { id: "head/" <> id, prop: TweenVector $ vec 100 65, duration: 1000 }
    , { id: "hair/" <> id, prop: TweenVector $ vec 100 65, duration: 1000 }
    , { id: "rhand/" <> id, prop: TweenVector $ vec 80 135, duration: 1000 }
    , { id: "requip/" <> id, prop: TweenVector $ vec 80 135, duration: 1000 }
    , { id: "lequip/" <> id, prop: TweenVector $ vec 125 120, duration: 1000 }
    ]
  else
    [ { id: "trunk/" <> id, prop: TweenVector $ vec 100 137, duration: 1000 }
    , { id: "head/" <> id, prop: TweenVector $ vec 105 77, duration: 1000 }
    , { id: "hair/" <> id, prop: TweenVector $ vec 107 67, duration: 1000 }
    , { id: "rhand/" <> id, prop: TweenVector $ vec 120 127, duration: 1000 }
    , { id: "requip/" <> id, prop: TweenVector $ vec 135 122, duration: 1000 }
    , { id: "lhand/" <> id, prop: TweenVector $ vec 60 122, duration: 1000 }
    , { id: "lequip/" <> id, prop: TweenVector $ vec 45 117, duration: 1000 }
    ]

slash :: String -> Array { id :: String, duration :: Int, prop :: TweenProperty }
slash id =
  [ { id: "rhand/" <> id, prop: TweenVector $ vec 110 130, duration: 400 }
  , { id: "requip/" <> id, prop: TweenVector $ vec 110 130, duration: 400 }
  , { id: "requip/" <> id, prop: TweenAngle { angle: 140.0 }, duration: 400 }
  , { id: "lequip/" <> id, prop: TweenVector $ vec 120 125, duration: 400 }
  , { id: "lhand/" <> id, prop: TweenVector $ vec 120 125, duration: 400 }
  ]

getSceneImage :: String -> PhaserScene -> Effect PhaserImage
getSceneImage key scene = getData key scene

animate ::
  forall animation rec.
  Foldable animation =>
  animation
    { duration :: Int
    , id :: String
    , prop :: TweenProperty
    | rec
    } ->
  PhaserScene -> Effect Unit
animate animation scene = do
  for_ animation
    ( \v ->
        ( void do
            img <- getSceneImage v.id scene
            ( addTween
                { scene
                , targets: [ img ]
                , prop: v.prop
                , delay: 0
                , duration: toNumber v.duration
                , ease: "Cubic"
                , repeat: -1
                , yoyo: true
                , callback: \_ -> pure unit
                }
            )
        )
    )

renderBodyParts :: String -> Boolean -> PhaserContainer -> Effect Unit
renderBodyParts key front container =
  for_ (images key front)
    ( \{ id, texture, pos, tint, scale } ->
        void do
          scene <- getScene container
          img <- Image.create texture pos scene
          _ <- Container.addChild img container
          setData id img scene
          case tint of
            Just t -> void do setTint t img
            Nothing -> void do pure unit
          case scale of
            Just s -> void do setScale s img
            Nothing -> void do pure unit
    )

render :: String -> Vector -> Vector -> Boolean -> PhaserScene -> Effect PhaserContainer
render key pos scale front scene = do
  container <- Container.create pos scene
  _ <- setScale scale container
  renderBodyParts key front container
  animate (stand key front) scene
  setData ("root_" <> key) container scene -- stored ref to container to allow moving hero
  pure container
