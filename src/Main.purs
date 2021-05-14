module Main where

import Prelude

import Effect (Effect)
import Graphics.Phaser as Phaser
import Phaser.Graphics.ForeignTypes (PhaserGame)
import Screen.UnitList as UnitList 
import Screen.SquadList as SquadList 
import Screen.Theater as Theater 
import Screen.Main (mainScreen)

main :: Effect Unit
main = void do runGame { width: 1920, height: 1080 }

runGame :: { height :: Int, width :: Int } -> Effect PhaserGame
runGame =
  Phaser.create
    >=> Phaser.addScene mainScreen true
    >=> Phaser.addScene UnitList.scene false
    >=> Phaser.addScene SquadList.scene false
    >=> Phaser.addScene Theater.scene false
