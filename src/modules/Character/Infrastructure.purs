module Character.Infrastructure where

import Character.Application (CharacterIndex, createCharacter)
import Data.Map (empty, insert)
import Prelude ((#))

characterIndex :: CharacterIndex
characterIndex =
  empty # insert "id1" (createCharacter "id1" 1)
    # insert "id2" (createCharacter "id2" 2)
    # insert "id3" (createCharacter "id3" 3)
    # insert "id4" (createCharacter "id4" 4)
