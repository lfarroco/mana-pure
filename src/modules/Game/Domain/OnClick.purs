module Game.Domain.OnClick where

import Prelude
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserContainer, PhaserScene)

-- move to infra
onclick :: Ref Int -> PhaserScene -> PhaserContainer -> ManaEvent -> Effect Unit
onclick state scene container ev = case ev of
  ContainerClick id -> do
    --newState <- modify (\n -> n + 1) state
    --_ <- render scene mainScreen container
    log $ id
