module UI.Render where

import Prelude
import Core.Models (ManaState)
import Data.Foldable (for_)
import Data.Map (Map, insert, lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify_, read)
import Game.Domain.Events (ManaEvent(..))
import Graphics.Phaser (PhaserContainer, PhaserGame, PhaserScene, addContainer, addImage, addToContainer, containerOnPointerUp, destroy, setContainerSize, solidColorRect, text)
import UI.Elements (Element(..))

addToContainer_ :: forall t3. PhaserContainer -> t3 -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render ::
  PhaserScene ->
  Ref
    { containers :: Map String PhaserContainer
    , game :: PhaserGame
    , scene :: PhaserScene
    , sceneIndex :: Map String Element
    } ->
  Element -> PhaserContainer -> Effect PhaserContainer
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
        runEvent state scene container
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

-- TODO: reduce number of parameters
runEvent :: Ref (ManaState PhaserGame PhaserScene (Map String PhaserContainer) (Map String Element)) -> PhaserScene -> PhaserContainer -> ManaEvent -> Effect Unit
runEvent state scene container ev = do
  st <- read state
  case ev of
    ContainerClick id -> do
      --newState <- modify (\n -> n + 1) state
      --_ <- render scene mainScreen container
      log $ id
    Destroy id -> do
      _ <- case lookup id st.containers of
        Just s -> do
          log "found!"
          destroy s
        Nothing -> do
          log "not found : ("
          pure unit
      log $ id
    Render id -> case lookup id st.sceneIndex of
      Just e -> do
        _ <- render scene state e container
        log id
      Nothing -> do log id
