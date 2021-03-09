module Game.Infrastructure.Renderer where

import Effect (Effect)
import Effect.Ref (Ref)
import Game.Domain.Element (Element)
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (PhaserContainer)

type Renderer
  = Ref PhaserState -> Element -> PhaserContainer -> Effect PhaserContainer
