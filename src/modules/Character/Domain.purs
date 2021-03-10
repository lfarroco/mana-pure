module Character.Domain where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)
import Data.Map (Map)
import Job.Domain (Job)

type Character
  = { id :: String
    , name :: String
    , job :: Job
    , age :: Int
    , hp :: HitPoints
    }

newtype HitPoints
  = HitPoints BoundedNumber

createHitPoints :: Int -> HitPoints
createHitPoints v = HitPoints $ createBoundedNumber 0 100 v

data AttributeTypes
  = Intelligence
  | Strength
  | Dexterity

type Attributes
  = Map String Int
