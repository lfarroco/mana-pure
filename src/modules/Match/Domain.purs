module Match.Domain where

import Core.Models (IndexOf)
import Match.Battlefield (Battlefield)
import Match.Force (Force)

type Match
  = { forces :: IndexOf Force
    , battlefield :: Battlefield
    }
