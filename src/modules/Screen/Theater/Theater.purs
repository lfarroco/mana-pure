module Screen.Theater where

import Prelude
import Assets.Images as Images
import Core.Models (BoardSquare, size, vec)
import Data.Foldable (for_)
import Data.Map (Map)
import Data.Map as Map
import Effect (Effect)
import Graphics.Phaser.GameObject as GO
import Graphics.Phaser.Image as Image
import Graphics.Phaser.Loader (loadImages)
import Graphics.Phaser.Scene (SceneConfig, startByKey)
import Hero.API (createHero)
import Hero.Animation (render)
import Hero.Model (Hero)
import Phaser.Graphics.ForeignTypes (PhaserScene, PhaserText, PhaserImage)
import Screen.Theater.Isometric (cartesianToIsometric)
import UI.Button (button)
import UI.Text (customText)
import Config as Config

key :: String
key = "TheaterScreen"

data Events
  = NoOp

type Model
  = { heroes :: Map String { hero :: Hero, pos :: BoardSquare, front :: Boolean }
    , background :: String
    }

preload :: PhaserScene -> Effect Unit
preload = loadImages []

init :: forall t12 t13 t14. Applicative t14 => t12 -> t13 -> t14 Unit
init _ _ = pure unit

update :: forall t6 t7. Applicative t7 => t6 -> t7 Unit
update _ = pure unit

row :: String -> Number -> PhaserScene -> Effect PhaserText
row text_ n = customText (\cfg -> cfg { color = "#fff" }) { x: 0.0, y: (100.0 + n * 40.0) } text_

background :: String -> PhaserScene -> Effect PhaserImage
background bgKey =
  Image.create bgKey (vec 0 0)
    >=> GO.setOrigin (vec 0 0)
    >=> GO.setDisplaySize (Config.screenSize)

create :: PhaserScene -> Model -> Effect Unit
create scn model =
  void do
    _ <- background model.background scn
    for_ model.heroes (\{ hero, pos, front } -> renderHero hero pos front scn)

-- button { x: 700, y: 500 } "Return" (\_ -> startByKey "main" {} scn) scn
renderHero :: Hero -> BoardSquare -> Boolean -> PhaserScene -> Effect Unit
renderHero hero pos front scene_ =
  let
    origin = if front then vec 200 0 else vec 520 380
  in
    void do
      render hero.id (cartesianToIsometric origin pos) ({ x: 0.5, y: 0.5 }) front scene_

scene :: SceneConfig Model
scene =
  { key
  , preload
  , init
  , create
  , update
  , state
  }

safeStart :: Model -> PhaserScene -> Effect Unit
safeStart model scn = startByKey key model scn

start :: PhaserScene -> Effect Unit
start scn = do
  safeStart state scn

state :: Model
state =
  { background: Images.backgrounds.plain.key
  , heroes:
      Map.empty
        # Map.insert "a" { hero: createHero "a", pos: { x: 1, y: 1 }, front: true }
        # Map.insert "b" { hero: createHero "b", pos: { x: 1, y: 2 }, front: true }
        # Map.insert "c" { hero: createHero "c", pos: { x: 1, y: 3 }, front: true }
        # Map.insert "d" { hero: createHero "d", pos: { x: 2, y: 1 }, front: true }
        # Map.insert "e" { hero: createHero "e", pos: { x: 2, y: 2 }, front: true }
        # Map.insert "f" { hero: createHero "f", pos: { x: 2, y: 3 }, front: true }
        # Map.insert "g" { hero: createHero "g", pos: { x: 3, y: 1 }, front: true }
        # Map.insert "h" { hero: createHero "h", pos: { x: 3, y: 2 }, front: true }
        # Map.insert "i" { hero: createHero "i", pos: { x: 3, y: 3 }, front: true }
        # Map.insert "j" { hero: createHero "j", pos: { x: 1, y: 1 }, front: false }
        # Map.insert "k" { hero: createHero "k", pos: { x: 1, y: 2 }, front: false }
        # Map.insert "l" { hero: createHero "l", pos: { x: 1, y: 3 }, front: false }
        # Map.insert "m" { hero: createHero "m", pos: { x: 2, y: 1 }, front: false }
        # Map.insert "n" { hero: createHero "n", pos: { x: 2, y: 2 }, front: false }
        # Map.insert "o" { hero: createHero "o", pos: { x: 2, y: 3 }, front: false }
        # Map.insert "p" { hero: createHero "p", pos: { x: 3, y: 1 }, front: false }
        # Map.insert "q" { hero: createHero "q", pos: { x: 3, y: 2 }, front: false }
        # Map.insert "r" { hero: createHero "r", pos: { x: 3, y: 3 }, front: false }
  }
