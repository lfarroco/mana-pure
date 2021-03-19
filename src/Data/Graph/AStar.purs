module Data.Graph.AStar where

-- Based on the implementation at https://www.redblobgames.com/pathfinding/a-star/introduction.html
import Prelude
import Control.Apply (lift2)
import Data.Array (filter, foldl, head, mapMaybe, reverse, sortWith)
import Data.Int (toNumber)
import Data.Map (Map, insert, update)
import Data.Map as Map
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Tuple (Tuple(..))
import Math (abs)
import Matrix (Matrix)
import Matrix as Matrix

-- can be extended to "Point x y weight"
data Point
  = Point Int Int

instance showPoint :: Show Point where
  show (Point x y) = "Point " <> show x <> " " <> show y

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
    getCell (Point dx dy) = case Matrix.get (dx + x) (dy + y) matrix of
      Just cell ->
        if cell == Rock || cell == Wall then
          Nothing
        else
          Just $ Point (dx + x) (dy + y)
      Nothing -> Nothing

    ns = [ -1, 0, 1 ]

    directions = lift2 Point ns ns # filter (\p -> p /= Point 0 0)
  in
    mapMaybe getCell directions

-- TODO: add maximum depth, change Int to Number (to use sqrt2 instead of 14 for distance)
look ::
  Point ->
  Map Point Number ->
  Map Point Number ->
  Map Point Point ->
  Point ->
  Matrix Cell -> Array Point
look start open_set cost_map came_from target world =
  let
    mhead =
      open_set
        # Map.toUnfoldable
        # sortWith (\(Tuple k v) -> v)
        # head
        # map (\(Tuple point int) -> point)
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

                        is_diagonal = case heuristic current next of
                          Just n -> n == 2.0
                          _ -> false

                        -- cost to move to neighbor, since the beggining 
                        -- (current node + 1.0 , or 1.4 to diagonal)
                        new_cost =
                          current_cost
                            # map \n ->
                                if is_diagonal then
                                  n + 1.4
                                else
                                  n + 1.0

                        neigh_cost = Map.lookup next xs.cost_map
                      in
                        if neigh_cost == Nothing || new_cost < neigh_cost then
                          { open_set: insert next (fromMaybe 0.0 (sumMaybe new_cost (heuristic next target))) xs.open_set
                          , cost_map: insert next (fromMaybe 0.0 new_cost) xs.cost_map
                          , came_from: insert next current xs.came_from
                          }
                        else
                          xs
                  )
                  { open_set: openSetWithoutCurrent, cost_map, came_from }
        in
          if current == target then
            traceParent target start came_from # reverse
          else
            look start res.open_set res.cost_map res.came_from target world
      Nothing -> []

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

-- euclidean distance
heuristic :: Point -> Point -> Maybe Number
heuristic (Point x y) (Point p1 p2) =
  Just
    ( abs
        ((toNumber p1) - (toNumber x))
        + abs ((toNumber p2) - (toNumber y))
    )

sumMaybe :: Maybe Number -> Maybe Number -> Maybe Number
sumMaybe a b =
  let
    f_ = fromMaybe 0.0
  in
    Just $ f_ a + f_ b

----------------------------------------
--------------- testing-----------------
----------------------------------------
start :: Point
start = Point 1 1

end :: Point
end = Point  7 7

solution :: Array Point
solution =
  look
    start
    (Map.empty # Map.insert start 0.0) -- openSet
    (Map.empty # insert start 0.0) -- costMap
    (Map.empty # insert start start) -- cameFrom
    end -- goal
    testWorld

printTest :: Matrix PathCell
printTest = showPath start end solution testWorld

testWorld :: Matrix Cell
testWorld =
  let
    mat = Matrix.repeat 10 10 (Grass)

    setCell x y v matrix = case Matrix.set x y v matrix of
      Just m -> m
      _ -> matrix
  in
    mat
      # setCell 2 0 Wall
      # setCell 2 1 Wall
      # setCell 2 2 Wall
      # setCell 2 3 Wall


      # setCell 4 2 Wall
      # setCell 4 3 Wall
      # setCell 4 4 Wall
      # setCell 4 5 Wall
      # setCell 4 6 Wall
      # setCell 4 7 Wall
      # setCell 4 8 Wall
      # setCell 4 9 Wall

      # setCell 6 4 Wall
      # setCell 6 5 Wall
      # setCell 6 6 Wall

showPath :: Point -> Point -> Array Point -> Matrix Cell -> Matrix PathCell
showPath origin goal path world =
  let
    mtx = Matrix.repeat (Matrix.width world) (Matrix.height world) Empty
  in
    path
      # foldl
          ( \xs (Point x y) -> case Matrix.set x y Walk xs of
              Just m -> m
              _ -> xs
          )
          mtx
      # Matrix.indexedMap
          ( \x y val ->
              let
                cellType = fromMaybe Grass $ Matrix.get x y world

                next = case cellType of
                  Grass -> Empty
                  Rock -> Blocked
                  Wall -> Blocked
              in
                if Point x y == origin then
                  Start
                else if Point x y == goal then
                  Goal
                else if val == Walk then
                  val
                else
                  next
          )
