module UI.RenderScreen where

import Prelude
import Data.Foldable (for_)
import Data.Map (insert, lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify_, read)
import Game.Domain.Events (Element(..), ManaEvent(..))
import Graphics.Phaser
  ( PhaserContainer
  , addContainer
  , addImage
  , addToContainer
  , containerOnPointerUp
  , destroy
  , removeChildren
  , setContainerSize
  , solidColorRect
  , text
  )
import Game.Infrasctruture.PhaserState (PhaserState)

addToContainer_ :: forall t3. PhaserContainer -> t3 -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render :: Ref PhaserState -> Element -> PhaserContainer -> Effect PhaserContainer
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
        runEvent state
          # containerOnPointerUp container ev
      pure parentContainer
    Image i -> do
      img <- addImage st.scene i.pos.x i.pos.y i.texture
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

runEvent :: Ref PhaserState -> ManaEvent -> Effect Unit
runEvent state ev = do
  st <- read state
  case ev of
    Destroy id -> do
      case lookup id st.containerIndex of
        Just s -> destroy s
        Nothing -> pure unit
    RenderScreen id parentId -> case lookup id st.screenIndex of
      Just screen -> do
        mParent <- case lookup parentId st.containerIndex of
          Just cont -> do
            _ <- render state screen cont
            pure unit
          Nothing -> do
            pure unit
        pure unit
      Nothing -> do pure unit
    RemoveChildren id -> case lookup id st.containerIndex of
      Just cont -> removeChildren cont
      Nothing -> do pure unit
    RenderComponent id elem -> case lookup id st.containerIndex of --rename this to `renderComponent`
      Just parent -> do
        _ <- render state (elem) parent
        pure unit
      Nothing -> do pure unit
