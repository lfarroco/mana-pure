module Match.Model.Squad where

import Hero.Model as Hero
import Matrix (Matrix)

type Squad
  = { board :: Matrix Hero.Id
    , leader :: Hero.Id
    }
