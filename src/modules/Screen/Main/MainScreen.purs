module Screen.Main (mainScreen) where

import Prelude
import Assets.Images as Images
import Core.Models (size, vec)
import Data.Map as Map
import Effect (Effect)
import Graphics.Phaser.GameObject as GO
import Graphics.Phaser.Image as Image
import Graphics.Phaser.Loader (loadImages)
import Graphics.Phaser.Scene (SceneConfig, launchByKey, startByKey)
import Phaser.Graphics.ForeignTypes (PhaserImage, PhaserScene)
import Screen.SquadList as SquadList
import Screen.Theater as Theater
import Screen.UnitList as UnitList
import UI.Button (button)

key :: String
key = "main"

data MainScreenEvents
  = NoOp
  | GoToUnitList

type Model
  = {}

initialModel :: Model
initialModel = {}

preload :: PhaserScene -> Effect Unit
preload =
  loadImages
    $ ( map (\k -> { key: k, path: "assets/" <> k <> ".svg" })
          [ "chara/head_male"
          , "chara/head_female"
          , "chara/trunk_fighter"
          , "chara/hand"
          , "chara/foot"
          , "chara/hair/male1"
          , "equips/iron_sword"
          , "equips/iron_helm"
          , "equips/iron_spear"
          , "equips/iron_shield"
          , "ui/button"
          , "backgrounds/sunset"
          ]
      )

init :: forall t35. PhaserScene -> t35 -> Effect Unit
init scene _ = launchByKey "aa" {} scene

update :: forall t6 t7. Applicative t7 => t6 -> t7 Unit
update _ = pure unit

bg :: PhaserScene -> Effect PhaserImage
bg =
  Image.create Images.backgrounds.sunset.key (vec 0 0)
    >=> GO.setOrigin (vec 0 0)
    >=> GO.setDisplaySize (size 800 600)

create :: PhaserScene -> Model -> Effect Unit
create scene model =
  void do
    _ <- bg scene
    button { x: 20, y: 50 } "Unit List" (\_ -> startUnitListScene scene) scene
    button { x: 20, y: 100 } "Squad List" (\_ -> startSquadListScene scene) scene
    button { x: 20, y: 150 } "Theater" (\_ -> Theater.start scene) scene

startUnitListScene :: PhaserScene -> Effect Unit
startUnitListScene scn = do
  startByKey UnitList.key { heroes: [ { id: "1", name: "Khastan" }, { id: "2", name: "Derpino" }, { id: "3", name: "Herp" } ] } scn

startSquadListScene :: PhaserScene -> Effect Unit
startSquadListScene scn = do
  startByKey SquadList.key { mainSceneKey: key, squads: [ { id: "1", leader: "Khastan" }, { id: "2", leader: "Derpino" }, { id: "3", leader: "Herp" } ] } scn

mainScreen :: SceneConfig {}
mainScreen =
  { key
  , preload
  , init
  , create
  , update
  , state: initialModel
  }
