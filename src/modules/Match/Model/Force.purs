module Match.Model.Force where

import Prelude

import Hero.Model (Hero)
import Hero.Model as Hero
import Match.Model.Squad (Squad)

import Data.Map (Map)

newtype Id
  = Id String

derive instance eqId :: Eq Id
derive instance ordId :: Ord Id

newtype Name
  = Name String

newtype Color
  = Color String

type Force
  = { id :: Id
    , name :: Name
    , color :: Color
    , heroes :: Map Hero.Id Hero
    , squads :: Map Hero.Id Squad
    }
