module Screen.Infrastructure.MapScreen where

import Prelude
import Character.Domain (Character)
import Core.Models (Vector, IndexOf, size, vec)
import Data.Foldable (foldl, for_)
import Data.Map (insert, lookup)
import Data.Maybe (Maybe(..))
import Effect.Ref (modify_, read)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (setImagePosition)

mapScreenId :: ContainerId
mapScreenId = createContainerId "mapScreen"

mapScreen :: PhaserState -> (Element PhaserState)
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
        [OnUpdate \st time delta -> do
            st_ <- read st
            for_ st_.characters \c -> case lookup c.id st_.imageIndex of
              Just img -> do
                -- how about mutating everything in a single modify_?
                modify_
                  ( \s ->
                      s
                        { characters =
                          insert
                            (c.id)
                            (c { pos = { x: c.pos.x + 1.0, y: c.pos.y } }) -- TODO: for each character, get vector (then modify all at once)
                            s.characters
                        }
                  )
                  st
                setImagePosition c.pos img
              Nothing -> do
                pure unit
        ]
    , children:
        foldl
          ( \xs c ->
              xs
                <> [ Image { id: c.id, pos: c.pos, texture: "chara/head_male", tint: Nothing }
                  ]
          )
          []
          state.characters
    }

positions :: IndexOf Character -> IndexOf { character :: Character, pos :: Vector }
positions charas = map (\character -> { character, pos: vec (character.age * 100) 100 }) charas
