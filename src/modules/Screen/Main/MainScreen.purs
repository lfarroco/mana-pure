module Screen.Main where

import Prelude

import Core.Models (size, vec)
import Effect (Effect)
import Effect.Class.Console (log)
import Graphics.Phaser.GameObject (onClick, setDisplaySize, setPosition)
import Graphics.Phaser.Image as Image
import Graphics.Phaser.Loader (loadImages)
import Graphics.Phaser.Scene (SceneConfig)
import Graphics.Phaser.Text as Text
import Phaser.Graphics.ForeignTypes (PhaserScene)

data MainScreenEvents
  = NoOp
  | GoToUnitList

noop :: forall t2 t3. Applicative t3 => t2 -> t3 Unit
noop scene = pure unit

mainScreen :: SceneConfig {}
mainScreen =
    { key: "main"
    , preload: \scene -> loadImages [ { key: "button", path: "assets/ui/button.png" } ] scene
    , init: \scene data_ -> log "init"
    , create
    , update: noop
    , state: {}
    }

create :: forall a. PhaserScene -> a -> Effect Unit
create scene data_ =
    let
        btn = 
          Image.create "button" (vec 200 200) >=>
          setDisplaySize (size 200 100) >=>
          onClick
             \pointer localClick ev img -> void do
                setPosition (vec 300 100) img
            
    in
      void do
        _ <- btn scene
        Text.text
            { scene
            , config:
                { color:
                    "#ffffff"
                , fontFamily: "cursive"
                , fontSize: 18
                }
            , pos: vec 210 210
            , text: "Unit List"
            }

-- button scene = do
--   image <- addImage "ui/button" (vec 100 100) scene
