module Character.Infrastructure where

import Character.Application (createCharacter)
import Character.Domain (Character)
import Data.Map (Map, empty, insert)
import Prelude ((#))

characterIndex :: Map String Character
characterIndex =
  empty # insert "id1" (createCharacter "eeea")
    # insert "id2" (createCharacter "bbb")
    # insert "id3" (createCharacter "ccc")
    # insert "id4" (createCharacter "ddd")
