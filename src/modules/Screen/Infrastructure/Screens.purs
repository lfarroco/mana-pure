module Screen.Infrastructure.Screens where

import Prelude

import Data.Map (Map, empty, insert)
import Effect.Ref (Ref)
import Game.Domain.Element (Element)
import Game.Infrasctruture.PhaserState (PhaserState)
import Screen.Infrastructure.CharaTest (charaTest)
import Screen.Infrastructure.MainScreen (mainScreen)
import Screen.Infrastructure.MapScreen (mapScreen)
import Screen.Infrastructure.UnitList (unitListScreen)

screenIndex :: Ref PhaserState -> Map String (Element PhaserState)
screenIndex a =
  empty
    # insert "mainScreen" ( mainScreen a)
    # insert "unitListScreen" ( unitListScreen a)
    # insert "charaTest"  (charaTest a)
    # insert "mapScreen" (mapScreen a)
