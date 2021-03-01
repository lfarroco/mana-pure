module Game.Domain where

import Prelude

data ScreenName = MainScreen | MapListScreen

data Game = Game {
  currentScreen:: ScreenName
}

initialState:: Game
initialState = Game {
  currentScreen: MainScreen
}
