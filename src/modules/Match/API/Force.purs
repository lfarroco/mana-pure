module Match.API.Force where

import Match.Model.Force

import Hero.Model (Hero)
import Data.Map (empty, insert)
import Match.Model.Squad (Squad)


createForce :: String -> String -> String -> Force
createForce id_ name color =
  { id: Id id_
  , name: Name name
  , color: Color color
  , squads: empty
  , heroes: empty
  }

addHero:: Hero -> Force -> Force
addHero hero force =
  force { heroes= insert hero.id hero force.heroes}

addSquad:: Squad -> Force -> Force
addSquad squad force =
  force { squads = insert squad.leader squad force.squads}

