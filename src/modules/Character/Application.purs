module Character.Application where

import Character.Domain
import Job.Domain (fighter)

createCharacter :: String -> Int -> Character
createCharacter s age =
  { id: Id s
  , name: Name s
  , job: fighter
  , age
  , hp: createHitPoints 20
  }


