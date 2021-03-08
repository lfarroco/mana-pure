module Character.Domain where

newtype Character
  = Character
  { name :: String
  , job :: String
  , age :: Int
  , str :: Int
  , hp :: Int
  }
