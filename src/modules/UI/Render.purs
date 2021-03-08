module UI.Render where

import Prelude
import Core.Models (vec)
import Data.Foldable (for_)
import Data.Map (insert, lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Effect.Ref (Ref, modify_, read)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.ManaModels (ManaState)
import Graphics.Phaser (PhaserContainer, addContainer, addImage, addToContainer, containerOnPointerUp, destroy, removeChildren, setContainerSize, solidColorRect, text)
import UI.Elements (Element(..))

addToContainer_ :: forall t3. PhaserContainer -> t3 -> Effect PhaserContainer
addToContainer_ container element = addToContainer { element, container }

render :: Ref ManaState -> Element -> PhaserContainer -> Effect PhaserContainer
render state element parentContainer = do
  case element of
    Container c -> do
      st <- read state
      container <- addContainer st.scene c.pos
      _ <- addToContainer_ parentContainer container
      _ <- setContainerSize container c.size
      modify_ (\s -> s { containers = insert c.id container s.containers }) state
      for_ c.children (\e -> render state e container)
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
      log $ "rendering " <> t.text
      text_ <-
        text
          { scene: st.scene
          , pos: t.pos
          , text: t.text
          , config: { color: "#fff", fontSize: 18, fontFamily: "sans-serif" }
          }
      addToContainer_ parentContainer text_
    UnitInfo id -> do
      runEvent state (RemoveChildren "unitInfoWrapper")
      st <- read state
      case getChara st of
        Nothing -> do
          pure st.root
        Just c -> do
          case parent st of
            Just p -> do
              text_ <-
                text
                  { scene: st.scene
                  , pos: vec 0 0
                  , text: c.name <> " // " <> c.name
                  , config: { color: "#f00", fontSize: 18, fontFamily: "sans-serif" }
                  }
              addToContainer_ p text_
            Nothing -> pure st.root
      where
      getChara st = lookup id st.characterIndex

      parent st = lookup "unitInfoWrapper" st.containers -- TODO: remove screens from map

runEvent :: Ref ManaState -> ManaEvent -> Effect Unit
runEvent state ev = do
  st <- read state
  case ev of
    ContainerClick id -> do
      --newState <- modify (\n -> n + 1) state
      --_ <- render scene mainScreen container
      log $ id
    Destroy id -> do
      case lookup id st.containers of
        Just s -> destroy s
        Nothing -> pure unit
    Render id parentId -> case lookup id st.screenIndex of
      Just screen -> do
        mParent <- case lookup parentId st.containers of
          Just cont -> do
            _ <- render state screen cont
            pure unit
          Nothing -> do
            pure unit
        pure unit
      Nothing -> do pure unit
    RenderUnitInfo id -> case lookup "unitListScreen" st.containers of
      Just parent -> do
        runEvent state (Destroy "unitInfo")
        _ <- render state (UnitInfo id) parent
        pure unit
      Nothing -> do pure unit
    RemoveChildren id -> case lookup id st.containers of
      Just cont -> removeChildren cont
      Nothing -> do pure unit
