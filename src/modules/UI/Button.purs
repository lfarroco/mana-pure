module UI.Button where

import Core.Models (Vector, Size, vec)
import Effect.Ref (Ref)
import Game.Domain.Element (ContainerId, Element(..), createContainerId)
import Game.Domain.Events (ManaEvent)

-- this is terrible :cry: what about a pipe?
button ::
  forall state.
  String ->
  String ->
  Vector ->
  Size ->
  Array
    ( Ref state ->
      Vector ->
      ManaEvent (Element state) ContainerId state
    ) ->
  Element state
button id text pos size onClick =
  Container
    { id: createContainerId id
    , pos
    , size
    , onClick
    , onCreate: []
    , children:
        [ Rect
            { pos: vec 0 0
            , size: { width: size.width, height: size.height }
            , color: "0x888888"
            }
        , Text
            { pos: vec 10 10
            , text
            }
        ]
    }
