module Game.Infrastructure.Renderer where

import Prelude
import Data.Foldable (for_)
import Data.Map (insert)
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, read)
import Game.Domain.Element (Element(..))
import Game.Infrastructure.Events (runEvent)
import Game.Infrastructure.Models (Renderer)
import Graphics.Phaser (PhaserContainer, addContainer, addImage, addToContainer, containerOnPointerUp, setContainerSize, solidColorRect, text)

addToContainer_ :: forall element. PhaserContainer -> element -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render :: Renderer
render state element parentContainer = do
  st <- read state
  case element of
    Container c -> do
      container <- addContainer st.scene c.pos
      _ <- addToContainer_ parentContainer container
      _ <- setContainerSize container c.size
      modify_ (\s -> s { containerIndex = insert c.id container s.containerIndex }) state
      for_ c.children (\e -> render state e container)
      for_ c.onClick \ev -> do
        s <- read state
        runEvent_ state
          # containerOnPointerUp container ev
      for_ c.onCreate \ev -> do
        s <- read state
        runEvent_ state ev
      pure parentContainer
    Image i -> do
      img <- addImage st.scene i.pos.x i.pos.y i.texture
      modify_ (\s -> s { imageIndex = insert i.id img s.imageIndex }) state
      addToContainer_ parentContainer img
    Rect r -> do
      rect <- solidColorRect st.scene r.pos r.size r.color
      addToContainer_ parentContainer rect
    Text t -> do
      log $ "rendering " <> t.text
      text_ <-
        text
          { scene: st.scene
          , pos: t.pos
          , text: t.text
          , config: { color: "#fff", fontSize: 18, fontFamily: "sans-serif" }
          }
      addToContainer_ parentContainer text_
  where
  runEvent_ = runEvent render
