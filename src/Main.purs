module Main where

import Prelude
import Effect (Effect)
import Graphics.Phaser as Phaser
import Graphics.Phaser.Scene as Scene
import Screen.Main (mainScreen)

main = runGame { width: 1024, height: 768 }

runGame = Phaser.create >=> Phaser.addScene mainScreen true

--mapState <- new $ vec 100 100
-- root <- createRootContainer scene
-- state <- (new $ initilState game scene root) # liftEffect
-- runEvent render state initialEvent # liftEffect
-- where
-- initialEvent = RenderScreen "mainScreen"
--   createRootContainer scene = addContainer scene (vec 0 0) # liftEffect
-- initilState :: PhaserGame -> PhaserScene -> PhaserContainer -> PhaserState
-- initilState game scene root =
--   { game
--   , scene
--   , root
--   , containerIndex:
--       empty
--         # insert (createContainerId "__root") root
--   , imageIndex: empty
--   , characters:
--       empty
--         # insert "id1" ({ pos: vec 100 100, id: "id1", action: Nothing })
--         # insert "id2" ({ pos: vec 400 100, id: "id2", action: Nothing })
--   , selectedSquad: Nothing
--   }
