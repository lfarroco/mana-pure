module Game.Infrastructure.Models where

import Prelude
import Effect (Effect)
import Effect.Ref (Ref)
import Game.Domain.Element (ContainerId, Element)
import Game.Domain.Events (ManaEvent)
import Graphics.Phaser (PhaserContainer)

type EventRunner gameState
  = Renderer gameState -> Ref gameState -> ManaEvent (Element gameState) ContainerId -> Effect Unit

type Renderer gameState
  = Ref gameState -> Element gameState -> PhaserContainer -> Effect PhaserContainer
