module Match.Model.Match where

import Data.Map (Map)
import Match.Model.Battlefield (Battlefield)
import Match.Model.Force as Force

type Match
  = { forces :: Map Force.Id Force.Force
    , battlefield :: Battlefield
    }
