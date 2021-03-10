module Core.BoundedNumber where

import Prelude

newtype BoundedNumber
  = BoundedNumber
  { min :: Int
  , max :: Int
  , value :: Int
  }

instance showBoundedNumber :: Show BoundedNumber where
  show (BoundedNumber n) = show n

instance compareBoundedNumber :: Eq BoundedNumber where
  eq (BoundedNumber a) (BoundedNumber b) = (a == b)

createBoundedNumber :: Int -> Int -> Int -> BoundedNumber
createBoundedNumber min max value =
  if value < min then
    createBoundedNumber min max min
  else if value > max then
    createBoundedNumber min max max
  else
    BoundedNumber { min, max, value }
