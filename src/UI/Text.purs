module UI.Text where

import Effect (Effect)
import Graphics.Phaser.Text as Text
import Phaser.Graphics.ForeignTypes (PhaserScene, PhaserText)

defaultConfig ::
  { color :: String
  , fontFamily :: String
  , fontSize :: Int
  }
defaultConfig = { color: "#000", fontFamily: "sans-serif", fontSize: 18 }

text :: { x :: Number, y :: Number } -> String -> PhaserScene -> Effect PhaserText
text pos text_ = Text.create { config: defaultConfig, pos, text: text_ }

customText ::
  ( { color :: String
    , fontFamily :: String
    , fontSize :: Int
    } ->
    { color :: String
    , fontFamily :: String
    , fontSize :: Int
    }
  ) ->
  { x :: Number
  , y :: Number
  } ->
  String -> PhaserScene -> Effect PhaserText
customText fn pos text_ = Text.create { config: (fn defaultConfig), pos, text: text_ }
