module Screen.SquadList where

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
key = "SquadListScreen"

data Events
  = NoOp

type Model
  = { mainSceneKey :: String
    , squads :: Array { id :: String, leader :: String }
    }

state :: Model
state =
  { mainSceneKey: "main"
  , squads: [ { leader: "Khastan", id: "1" }, { leader: "Derpino", id: "2" } ]
  }

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
      Just squad ->
        void do
          _ <- row squad.leader n scn
          case (tail hs) of
            Just t -> render t (n + 1.0)
            Nothing -> pure unit
      _ -> do pure unit
  in
    void do
      render model.squads 0.0
      button { x: 700, y: 400 } "Return" (\_ -> startByKey model.mainSceneKey {} scn) scn

scene :: SceneConfig Model
scene =
  { key
  , preload
  , init
  , create
  , update
  , state
  }
