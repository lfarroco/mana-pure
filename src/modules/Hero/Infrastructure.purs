module Hero.Infrastructure where

import Hero.API (createHero)
import Hero.Model (Hero)
import Core.Models (IndexOf)
import Data.Map (empty, insert)
import Prelude ((#))

heroIndex :: IndexOf Hero
heroIndex =
  empty # insert "id1" (createHero "id1")
    # insert "id2" (createHero "id2")
    # insert "id3" (createHero "id3")
    # insert "id4" (createHero "id4")
