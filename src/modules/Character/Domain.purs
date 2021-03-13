module Character.Domain where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)
import Data.Map (Map)
import Job.Domain (Job)

newtype Id = Id String

newtype Name = Name String

type Character
  = { id :: Id 
    , name :: Name
    , job :: Job
    , age :: Int
    , hp :: HitPoints
    }

newtype HitPoints
  = HitPoints BoundedNumber

-- make it return Result, in case the number is invalid
createHitPoints :: Int -> HitPoints
createHitPoints v = HitPoints $ createBoundedNumber 0 100 v

data AttributeTypes
  = Intelligence
  | Strength
  | Dexterity

type Attributes
  = Map String Int
