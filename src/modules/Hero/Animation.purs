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
  Array
    { id :: String
    , pos ::
        { x :: Number
        , y :: Number
        }
    , texture :: String
    , tint :: Maybe String
    }
images id =
  [ { id: "lhand/" <> id, texture: "chara/hand", pos: vec 125 130, tint: Just skinColor }
  , { id: "lfoot/" <> id, texture: "chara/foot", pos: vec 120 172, tint: Nothing }
  , { id: "rfoot/" <> id, texture: "chara/foot", pos: vec 90 180, tint: Nothing }
  , { id: "trunk/" <> id, texture: "chara/trunk_fighter", pos: vec 100 140, tint: Nothing }
  , { id: "head/" <> id, texture: "chara/head_male", pos: vec 100 70, tint: Just skinColor }
  , { id: "hair/" <> id, texture: "chara/hair/male1", pos: vec 100 70, tint: Nothing }
  , { id: "lequip/" <> id, texture: "equips/iron_shield", pos: vec 125 130, tint: Nothing }
  , { id: "rhand/" <> id, texture: "chara/hand", pos: vec 80 140, tint: Just skinColor }
  , { id: "requip/" <> id, texture: "equips/iron_sword", pos: vec 80 140, tint: Nothing }
  ]

data Animation
  = Stand
  | Slash

stand :: String -> Array { id :: String, duration :: Int, prop :: TweenProperty }
stand id =
  [ { id: "lhand/" <> id, prop: TweenVector $ vec 125 120, duration: 1000 }
  , { id: "trunk/" <> id, prop: TweenVector $ vec 100 137, duration: 1000 }
  , { id: "head/" <> id, prop: TweenVector $ vec 100 65, duration: 1000 }
  , { id: "hair/" <> id, prop: TweenVector $ vec 100 65, duration: 1000 }
  , { id: "rhand/" <> id, prop: TweenVector $ vec 80 135, duration: 1000 }
  , { id: "requip/" <> id, prop: TweenVector $ vec 80 135, duration: 1000 }
  , { id: "lequip/" <> id, prop: TweenVector $ vec 125 120, duration: 1000 }
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

createImages :: String -> PhaserContainer -> Effect Unit
createImages key container =
  for_ (images key)
    ( \{ id, texture, pos, tint } ->
        void do
          scene <- getScene container
          img <- Image.create texture pos scene
          case tint of
            Just t -> void do setTint t img
            Nothing -> void do pure unit
          _ <- Container.addChild img container
          setData id img scene
    )

render :: String -> Vector -> PhaserScene -> Effect PhaserContainer
render key pos scene = do
  container <- Container.create pos scene
  _ <- setScale { x: 0.5, y: 0.5 } container
  createImages key container
  animate (stand key) scene
  setData ("root_" <> key) container scene
  pure container
