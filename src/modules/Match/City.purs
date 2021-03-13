module Match.City where

import Core.Models (BoardSquare)
import Match.Force as Force 

newtype Id = Id String
newtype Name = CityName String
type City
  = { id :: Id
    , name :: Name 
    , type_ :: Type
    , pos :: BoardSquare
    , controlledBy :: Force.Id
    }

data Type
  = Castle
  | Town
  | Village


