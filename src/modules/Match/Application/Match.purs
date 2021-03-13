module Match.Application.Match where

import Data.Map (empty, insert)
import Match.Application.Battlefield (createBattlefield)
import Match.Domain.Force (Force)
import Match.Domain.Match (Match)

createMatch :: Int -> Int -> Match
createMatch width height =
  { forces: empty
  , battlefield: createBattlefield width height
  }

addForce :: Force -> Match -> Match
addForce force match = match { forces = insert force.id force match.forces }
