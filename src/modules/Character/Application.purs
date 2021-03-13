module Character.Application where

import Character.Domain
import Data.Map (Map)
import Job.Domain (fighter)

type CharacterIndex
  = Map String Character

createCharacter :: String -> Int -> Character
createCharacter s age =
  { id: s
  , name: s
  , job: fighter
  , age
  , hp: createHitPoints 20
  }
