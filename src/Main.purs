module Main where

import Prelude

import Effect (Effect)
import Graphics.Phaser as Phaser
import Phaser.Graphics.ForeignTypes (PhaserGame)
import Screen.Main (mainScreen)

main :: Effect Unit
main = void do runGame { width: 1024, height: 768 }

runGame :: { height :: Int , width :: Int } -> Effect PhaserGame
runGame = Phaser.create >=> Phaser.addScene mainScreen true

