module Match.Model.City where

import Core.Models (BoardSquare)
import Match.Model.Force as Force 

newtype Id = Id String
newtype Name = CityName String

type City
  = { id :: Id
    , name :: Name 
    , type_ :: CityType
    , pos :: BoardSquare
    , controlledBy :: Force.Id
    }

data CityType
  = Castle
  | Town
  | Village


