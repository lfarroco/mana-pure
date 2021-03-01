module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
--import Interest (calculateInterest)
import Data.Map as M
import Data.Maybe (Maybe(..))
import Graphics.Canvas (Context2D, fillPath, getCanvasElementById, getContext2D, rect, setFillStyle)
import Partial.Unsafe (unsafePartial)

data CharaName = CharaName { value:: String }
createCharaName:: String -> CharaName
createCharaName s = CharaName { value : s }

data Age = Age { value:: String }
createAge:: String -> Age
createAge s = Age { value : s }

type Chara = {
  name :: CharaName,
  age :: Age
}

createChara :: String -> String -> Chara
createChara name age = { name: createCharaName name, age: createAge age } 

data EventName = START | END
derive instance eqEventName :: Eq EventName
derive instance ordEventName :: Ord EventName

index:: M.Map EventName String
index = M.empty
      # M.insert START "aaa"
      # M.insert END "bbbb"

emit:: EventName -> Effect Unit
emit eventName =
  case eventName of
       START -> log "xaxxa"
       END -> log "zazaza"

square :: Context2D -> Effect Unit
square ctx = rect ctx { x: 250.0 , y: 250.0 , width: 100.0 , height: 100.0 }
-- main :: Effect Unit
-- main = do
--   emit START

main:: Effect Unit
main = void $ unsafePartial do
  Just canvas <- getCanvasElementById "canvas"
  ctx <- getContext2D canvas

  _ <- setFillStyle ctx "#0000FF"

  fillPath ctx $ do
     square ctx
