module Graphics.Phaser where

import Prelude
import Core.Models (Vector, Size)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Game.Domain.Events (ManaEvent)

foreign import data PhaserGame :: Type

foreign import data PhaserScene :: Type

foreign import data PhaserContainer :: Type

foreign import data PhaserImage :: Type

foreign import data PhaserText :: Type

foreign import data PhaserGraphic :: Type

foreign import newGame :: Int -> Int -> Effect PhaserGame

foreign import createScene_ :: PhaserGame -> String -> EffectFnAff PhaserScene

createScene :: PhaserGame -> String -> Aff PhaserScene
createScene a = fromEffectFnAff <<< createScene_ a

foreign import addContainer :: PhaserScene -> Vector -> Effect PhaserContainer

foreign import setContainerSize :: PhaserContainer -> Size -> Effect PhaserContainer

foreign import addImage :: PhaserScene -> Int -> Int -> String -> Effect PhaserImage

foreign import setImageDisplaySize :: PhaserImage -> Int -> Int -> Effect PhaserImage

foreign import setImageOrigin :: PhaserImage -> Int -> Int -> Effect PhaserImage

foreign import addTween :: PhaserScene -> PhaserImage -> Int -> Int -> Int -> Int -> String -> Int -> Boolean -> Effect PhaserImage

foreign import delay_ :: PhaserScene -> Int -> EffectFnAff Unit

foreign import destroy :: forall a. a -> Effect Unit

foreign import text ::
  { scene :: PhaserScene
  , pos :: Vector
  , text :: String
  , config :: { color :: String, fontSize :: Int, fontFamily :: String }
  } ->
  Effect PhaserText

delay :: PhaserScene -> Int -> Aff Unit
delay a = fromEffectFnAff <<< delay_ a

-- replace with forall a...
foreign import imageOnPointerUp :: PhaserImage -> (Unit -> Effect Unit) -> Effect Unit

foreign import containerOnPointerUp :: PhaserContainer -> ManaEvent -> (ManaEvent -> Effect Unit) -> Effect Unit

foreign import solidColorRect :: PhaserScene -> Vector -> Size -> String -> Effect PhaserGraphic

foreign import gradientRect ::
  { scene :: PhaserScene
  , pos :: Vector
  , size :: Size
  , colors ::
      { topLeft :: String
      , topRight :: String
      , bottomLeft :: String
      , bottomRight :: String
      }
  } ->
  Effect PhaserGraphic

foreign import addToContainer ::
  forall a.
  { element :: a
  , container :: PhaserContainer
  } ->
  Effect PhaserContainer
