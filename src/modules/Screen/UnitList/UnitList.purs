module Screen.UnitList where

import Prelude
import Data.Array (head, tail)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser.Loader (loadImages)
import Graphics.Phaser.Scene (SceneConfig, startByKey)
import Phaser.Graphics.ForeignTypes (PhaserScene, PhaserText)
import UI.Button (button)
import UI.Text (customText)

key :: String
key = "UnitListScreen"

data MainScreenEvents
  = NoOp
  | GoToUnitList

type Model
  = { heroes :: Array { id :: String, name :: String }
    }

state :: Model
state = { heroes: [] }

preload :: PhaserScene -> Effect Unit
preload =
  loadImages
    [ { key: "ui/button", path: "assets/ui/button.png" }
    ]

init :: forall t12 t13 t14. Applicative t14 => t12 -> t13 -> t14 Unit
init _ _ = pure unit

update :: forall t6 t7. Applicative t7 => t6 -> t7 Unit
update _ = pure unit

row :: String -> Number -> PhaserScene -> Effect PhaserText
row text_ n = customText (\cfg -> cfg { color = "#fff" }) { x: 0.0, y: (100.0 + n * 40.0) } text_

create :: PhaserScene -> Model -> Effect Unit
create scn model =
  let
    render hs n = case head hs of
      Just hero ->
        void do
          _ <- row hero.name n scn
          case (tail hs) of
            Just t -> render t (n + 1.0)
            Nothing -> pure unit
      _ -> do pure unit
  in
    void do
      render model.heroes 0.0
      button { x: 700, y: 400 } "Return" (\_ -> startByKey "main" {} scn) scn

scene :: SceneConfig Model
scene =
  { key
  , preload
  , init
  , create
  , update
  , state
  }
