module Hero.API where

import Hero.Model
import Job.Model (fighter)

createHero :: String -> Hero
createHero s =
  { id: s
  , name: s
  , job: fighter
  , hp: createHitPoints 20
  }


