module Game.Infrastructure.Events where

import Prelude
import Data.Map (lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Ref (Ref, read)
import Game.Domain.Element (ContainerId, Element)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Renderer (Renderer)
import Graphics.Phaser (destroy, removeChildren)

runEvent :: Renderer -> Ref PhaserState -> ManaEvent Element ContainerId -> Effect Unit
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
