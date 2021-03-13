module Screen.Infrastructure.Screens where

import Prelude

import Data.Map (Map, empty, insert)
import Game.Domain.Element (Element)
import Game.Infrasctruture.PhaserState (PhaserState)
import Screen.Infrastructure.CharaTest (charaTest)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.MapScreen (mapScreen)
import Screen.Infrastructure.UnitList (unitListScreen)

screenIndex :: PhaserState -> Map String (Element PhaserState)
screenIndex state =
  empty
    # insert "mainScreen" ( mainScreen state)
    # insert "unitListScreen" ( unitListScreen state)
    # insert "charaTest"  (charaTest state)
    # insert "mapScreen" (mapScreen state)
