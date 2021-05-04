module Game.Infrastructure.Assets where

assets ::
  { png :: Array String
  , svg :: Array String
  }
assets =
  { svg:
      [ "backgrounds/sunset"
      , "chara/head_male"
      , "chara/head_female"
      , "chara/trunk_fighter"
      , "chara/hand"
      , "chara/foot"
      , "chara/hair/male1"
      , "chara/hair/male1_back"
      , "equips/iron_sword"
      , "equips/iron_helm"
      , "equips/iron_spear"
      , "equips/iron_shield"
      ]
  , png:
      [ "tilemaps/kenney_64x64"
      ]
  }
