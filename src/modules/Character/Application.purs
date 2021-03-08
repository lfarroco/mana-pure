module Character.Application where

import Character.Domain
import Data.Map (Map)

type CharacterIndex
  = Map String Character

createCharacter :: String -> Character
createCharacter s =
  { name: s
  , job: "fighter"
  , age: 22
  , str: 11
  , hp: 33
  }
