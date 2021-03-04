module Graphics.Phaser where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
  
foreign import data PhaserGame :: Type

foreign import data PhaserScene :: Type

foreign import data PhaserContainer :: Type

foreign import data PhaserImage :: Type

foreign import data PhaserText :: Type

foreign import newGame ::  Int -> Int -> Effect PhaserGame

foreign import createScene_ :: PhaserGame -> String -> EffectFnAff PhaserScene

createScene :: PhaserGame -> String -> Aff PhaserScene
createScene a = fromEffectFnAff <<< createScene_ a

foreign import addContainer :: PhaserScene -> Int -> Int -> Effect PhaserContainer

foreign import addImage :: PhaserScene -> Int -> Int -> String -> Effect PhaserImage

foreign import setImageDisplaySize :: PhaserImage -> Int -> Int -> Effect PhaserImage

foreign import setImageOrigin :: PhaserImage -> Int -> Int ->Effect PhaserImage

foreign import addTween :: PhaserScene -> PhaserImage -> Int-> Int-> Int -> Int -> String-> Int -> Boolean ->Effect PhaserImage

foreign import delay_:: PhaserScene -> Int -> EffectFnAff Unit

foreign import text:: { 
    scene:: PhaserScene,
    x:: Int, 
    y:: Int,
    text:: String,
    config:: { color:: String, fontSize:: Int, fontFamily:: String }
    } -> Effect PhaserText

delay :: PhaserScene -> Int -> Aff Unit
delay a = fromEffectFnAff <<< delay_ a