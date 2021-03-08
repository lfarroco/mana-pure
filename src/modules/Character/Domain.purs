module Character.Domain where

type Character
  = { id :: String
    , name :: String
    , job :: String
    , age :: Int
    , str :: Int
    , hp :: Int
    }
