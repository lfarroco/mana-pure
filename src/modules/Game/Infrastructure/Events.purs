module Game.Infrastructure.Events where

import Prelude
import Core.Models (Vector)
import Data.Map (lookup)
import Data.Maybe (Maybe(..))
import Effect.Class.Console (log)
import Effect.Ref (read)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Models (EventRunner)
import Graphics.Phaser (addTween, destroy, onUpdate, removeChildren, removeOnUpdate, setImagePosition)
import Math (pow)
import Screen.Infrastructure.Screens (screenIndex)

runEvent :: EventRunner PhaserState
runEvent renderer stateRef event = do
  state <- read stateRef
  case event of
    Destroy id -> do
      log $ "destroying "
      case lookup id state.containerIndex of
        Just s -> destroy s
        Nothing -> pure unit
    RenderScreen id parentId -> case lookup id (screenIndex state) of 
      Just screen -> do
        mParent <- case lookup parentId state.containerIndex of
          Just cont -> do
            _ <- renderer stateRef screen cont
            pure unit
          Nothing -> do
            pure unit
        pure unit
      Nothing -> do pure unit
    RemoveChildren id -> case lookup id state.containerIndex of
      Just cont -> removeChildren cont
      Nothing -> do pure unit
    RenderComponent parentId elem -> case lookup parentId state.containerIndex of
      Just parent -> do
        _ <- renderer stateRef elem parent
        pure unit
      Nothing -> do pure unit
    TweenImage id to duration -> case lookup id state.imageIndex of
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
    RemoveOnUpdate -> do removeOnUpdate state.scene
    MoveImage id vec -> case lookup id state.imageIndex of
      Just img -> do setImagePosition vec img
      Nothing -> pure unit

distance :: Vector -> Vector -> Number
distance from to = pow (from.x - to.x) 2.0 + pow (from.y + to.y) 2.0
