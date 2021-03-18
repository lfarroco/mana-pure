module Data.Graph.Astar where

-- Based on the implementation at https://www.redblobgames.com/pathfinding/a-star/introduction.html
import Prelude
import Data.Array (foldl, head, mapMaybe, sortWith, intercalate, reverse)
import Data.Foldable (for_)
import Data.Map (Map, empty, insert, update)
import Data.Map as Map
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Tuple (Tuple(..))
import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Matrix (Matrix)
import Matrix as Matrix

data Point
  = Point Int Int

instance showPoint :: Show Point where
  show (Point x y) = "(" <> show x <> "," <> show y <> ")"

derive instance eqPoint :: Eq Point

derive instance ordPoint :: Ord Point

data Cell
  = Grass
  | Rock
  | Wall

derive instance eqCell :: Eq Cell

data PathCell
  = Walk
  | Empty
  | Start
  | Blocked
  | Goal

derive instance eqPathCell :: Eq PathCell

instance showPathCell :: Show PathCell where
  show Walk = "x "
  show Empty = "  "
  show Start = "S "
  show Blocked = "█ "
  show Goal = "★ "

instance showCell :: Show Cell where
  show Grass = " ^ "
  show Rock = " O "
  show Wall = "█ "

type Grid
  = Map.Map Point Cell

getNeighbors :: Point -> Matrix Cell -> Array Point
getNeighbors (Point x y) matrix =
  let
    g xx yy = case Matrix.get xx yy matrix of
      Just v -> 
        if v == Rock || v == Wall then
          Nothing
        else
          Just $ Point xx yy
      Nothing -> Nothing
  in
    mapMaybe identity [ g x (y - 1), g (x - 1) y, g (x + 1) y, g x (y + 1) ]

grid :: Matrix Cell
grid =
  let
    mat = Matrix.repeat 10 10 (Grass)
  in
    case Matrix.set 1 2 Wall mat of
      Just m -> m
      _ -> mat

start :: Point
start = Point 1 1

finish :: Point
finish = Point 4 4

costMap :: Map Point Int
costMap = empty # insert start 0

cameFrom :: forall t141. Map Point (Maybe t141)
cameFrom = empty # insert start Nothing

openSet :: Map Point Int
openSet = empty # insert start 0 -- priority queue (open set)

look ::
  Map Point Int ->
  Map Point Int ->
  Map Point Point ->
  Point ->
  Matrix Cell ->
  { came_from :: Map Point Point
  , cause :: String
  , cost_map :: Map Point Int
  , openSetWithoutCurrent :: Map Point Int
  }
look open_set cost_map came_from target world =
  let
    mhead =
      open_set
        # Map.toUnfoldable
        # sortWith (\(Tuple k v) -> v)
        # head
        # map (\(Tuple point int) -> point)
  --current = fromMaybe start head_
  in
    case mhead of
      Just current ->
        let
          openSetWithoutCurrent = open_set # update (\_ -> Nothing) current

          neighs = getNeighbors current world

          res =
            neighs
              # foldl
                  ( \xs next ->
                      let
                        current_cost = Map.lookup current xs.cost_map

                        new_cost = current_cost # map \n -> n + 1 -- cost to move to neighbor, since the beggining (current node + 1 , or 1.4 to diagonal)

                        neigh_cost = Map.lookup next xs.cost_map
                      in
                        if neigh_cost == Nothing || new_cost < neigh_cost then
                          { open_set: insert next (fromMaybe 0 (sumMaybe new_cost (heuristic next target))) xs.open_set
                          , cost_map: insert next (fromMaybe 0 new_cost) xs.cost_map
                          , came_from: insert next current xs.came_from
                          }
                        else
                          xs
                  )
                  { open_set: openSetWithoutCurrent, cost_map, came_from }
        in
          if current == target then
            { came_from, cost_map, openSetWithoutCurrent, cause: "found!!!" }
          else
            look res.open_set res.cost_map res.came_from target world
      Nothing -> { came_from, cost_map, openSetWithoutCurrent: open_set, cause: "empty openset!!" }

printMatrix :: forall t28 t35. Show t28 => Applicative t35 => MonadEffect t35 => Matrix t28 -> t35 Unit
printMatrix matrix =
  let
    rows =
      map show matrix
        # Matrix.rows
        # map (intercalate "")
  in
    for_ rows (\s -> log s)

showPath :: Matrix PathCell
showPath =
  let
    -- traceme array point
    mtx = Matrix.repeat (Matrix.width grid) (Matrix.height grid) Empty
  in
    traceme
      # foldl
          ( \xs (Point x y) -> case Matrix.set x y Walk xs of
              Just m -> m
              _ -> xs
          )
          mtx
      # Matrix.indexedMap
          ( \x y val ->
              let
                cellType = fromMaybe Grass $ Matrix.get x y grid

                next = case cellType of
                  Grass -> Empty
                  Rock -> Blocked
                  Wall -> Blocked
              in
                if Point x y == start then
                  Start
                else if Point x y == finish then
                  Goal
                else if val == Walk then
                  val
                else
                  next
          )

traceParent :: Point -> Point -> Map Point Point -> Array Point
traceParent curr origin index =
  if curr == origin then
    []
  else
    let
      res = Map.lookup curr index
    in
      case res of
        Just r -> [ r ] <> (traceParent r origin index)
        Nothing -> []

abs :: Int -> Int
abs n =
  if n == 0 then
    0
  else
    (n * n) / n

heuristic :: Point -> Point -> Maybe Int
heuristic (Point x y) (Point p1 p2) = Just (abs (p1 - x) + abs (p2 - y))

--testGrid :: Map Point Point
testGrid ::
  { came_from :: Map Point Point
  , cause :: String
  , cost_map :: Map Point Int
  , openSetWithoutCurrent :: Map Point Int
  }
testGrid = look (Map.empty # Map.insert start 0) (Map.empty # insert start 0) (Map.empty # insert start start) finish grid

traceme :: Array Point
traceme = traceParent finish start testGrid.came_from # reverse

sumMaybe :: Maybe Int -> Maybe Int -> Maybe Int
sumMaybe a b =
  let
    f_ = fromMaybe 0
  in
    Just $ f_ a + f_ b
