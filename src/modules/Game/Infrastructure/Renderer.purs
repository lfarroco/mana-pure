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
import Graphics.Phaser.Container (create, addChild)
import Graphics.Phaser.GameObject (class GameObject, setSize)
import Graphics.Phaser.Graphics (solidRect)
import Graphics.Phaser.Image as Image
import Graphics.Phaser.Text (text)
import Phaser.Graphics.ForeignTypes (PhaserContainer)

addToContainer_ :: forall element. GameObject element => PhaserContainer -> element -> Effect Unit
addToContainer_ container element = addChild element container 

mAdd :: forall element. GameObject element => Maybe PhaserContainer -> element -> Effect Unit
mAdd parentContainer element = case parentContainer of
  Nothing -> pure unit
  Just parent -> do 
    addChild element parent 

render :: Renderer PhaserState
render state element parentContainer = do
  st <- read state
  case element of
    Container c -> do
      container <- create c.pos st.scene 
      _ <- setSize c.size container
      modify_ (\s -> s { containerIndex = insert c.id container s.containerIndex }) state
      for_ c.onClick \ev -> do
        s <- read state -- remove this, as this is outdated state
        pure unit
        --containerOnPointerUp container (\v -> ev s v) (runEvent_ state)
      for_ c.children (\e -> render state e (Just container))
      for_ c.onCreate \ev -> do
        s <- read state
        runEvent_ state ev
      mAdd parentContainer container
    Image i -> do
      image <- Image.create i.texture {x: i.pos.x, y: i.pos.y} st.scene
      modify_ (\s -> s { imageIndex = insert i.id image s.imageIndex }) state
      pure unit
      --_ <- case i.tint of
      --  Just color ->  pure unit
      --    --setTint { color, image }
      --  Nothing -> pure unit
      mAdd parentContainer image
    Rect r -> do
      rect <- solidRect r.pos r.size r.color st.scene
      mAdd parentContainer rect
    Text t -> do
      log $ "rendering " <> t.text
      text_ <-
        text
          { scene: st.scene
          , pos: t.pos
          , text: t.text
          , config: { color: "#fff", fontSize: 18, fontFamily: "sans-serif" }
          }
      mAdd parentContainer text_
  where
  runEvent_ = runEvent render
