module Character.Infrastructure where

import Character.Application (CharacterIndex, createCharacter)
import Data.Map (empty, insert)
import Prelude ((#))

characterIndex :: CharacterIndex
characterIndex =
  empty # insert "id1" (createCharacter "eeea")
    # insert "id2" (createCharacter "bbb")
    # insert "id3" (createCharacter "ccc")
    # insert "id4" (createCharacter "ddd")
