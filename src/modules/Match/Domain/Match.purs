module Match.Domain.Match where

import Data.Map (Map)
import Match.Domain.Battlefield (Battlefield)
import Match.Domain.Force as Force

type Match
  = { forces :: Map Force.Id Force.Force
    , battlefield :: Battlefield
    }
