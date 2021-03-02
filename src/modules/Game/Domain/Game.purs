module Game.Domain where

import Core.BoundedNumber (BoundedNumber, createBoundedNumber)

data ScreenName = MainScreen | UnitListScreen

newtype Screen = Screen {
  name :: ScreenName,
  ui:: Int
}

newtype Game = Game {
  currentScreen:: Screen,
  options:: Options,
  uiScale:: BoundedNumber
}

data Options = Options {
  volume:: Volume
}

type Music = BoundedNumber
type Audio = BoundedNumber
type General = BoundedNumber

data Volume = Volume {
  music::Music,
  audio:: Audio,
  general::General
}

initialVolume:: Volume
initialVolume = Volume{
  music: createBoundedNumber 0 100 100,
  audio: createBoundedNumber 0 100 100 ,
  general: createBoundedNumber 0 100 100
}

mainScreen :: Screen
mainScreen = Screen {name: MainScreen, ui: 22}

initialGame:: Game
initialGame = Game {
  currentScreen: mainScreen,
  options: Options { volume: initialVolume },
  uiScale: createBoundedNumber 0 100 50
}
