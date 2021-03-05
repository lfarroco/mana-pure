module UI.Render where

import Prelude
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Game.Domain.Events (State)
import Game.Domain.OnClick (onclick)
import Graphics.Phaser (PhaserContainer, PhaserScene, addContainer, addImage, addToContainer, containerOnPointerUp, setContainerSize, solidColorRect, text)
import UI.Elements (Element(..))

addToContainer_ :: forall t3. PhaserContainer -> t3 -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render :: PhaserScene -> State -> Element -> PhaserContainer -> Effect PhaserContainer
render scene state element parentContainer = case element of
  Container c -> do
    container <- addContainer scene c.pos
    _ <- setContainerSize container c.size
    for_ c.children (\e -> render scene state e container)
    _ <- addToContainer_ parentContainer container
    case c.onClick of
      Nothing -> do
        log "not adding event!!"
        pure parentContainer
      Just ev -> do
        onclick state scene container
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
        , config: { color: "#fff", fontSize: 18, fontFamily: "sans-serif" }
        }
    addToContainer_ parentContainer text_
