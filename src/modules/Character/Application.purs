module Character.Application where

import Character.Domain
import Data.Map (Map)
import Job.Domain (fighter)

type CharacterIndex
  = Map String Character

createCharacter :: String -> Character
createCharacter s =
  { id: s
  , name: s
  , job: fighter
  , age: 22
  , hp: createHitPoints 20
  }
