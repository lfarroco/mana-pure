module UI.Render where

import Prelude
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser
  ( PhaserContainer
  , PhaserScene
  , addContainer
  , addImage
  , addToContainer
  , solidColorRect
  , text
  )
import UI.Elements (Element(..))

addToContainer_ :: forall a. Maybe PhaserContainer -> a -> Effect Unit
addToContainer_ parent element = case parent of
  Nothing -> do
    pure unit
  Just container -> do
    _ <- addToContainer { element, container }
    pure unit

render :: PhaserScene -> Element -> Maybe PhaserContainer -> Effect Unit
render scene element parentContainer = case element of
  Container c -> do
    container <- addContainer scene c.pos.x c.pos.y
    for_ c.children (\e -> render scene e $ Just container)
    addToContainer_ parentContainer container
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
