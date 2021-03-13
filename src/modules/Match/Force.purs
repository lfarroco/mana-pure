module Match.Force where

import Character.Domain as Character
import Core.Models (IndexOf)
import Match.Squad (Squad)

newtype Id = Id String

newtype Color = Color String

type Force
  = { name :: Id
    , color :: Color
    , characters :: IndexOf Character.Id
    , squads :: IndexOf Squad
    }


