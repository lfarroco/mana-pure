module Hero.Model where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)
import Data.Map (Map)
import Job.Model (Job)

type Id = String

type Hero
  = { id :: Id 
    , name :: String
    , job :: Job
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
