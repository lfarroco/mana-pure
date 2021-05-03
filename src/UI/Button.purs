module UI.Button (button) where

import Prelude
import Core.Models (vec)
import Data.Int (toNumber)
import Effect (Effect)
import Graphics.Phaser.Container as Container
import Graphics.Phaser.GameObject as GO
import Graphics.Phaser.Image as Image
import Phaser.Graphics.ForeignTypes (PhaserContainer, PhaserScene)
import UI.Text (customText)

padding :: Int
padding = 10

paddingH :: Number
paddingH = (toNumber $ padding * 2)

paddingV :: Number
paddingV = (toNumber $ padding * 2)

button :: { x :: Int, y :: Int } -> String -> (PhaserContainer -> Effect Unit) -> PhaserScene -> Effect Unit
button { x, y } text handler scene =
  let
    createContainer = Container.create (vec x y)

    createBg size' parent =
      Image.create "ui/button" (vec 0 0)
        >=> GO.setDisplaySize size'
        >=> GO.setOrigin (vec 0 0)
        >=> GO.onClick \_ _ _ _ -> handler parent

    createText = do
      txt <- customText (\cfg -> cfg { color = "#fff" }) (vec padding padding) text scene
      GO.setOrigin (vec 0 0) txt
  in
    void do
      container <- createContainer scene
      text' <- createText
      { width, height } <- GO.getDisplaySize text'
      buttonBg <- createBg { width: width + paddingH, height: height + paddingV } container scene
      _ <- Container.addChild buttonBg container
      Container.addChild text' container
