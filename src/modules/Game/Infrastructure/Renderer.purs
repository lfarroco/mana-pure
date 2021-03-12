module Game.Infrastructure.Renderer where

import Prelude
import Data.Foldable (for_)
import Data.Map (insert)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (modify_, read)
import Game.Domain.Element (Element(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Game.Infrastructure.Events (runEvent)
import Game.Infrastructure.Models (Renderer)
import Graphics.Phaser (PhaserContainer, addContainer, addImage, addToContainer, containerOnPointerUp, setContainerSize, setTint, solidColorRect, text)

addToContainer_ :: forall element. PhaserContainer -> element -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render :: Renderer PhaserState
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
        containerOnPointerUp container (\v -> ev state v) (runEvent_ state)
      for_ c.onCreate \ev -> do
        s <- read state
        runEvent_ state ev
      pure parentContainer
    Image i -> do
      image <- addImage st.scene i.pos.x i.pos.y i.texture
      modify_ (\s -> s { imageIndex = insert i.id image s.imageIndex }) state
      _ <- case i.tint of
        Just color -> setTint { color, image }
        Nothing -> pure unit
      addToContainer_ parentContainer image
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
