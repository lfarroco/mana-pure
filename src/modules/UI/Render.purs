module UI.Render where

import Prelude
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser
  ( PhaserContainer
  , PhaserScene
  , addContainer
  , addGraphicsToContainer
  , addImage
  , addImageToContainer
  , addTextToContainer
  , solidColorRect
  , text
  )
import UI.Elements (Element(..))

addToContainer ::
  forall t11 t2 t5 t6.
  Applicative t6 =>
  Bind t6 =>
  Maybe t5 ->
  t2 ->
  ( { container :: t5
    , element :: t2
    } ->
    t6 t11
  ) ->
  t6 Unit
addToContainer parent element fn = case parent of
  Nothing -> do
    pure unit
  Just container -> do
    _ <- fn { element, container }
    pure unit

render :: PhaserScene -> Element -> Maybe PhaserContainer -> Effect Unit
render scene element parentContainer = case element of
  Container c -> do
    container <- addContainer scene c.pos.x c.pos.y
    for_ c.children (\e -> render scene e $ Just container)
  Image i -> do
    img <- addImage scene i.pos.x i.pos.y i.texture
    addToContainer parentContainer img addImageToContainer
  Rect r -> do
    rect <- solidColorRect scene r.pos r.size r.color
    addToContainer parentContainer rect addGraphicsToContainer
  Text t -> do
    text_ <- text { scene, pos: t.pos, text: t.text, config: { color: "#fff", fontSize: 18, fontFamily: "sans-serif" } }
    addToContainer parentContainer text_ addTextToContainer
