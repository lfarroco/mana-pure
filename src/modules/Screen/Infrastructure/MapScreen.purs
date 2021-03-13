module Screen.Infrastructure.MapScreen where

import Prelude

import Character.Domain (Character)
import Character.Infrastructure (characterIndex)
import Core.Models (Vector, size, vec)
import Data.Foldable (foldl, for_)
import Data.Map (Map, lookup)
import Data.Maybe (Maybe(..))
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify, modify_, read)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (setImagePosition)
import Prelude (map, pure, unit, (*), (<>))

mapScreenId :: ContainerId
mapScreenId = createContainerId "mapScreen"

mapScreen :: Ref PhaserState -> (Element PhaserState)
mapScreen state =
  Container
    { id: mapScreenId
    , pos: vec 0 0
    , size: size 800 600
    , onClick:
        [ \st vector ->
            TweenImage "chara" vector 1000.0
        ]
    , onCreate:
        [ OnUpdate \st time delta -> do
            for_ positions \c -> case lookup ("chara_id" <> c.character.id) st.imageIndex of
              Just img -> do
                n <- read state
                log $ show n.battleField
                setImagePosition { x: 100.0 + n.battleField, y: 200.0 } img
                modify_ (\s -> s { battleField = s.battleField + 1.0 }) state
              Nothing -> do pure unit
        ]
    , children:
        -- [ Text { pos: vec 200 200, text: "brrrrrrrrr" }
        -- , Image { id: "chara_id1", pos: vec 100 100, texture: "chara/head_male", tint: Nothing }
        -- ]
        foldl (\xs c -> xs <> [ Image { id: "chara_id" <> c.character.id, pos: c.pos, texture: "chara/head_male", tint: Nothing } ]) [] positions
    }

positions :: Map String { character :: Character, pos :: Vector }
positions = map (\character -> { character, pos: vec (character.age * 100) 100 }) characterIndex
