module Screen.Theater where

import Prelude
import Core.Models (BoardSquare, Vector, size, vec)
import Data.Array (head, tail)
import Data.Foldable (for_)
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser.Container as Container
import Graphics.Phaser.Loader (loadImages)
import Graphics.Phaser.Scene (SceneConfig, launchByKey, startByKey)
import Hero.API (createHero)
import Hero.Animation (render)
import Hero.Model (Hero)
import Phaser.Graphics.ForeignTypes (PhaserScene, PhaserText)
import Screen.Theater.Isometric (cartesianToIsometric)
import UI.Button (button)
import UI.Text (customText)

key :: String
key = "TheaterScreen"

data Events
  = NoOp

type Model
  = { heroes :: Map String { hero :: Hero, pos :: BoardSquare }
    }

preload :: PhaserScene -> Effect Unit
preload = loadImages []

init :: forall t12 t13 t14. Applicative t14 => t12 -> t13 -> t14 Unit
init _ _ = pure unit

update :: forall t6 t7. Applicative t7 => t6 -> t7 Unit
update _ = pure unit

row :: String -> Number -> PhaserScene -> Effect PhaserText
row text_ n = customText (\cfg -> cfg { color = "#fff" }) { x: 0.0, y: (100.0 + n * 40.0) } text_

create :: PhaserScene -> Model -> Effect Unit
create scn model =
  void do
    for_ model.heroes (\{ hero, pos } -> renderHero hero pos scn)
    button { x: 700, y: 400 } "Return" (\_ -> startByKey "main" {} scn) scn

renderHero :: Hero -> BoardSquare -> PhaserScene -> Effect Unit
renderHero hero pos scene_ =
  void do
    render hero.id (cartesianToIsometric (vec 200 0) pos) scene_

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
  { heroes:
      Map.empty
        # Map.insert "a" { hero: createHero "a", pos: { x: 1, y: 1 } }
        # Map.insert "b" { hero: createHero "b", pos: { x: 1, y: 2 } }
        # Map.insert "c" { hero: createHero "c", pos: { x: 1, y: 3 } }
        # Map.insert "d" { hero: createHero "d", pos: { x: 2, y: 1 } }
        # Map.insert "e" { hero: createHero "e", pos: { x: 2, y: 2 } }
        # Map.insert "f" { hero: createHero "f", pos: { x: 2, y: 3 } }
        # Map.insert "g" { hero: createHero "g", pos: { x: 3, y: 1 } }
        # Map.insert "h" { hero: createHero "h", pos: { x: 3, y: 2 } }
        # Map.insert "i" { hero: createHero "i", pos: { x: 3, y: 3 } }
  }
