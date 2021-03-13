module Character.Infrastructure where

import Character.Application (createCharacter)
import Character.Domain (Character)
import Core.Models (IndexOf)
import Data.Map (empty, insert)
import Prelude ((#))

characterIndex :: IndexOf Character
characterIndex =
  empty # insert "id1" (createCharacter "id1" 1)
    # insert "id2" (createCharacter "id2" 2)
    # insert "id3" (createCharacter "id3" 3)
    # insert "id4" (createCharacter "id4" 4)
