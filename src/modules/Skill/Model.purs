module Skill.Model where

import Prelude
import Core.BoundedNumber (BoundedNumber, createBoundedNumber)
import Hero.Model (Hero)
import Core.Models (Vector)

data Allegiance
  = Enemy
  | Ally
  | Self

data HitArea
  = Single
  | Multiple (Array Vector)
  | Row
  | Column
  | All

newtype BetweenZeroAndOneHundred
  = BetweenZeroAndOneHundred BoundedNumber

between0And100 :: Int -> BetweenZeroAndOneHundred
between0And100 v = BetweenZeroAndOneHundred $ createBoundedNumber 0 100 v

data SkillEffect
  = Damage BetweenZeroAndOneHundred
  | Heal BetweenZeroAndOneHundred
  | Move Vector

data TargetingType
  = Melee
  | Ranged
  | Any

type ListOf
  = Array

type Self
  = Hero

type Target
  = Hero

type Name
  = String

type Skill
  = { name :: Name
    , targets :: Allegiance
    , hitArea :: HitArea
    , effect :: ListOf (Self -> Target -> SkillEffect)
    , targetingType :: TargetingType
    }

slash :: Skill
slash =
  { name: "Slash"
  , targets: Enemy
  , hitArea: Single
  , effect: [ \s e -> Damage $ between0And100 10 ]
  , targetingType: Melee
  }
