module Game.Domain where

import Core.BoundedNumber (BoundedNumber, createBoundedNumber)

data ScreenName = MainScreen | MapListScreen

data Game = Game {
  currentScreen:: ScreenName,
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

initialGame:: Game
initialGame = Game {
  currentScreen: MainScreen,
  options: Options { volume: initialVolume },
  uiScale: createBoundedNumber 0 100 50
}
