module Match.Domain.Force where

import Prelude

import Character.Domain (Character)
import Character.Domain as Character
import Core.Models (IndexOf)
import Data.Map (Map)
import Match.Domain.Squad (Squad)

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
    , characters :: Map Character.Id Character
    , squads :: Map Character.Id Squad
    }
