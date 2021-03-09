module Game.Infrastructure.Models where

import Prelude
import Effect (Effect)
import Effect.Ref (Ref)
import Game.Domain.Element (ContainerId, Element)
import Game.Domain.Events (ManaEvent)
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (PhaserContainer)

type EventRunner
  = Renderer -> Ref PhaserState -> ManaEvent Element ContainerId -> Effect Unit

type Renderer
  = Ref PhaserState -> Element -> PhaserContainer -> Effect PhaserContainer

