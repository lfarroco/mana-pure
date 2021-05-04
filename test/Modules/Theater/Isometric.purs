module Test.Theater.Isometric where

import Prelude
import Core.Models (boardSquare, vec)
import Effect (Effect)
import Effect.Class.Console (log)
import Screen.Theater.Isometric (cartesianToIsometric)
import Test.Assert (assertEqual)

isometricTests :: Effect Unit
isometricTests =
  void do
    log "Test.Theater.Isometric"
    log "    cartesianToIsometric"
    log "        Should create expected vectors"
    assertEqual
      { actual: (cartesianToIsometric (vec 100 200) (boardSquare 1 1))
      , expected: ({ x: 100.0, y: 164.0 })
      }
    assertEqual
      { actual: (cartesianToIsometric (vec 100 200) (boardSquare 1 2))
      , expected: ({ x: 36.0, y: 196.0 })
      }
