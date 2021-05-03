module Job.Model where

newtype Job
  = Job
  { name :: String
  , skills :: Array String
  }

fighter :: Job
fighter = Job { name: "Fighter", skills: [ "slash" ] }
