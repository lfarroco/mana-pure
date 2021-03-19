module Data.Graph.AStar where

-- Based on the implementation at https://www.redblobgames.com/pathfinding/a-star/introduction.html
import Prelude
import Control.Apply (lift2)
import Data.Array (filter, foldl, head, mapMaybe, reverse, sortWith)
import Data.Int (toNumber)
import Data.Map (Map)
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

type Grid = Map Point Cell

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

findPath ::
  Map Point Number ->
  Map Point Number ->
  Map Point Point ->
  Point ->
  Matrix Cell -> Array Point
findPath openSet costMap cameFrom target world =
  let
    mhead =
      openSet
        # Map.toUnfoldable
        # sortWith (\(Tuple k v) -> v)
        # head
        # map (\(Tuple point priority) -> point)
  in
    case mhead of
      Nothing -> []
      Just current ->
        let
          openSetWithoutCurrent = openSet # Map.update (\_ -> Nothing) current

          state =
            getNeighbors current world
              # foldl
                  ( \state' next ->
                      let
                        cost = Map.lookup current state'.costMap # fromMaybe 0.0

                        isDiagonal = distance current next == 2.0

                        moveToNextCost =
                          if isDiagonal then
                            cost + 1.4
                          else
                            cost + 1.0

                        nextCost = Map.lookup next state'.costMap

                        nextIsNew = nextCost == Nothing

                        foundABetterPath = Just moveToNextCost < nextCost

                        heuristic = distance next target

                        totalCost = moveToNextCost + heuristic
                      in
                        if nextIsNew || foundABetterPath then
                          { openSet: Map.insert next totalCost state'.openSet
                          , costMap: Map.insert next moveToNextCost state'.costMap
                          , cameFrom: Map.insert next current state'.cameFrom
                          }
                        else
                          state'
                  )
                  { openSet: openSetWithoutCurrent, costMap, cameFrom }
        in
          if current == target then
            traceParent target state.cameFrom # reverse
          else
            findPath state.openSet state.costMap state.cameFrom target world

traceParent :: Point -> Map Point Point -> Array Point
traceParent point index = case Map.lookup point index of
  Just prev -> [ prev ] <> (traceParent prev index)
  Nothing -> []

distance :: Point -> Point -> Number
distance (Point x y) (Point p1 p2) =
  let
    t = toNumber

    x' = abs (t p1) - (t x)

    y' = abs (t p2) - (t y)
  in
    x' + y'

runAStar :: Point -> Point -> Matrix Cell -> Array Point
runAStar start goal grid =
  let
    openSet = Map.empty # Map.insert start 0.0

    costMap = Map.empty # Map.insert start 0.0

    cameFrom = Map.empty
  in
    findPath openSet costMap cameFrom goal grid

-- internals
sumMaybe :: Maybe Number -> Maybe Number -> Number
sumMaybe a b =
  let
    n = fromMaybe 0.0
  in
    n a + n b

----------------------------------------
--------------- testing-----------------
----------------------------------------
printTest :: Matrix PathCell
printTest =
  let
    start = Point 1 1

    goal = Point 8 8

    path = runAStar start goal testWorld
  in
    showPath start goal path testWorld

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
showPath start goal path world =
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
                if Point x y == start then
                  Start
                else if Point x y == goal then
                  Goal
                else if val == Walk then
                  val
                else
                  next
          )
