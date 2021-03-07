module UI.Render where

import Prelude
import Data.Foldable (for_)
import Data.Map (Map, insert, lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify_, read)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserContainer, PhaserScene, addContainer, addImage, addToContainer, containerOnPointerUp, destroy, setContainerSize, solidColorRect, text)
import UI.Elements (Element(..))

addToContainer_ :: forall t3. PhaserContainer -> t3 -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

type RenderParams
  = forall t65.
    PhaserScene ->
    Ref
      { containers :: Map String PhaserContainer
      | t65
      } ->
    Element -> PhaserContainer -> Effect PhaserContainer

render :: RenderParams
render scene state element parentContainer = case element of
  Container c -> do
    container <- addContainer scene c.pos
    modify_ (\s -> s { containers = insert c.id container s.containers }) state
    _ <- setContainerSize container c.size
    for_ c.children (\e -> render scene state e container)
    _ <- addToContainer_ parentContainer container
    case c.onClick of
      Nothing -> do
        log "not adding event!!"
        pure parentContainer
      Just ev -> do
        s <- read state
        runEvent s scene container
          # containerOnPointerUp container ev
        log "adding cool event!!"
        pure parentContainer
  -- ManaEvent -> (ManaEvent -> Effect Unit) -> Effect Unit
  Image i -> do
    img <- addImage scene i.pos.x i.pos.y i.texture
    addToContainer_ parentContainer img
  Rect r -> do
    rect <- solidColorRect scene r.pos r.size r.color
    addToContainer_ parentContainer rect
  Text t -> do
    text_ <-
      text
        { scene
        , pos: t.pos
        , text: t.text
        , config: { color: "#000", fontSize: 18, fontFamily: "sans-serif" }
        }
    addToContainer_ parentContainer text_

runEvent state scene container ev = case ev of
  ContainerClick id -> do
    --newState <- modify (\n -> n + 1) state
    --_ <- render scene mainScreen container
    log $ id
  Destroy id -> do
    _ <- case lookup id state.containers of
      Just s -> do
        log "found!"
        destroy s
      Nothing -> do
        log "not found : ("
        pure unit
    log $ id
  Render id -> log "aaa"
