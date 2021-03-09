module Game.Infrastructure.Events where

import Prelude
import Data.Map (lookup)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Ref (Ref, read)
import Game.Domain.Element (Element)
import Game.Domain.Events (ManaEvent(..))
import Game.Infrasctruture.PhaserState (PhaserState)
import Graphics.Phaser (PhaserContainer, destroy, removeChildren)

runEvent ::
  (Ref PhaserState -> Element -> PhaserContainer -> Effect PhaserContainer) ->
  Ref PhaserState -> ManaEvent Element -> Effect Unit
runEvent renderer state ev = do
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
            _ <- renderer state screen cont
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
        _ <- renderer state (elem) parent
        pure unit
      Nothing -> do pure unit
