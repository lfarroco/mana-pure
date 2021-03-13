module Match.Domain.Squad where

import Character.Domain as Character
import Matrix (Matrix)

type Squad
  = { board :: Matrix Character.Id
    , leader :: Character.Id
    }
