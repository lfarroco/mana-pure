module Screen.Infrastructure.MapScreen where

import Prelude

import Character.Domain (Character)
import Core.Models (IndexOf, Vector, size, vec)
import Data.Foldable (foldl, for_)
import Data.Map (insert, lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Ref (Ref, modify_, read)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (setImagePosition)
import Math (abs)

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
            SetSquadAction "id1" (Just vector)
        ]
    , onCreate:
        [ OnUpdate onUpdateAction
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

onUpdateAction :: Ref PhaserState -> Number -> Number -> Effect Unit
onUpdateAction st time delta = do
  st_ <- read st
  for_ st_.characters \c -> case c.action of
    Nothing -> pure unit
    Just target -> case lookup c.id st_.imageIndex of
      Nothing -> do pure unit
      Just img ->
        let
          step = getStep c.pos target 1.0

          arrived =  abs step.x + abs step.y < 0.98
        in
          do
            -- how about mutating everything in a single modify_?
            modify_
              ( \s ->
                  s
                    { characters =
                      insert
                        (c.id)
                        ( c
                            { pos = sum c.pos step
                            , action =
                              if arrived then
                                Nothing
                              else
                                c.action
                            }
                        ) -- TODO: for each character, get vector (then modify all at once)
                        s.characters
                    }
              )
              st
            setImagePosition c.pos img

getStep :: Vector -> Vector -> Number -> Vector
getStep from to speed =
  let
    x = to.x - from.x

    y = to.y - from.y

    total = abs x + abs y
  in
    if total > speed then
      { x: x / total * speed
      , y: y / total * speed
      }
    else
      { x, y }

sum :: Vector -> Vector -> Vector
sum vec1 vec2 = { x: vec1.x + vec2.x, y: vec1.y + vec2.y }
