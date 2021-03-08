module Character.Application where

import Character.Domain

createCharacter :: String -> Character
createCharacter s =
  Character
    { name: s
    , job: "fighter"
    , age: 22
    , str: 11
    , hp: 33
    }
