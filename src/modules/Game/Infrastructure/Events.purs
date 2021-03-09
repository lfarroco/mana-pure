module Game.Infrastructure.Events where

import Prelude
import Data.Map (lookup)
import Data.Maybe (Maybe(..))
import Effect.Ref (read)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrastructure.Models (EventRunner)
import Graphics.Phaser (addTween, destroy, removeChildren)

runEvent :: EventRunner
runEvent renderer stateRef event = do
  state <- read stateRef
  case event of
    Destroy id -> do
      case lookup id state.containerIndex of
        Just s -> destroy s
        Nothing -> pure unit
    RenderScreen id parentId -> case lookup id state.screenIndex of
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
            , duration
            , ease: "Cubic"
            , repeat: -1
            , yoyo: true
            }
        pure unit
      Nothing -> pure unit
