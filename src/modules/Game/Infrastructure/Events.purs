module Game.Infrastructure.Events where

import Prelude
import Core.Models (Vector)
import Data.Map (insert, lookup)
import Data.Maybe (Maybe(..))
import Effect.Ref (modify_, read)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Models (EventRunner)
import Graphics.Phaser (addTilesetImage, addTween, createLayer, destroy, imageOnPointerUp, makeTileMap, onUpdate, removeChildren, removeOnUpdate, setImagePosition)
import Math (pow)
import Screen.Infrastructure.Screens (screenIndex)

runEvent :: EventRunner PhaserState
runEvent renderer stateRef event = do
  state <- read stateRef
  case event of
    NoOp -> pure unit
    Destroy id -> do
      case lookup id state.containerIndex of
        Just s -> destroy s
        Nothing -> pure unit
    RenderScreen id -> do
      case lookup id (screenIndex state) of
        Just screen -> do
          _ <- renderer stateRef screen Nothing
          pure unit
        Nothing -> do
          pure unit
    RemoveChildren id -> do
      case lookup id state.containerIndex of
        Just cont -> removeChildren cont
        Nothing -> do pure unit
    RenderComponent parentId elem -> do
      case lookup parentId state.containerIndex of
        Just parent -> do
          _ <- renderer stateRef elem (Just parent)
          pure unit
        Nothing -> do pure unit
    TweenImage id to duration -> do
      case lookup id state.imageIndex of
        Just img -> do
          _ <-
            addTween
              { scene: state.scene
              , targets: img
              , props: to
              , delay: 0
              , duration: duration
              , ease: "Cubic"
              , repeat: 0
              , yoyo: false
              }
          pure unit
        Nothing -> pure unit
    OnUpdate callback -> do
      onUpdate { callback: callback stateRef, scene: state.scene }
    RemoveOnUpdate -> do
      removeOnUpdate state.scene
    MoveImage id vec -> do
      case lookup id state.imageIndex of
        Just img -> do setImagePosition vec img
        Nothing -> pure unit
    CreateTileMap -> do
      tileMap <-
        makeTileMap
          { scene: state.scene
          , data:
              [ [ 58, 58, 58, 41, 41 ]
              , [ 58, 58, 41, 41, 41 ]
              , [ 58, 58, 41, 41, 41 ]
              , [ 58, 58, 41, 41, 41 ]
              , [ 58, 58, 58, 58, 58 ]
              ]
          , tileWidth: 64
          , tileHeight: 64
          }
      tileset <- addTilesetImage { tileMap, key: "tilemaps/kenney_64x64", tileWidth: 64, tileHeight: 64 }
      layer <- createLayer { tileMap, tileset }
      pure unit
    SelectSquad mSquadId -> do
      modify_ (\s -> s { selectedSquad = mSquadId }) stateRef
    SetSquadAction squadId mvector -> do
      case lookup squadId state.characters of
        Nothing -> pure unit
        Just squad ->
          let
            updatedSquad = squad { action = mvector }
          in
            modify_ (\s -> s { characters = insert squadId updatedSquad s.characters }) stateRef
    OnImageClick id callback -> do
      case lookup id state.imageIndex of
        Nothing -> do
          pure unit
        Just img -> do
          imageOnPointerUp img
            ( \xy ->
                let
                  event_ = callback stateRef id
                in
                  runEvent renderer stateRef event_
            )
    MapClick vector -> do
      st <- read stateRef
      case st.selectedSquad of
        Just id_ ->
          let
            event_ = SetSquadAction id_ (Just vector)
          in
            runEvent renderer stateRef event_
        Nothing -> pure unit

distance :: Vector -> Vector -> Number
distance from to = pow (from.x - to.x) 2.0 + pow (from.y + to.y) 2.0
