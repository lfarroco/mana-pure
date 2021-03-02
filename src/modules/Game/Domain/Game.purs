module Game.Domain where

import Prelude

data ScreenName = MainScreen | MapListScreen

data Game = Game {
  currentScreen:: ScreenName
}

data Options = Options {
  volume:: Volume
}

type Music = Number
type Audio = Number
type General = Number

data Volume = Volume {

  music::Music,
  audio:: Audio,
  general::General
}

-- initialState:: Game
-- initialState = Game {
--   currentScreen: MainScreen
-- }
