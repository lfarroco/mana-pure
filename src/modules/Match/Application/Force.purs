module Match.Application.Force where

import Match.Domain.Force

import Character.Domain as Character
import Data.Map (empty, insert)
import Match.Domain.Squad (Squad)


createForce :: String -> String -> String -> Force
createForce id_ name color =
  { id: Id id_
  , name: Name name
  , color: Color color
  , squads: empty
  , characters: empty
  }

addCharacter:: Character.Character -> Force -> Force
addCharacter character force =
  force { characters= insert character.id character force.characters}

addSquad:: Squad -> Force -> Force
addSquad squad force =
  force { squads = insert squad.leader squad force.squads}

