module Graphics.Phaser where

import Prelude
import Core.Models (Vector, Size)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Game.Domain.Element (ContainerId, Element)
import Game.Domain.Events (ManaEvent)

foreign import data PhaserGame :: Type

foreign import data PhaserScene :: Type

foreign import data PhaserContainer :: Type

foreign import data PhaserImage :: Type

foreign import data PhaserText :: Type

foreign import data PhaserGraphic :: Type

foreign import data PhaserTileMap :: Type

foreign import data PhaserTileSet :: Type

foreign import data PhaserLayer :: Type

foreign import newGame :: Int -> Int -> Effect PhaserGame

foreign import createScene_ :: { game :: PhaserGame, name :: String, assets :: { png :: Array String, svg :: Array String } } -> EffectFnAff PhaserScene

createScene :: { game :: PhaserGame, name :: String, assets :: { png :: Array String, svg :: Array String } } -> Aff PhaserScene
createScene param = fromEffectFnAff $ createScene_ param

foreign import addContainer :: PhaserScene -> Vector -> Effect PhaserContainer

foreign import setContainerSize :: PhaserContainer -> Size -> Effect PhaserContainer

foreign import addImage :: PhaserScene -> Number -> Number -> String -> Effect PhaserImage

-- TODO: return image returns
foreign import setImageDisplaySize :: PhaserImage -> Int -> Int -> Effect PhaserImage

foreign import setImageOrigin :: PhaserImage -> Int -> Int -> Effect PhaserImage

foreign import setImagePosition :: Vector -> PhaserImage -> Effect Unit

foreign import addTween ::
  forall targets props.
  { scene :: PhaserScene
  , targets :: targets
  , props :: props
  , delay :: Int
  , duration :: Number
  , ease :: String
  , repeat :: Int
  , yoyo :: Boolean
  } ->
  Effect PhaserImage

foreign import delay_ :: PhaserScene -> Int -> EffectFnAff Unit

foreign import destroy :: forall a. a -> Effect Unit

foreign import removeChildren :: PhaserContainer -> Effect Unit

foreign import text ::
  { scene :: PhaserScene
  , pos :: Vector
  , text :: String
  , config :: { color :: String, fontSize :: Int, fontFamily :: String }
  } ->
  Effect PhaserText

delay :: PhaserScene -> Int -> Aff Unit
delay a = fromEffectFnAff <<< delay_ a

foreign import imageOnPointerUp :: PhaserImage -> (Vector -> Effect Unit) -> Effect Unit

foreign import containerOnPointerUp ::
  forall gameState.
  PhaserContainer -> (Vector -> ManaEvent (Element gameState) ContainerId gameState) -> ((ManaEvent (Element gameState) ContainerId gameState) -> Effect Unit) -> Effect Unit

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

foreign import setTint :: { image :: PhaserImage, color :: String } -> Effect Unit

foreign import clearTint :: PhaserImage -> Effect Unit

foreign import onUpdate :: { scene :: PhaserScene, callback :: Number -> Number -> Effect Unit } -> Effect Unit

foreign import removeOnUpdate :: PhaserScene -> Effect Unit

foreign import makeTileMap :: { scene :: PhaserScene, tileWidth :: Int, tileHeight :: Int } -> Effect PhaserTileMap

foreign import addTilesetImage :: { tileMap :: PhaserTileMap, key :: String, tileWidth :: Int, tileHeight :: Int } -> Effect PhaserTileSet

foreign import createLayer :: { tileMap :: PhaserTileMap, tileset:: PhaserTileSet } -> Effect PhaserLayer
