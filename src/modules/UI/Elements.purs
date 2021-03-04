module UI.Elements where

import Prelude

import Core.Models (Vector, Size)
import Data.Foldable (for_)
import Data.List (List)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Graphics.Phaser (
    PhaserContainer, PhaserScene, addContainer, addGraphicsToContainer, 
    addImage, addImageToContainer, addTextToContainer, solidColorRect, text)

type Event = forall a. (a -> Effect Unit) -> a -> Effect Unit

newtype ContainerId = ContainerId String

createContainerId :: String -> ContainerId
createContainerId s = ContainerId s


data Element = Container { 
                id:: ContainerId,
                pos:: Vector,
                children:: List Element ,
                onClick:: Maybe Event}
             | Rect { pos::Vector, size::Size, color:: String }
             | Image {pos::Vector, size::Size, texture:: String}
             | Text {pos::Vector, text:: String}


addToContainer :: forall t79 t82 t83 t88.
  Applicative t83 => Bind t83 => Maybe t82
                                 -> t79
                                    -> ({ container :: t82
                                        , element :: t79
                                        }
                                        -> t83 t88
                                       )
                                       -> t83 Unit
addToContainer parent element fn = 
        case parent of 
            Nothing -> do
                pure unit
            Just container -> do  
                _ <- fn {element, container}
                pure unit

render :: PhaserScene -> Element -> Maybe PhaserContainer -> Effect Unit
render scene element parentContainer = 
  case element of
    Container c -> do
        container <- addContainer scene c.pos.x c.pos.y
        for_ c.children (\e->render scene e $ Just container) 
    Image i -> do 
        img <- addImage scene 11 11 "aa"
        addToContainer parentContainer img addImageToContainer
    Rect r -> do
        rect <- solidColorRect scene r.pos r.size r.color
        addToContainer parentContainer rect addGraphicsToContainer
    Text t -> do
        text_ <- text {scene, pos: t.pos, text: t.text, config: {color: "#000", fontSize: 18, fontFamily: "sans-serif"} }  
        addToContainer parentContainer text_ addTextToContainer
    