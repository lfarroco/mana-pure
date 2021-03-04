module Game.Domain where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)

data ScreenName
  = MainScreen
  | UnitListScreen

instance showScreenName :: Show ScreenName where
  show (MainScreen) = show "MainScreen"
  show (UnitListScreen) = show "UnitListScreen"

newtype Screen
  = Screen
  { name :: ScreenName
  , ui :: Int
  }

instance showScreen :: Show Screen where
  show (Screen n) = show n

newtype Game
  = Game
  { currentScreen :: Screen
  , options :: Options
  , uiScale :: BoundedNumber
  , counter :: Int
  }

instance showGame :: Show Game where
  show (Game n) = show n

data Options
  = Options
    { volume :: Volume
    }

instance showOptions :: Show Options where
  show (Options n) = show n

type Music
  = BoundedNumber

type Audio
  = BoundedNumber

type General
  = BoundedNumber

data Volume
  = Volume
    { music :: Music
    , audio :: Audio
    , general :: General
    }

instance showVolume :: Show Volume where
  show (Volume n) = show n

initialVolume :: Volume
initialVolume =
  Volume
    { music: createBoundedNumber 0 100 100
    , audio: createBoundedNumber 0 100 100
    , general: createBoundedNumber 0 100 100
    }

createScreen :: ScreenName -> Int -> Screen
createScreen name ui = Screen { name, ui }

mainScreen :: Screen
mainScreen = createScreen MainScreen 22

initialGame :: Game
initialGame =
  Game
    { currentScreen: mainScreen
    , options: Options { volume: initialVolume }
    , uiScale: createBoundedNumber 0 100 50
    , counter: 1
    }

createGame :: Int -> Game
createGame c =
  Game
    { currentScreen: mainScreen
    , options: Options { volume: initialVolume }
    , uiScale: createBoundedNumber 0 100 50
    , counter: c
    }

getCounter :: Game -> Int
getCounter (Game g) = g.counter

updateCounter :: Game -> Game
updateCounter (Game g) = Game g { counter = g.counter + 1 }
