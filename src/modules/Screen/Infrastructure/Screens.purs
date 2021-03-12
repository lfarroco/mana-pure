module Screen.Infrastructure.Screens where

import Prelude
import Character.Infrastructure (characterIndex)
import Data.Map (Map, empty, insert)
import Game.Domain.Element (Element)
import Screen.Infrastructure.CharaTest (charaTest)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.MapScreen (mapScreen)
import Screen.Infrastructure.UnitList (unitListScreen)

screenIndex :: forall a. Map String (Element a)
screenIndex =
  empty
    # insert "mainScreen" mainScreen
    # insert "unitListScreen" (unitListScreen characterIndex)
    # insert "charaTest" charaTest
    # insert "mapScreen" mapScreen
