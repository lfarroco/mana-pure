module Job.Domain where

newtype Job
  = Job
  { name :: String
  , skills :: Array String
  }
