module Match.API.Match where

import Data.Map (empty, insert)
import Match.API.Battlefield (createBattlefield)
import Match.Model.Force (Force)
import Match.Model.Match (Match)


createMatch :: Int -> Int -> Match
createMatch width height =
  { forces: empty
  , battlefield: createBattlefield width height
  }

addForce :: Force -> Match -> Match
addForce force match = match { forces = insert force.id force match.forces }
