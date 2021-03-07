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
  Ref { containers :: Map String PhaserContainer, game :: PhaserGame, root :: PhaserContainer, scene :: PhaserScene, sceneIndex :: Map String Element } ->
  Element -> PhaserContainer -> Effect PhaserContainer
render state element parentContainer = do
  case element of
    Container c -> do
      st <- read state
      container <- addContainer st.scene c.pos
      modify_ (\s -> s { containers = insert c.id container s.containers }) state
      _ <- setContainerSize container c.size
      for_ c.children (\e -> render state e container)
      _ <- addToContainer_ parentContainer container
      for_ c.onClick \ev -> do
        s <- read state
        runEvent state
          # containerOnPointerUp container ev
      pure parentContainer
    Image i -> do
      st <- read state
      img <- addImage st.scene i.pos.x i.pos.y i.texture
      addToContainer_ parentContainer img
    Rect r -> do
      st <- read state
      rect <- solidColorRect st.scene r.pos r.size r.color
      addToContainer_ parentContainer rect
    Text t -> do
      st <- read state
      text_ <-
        text
          { scene: st.scene
          , pos: t.pos
          , text: t.text
          , config: { color: "#000", fontSize: 18, fontFamily: "sans-serif" }
          }
      addToContainer_ parentContainer text_

-- TODO: reduce number of parameters
runEvent :: Ref (ManaState PhaserGame PhaserScene PhaserContainer (Map String PhaserContainer) (Map String Element)) -> ManaEvent -> Effect Unit
runEvent state ev = do
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
    Render id parentId -> case lookup id st.sceneIndex of
      Just e -> do
        mParent <- case lookup parentId st.containers of
          Just cont -> do
            _ <- render state e cont
            pure unit
          Nothing -> do
            pure unit
        pure unit
      Nothing -> do pure unit
