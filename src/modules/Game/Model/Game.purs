module Game.Domain where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)

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
