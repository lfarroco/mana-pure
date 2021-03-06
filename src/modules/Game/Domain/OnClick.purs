module Game.Domain.OnClick where

import Prelude
import Data.Map (Map, lookup, showTree)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (destroy)

-- move to infra
onclick state scene container ev = case ev of
  ContainerClick id -> do
    --newState <- modify (\n -> n + 1) state
    --_ <- render scene mainScreen container
    log $ id
  Destroy id -> do
    _ <- case lookup id state of
      Just s -> do
        log "found!"
        destroy s
      Nothing -> do
        log "not found : ("
        pure unit
    log $ id
